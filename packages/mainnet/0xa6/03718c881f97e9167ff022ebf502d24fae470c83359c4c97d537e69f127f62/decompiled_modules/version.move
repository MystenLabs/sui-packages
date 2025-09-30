module 0xa603718c881f97e9167ff022ebf502d24fae470c83359c4c97d537e69f127f62::version {
    public fun migrate(arg0: &mut 0xa603718c881f97e9167ff022ebf502d24fae470c83359c4c97d537e69f127f62::project_manager::ProjectManagerConfig, arg1: &mut 0xa603718c881f97e9167ff022ebf502d24fae470c83359c4c97d537e69f127f62::milestone::VestingConfig, arg2: &0xa603718c881f97e9167ff022ebf502d24fae470c83359c4c97d537e69f127f62::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0xa603718c881f97e9167ff022ebf502d24fae470c83359c4c97d537e69f127f62::launchpad_manager::LaunchpadManager) {
        0xa603718c881f97e9167ff022ebf502d24fae470c83359c4c97d537e69f127f62::project_manager::migrate(arg0);
        0xa603718c881f97e9167ff022ebf502d24fae470c83359c4c97d537e69f127f62::milestone::migrate(arg1);
        0xa603718c881f97e9167ff022ebf502d24fae470c83359c4c97d537e69f127f62::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

