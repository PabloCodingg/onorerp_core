---@author Pablo Z.
---@version 1.0
--[[
  This file is part of Onore RolePlay.
  
  File [jobsManager] created at [17/04/2021 21:15]

  Copyright (c) Onore RolePlay - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

OnoreSJobsManager = {}
OnoreSJobsManager.list = {}

MySQL.ready(function()
    MySQL.Async.fetchAll("SELECT * FROM jobs WHERE usePabloSystem = 1", {}, function(result)
        for _,job in pairs(result) do
            if not OnoreSharedCustomJobs[job.name] then
                print(Onore.prefix(OnorePrefixes.jobs,("Impossible de charger le job %s"):format(job.label)))
            else
                Job(job.name, job.label)
            end
        end
    end)
end)