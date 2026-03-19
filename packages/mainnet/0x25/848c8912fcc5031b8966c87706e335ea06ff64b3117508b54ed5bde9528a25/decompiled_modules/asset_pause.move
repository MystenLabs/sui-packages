module 0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::DragonBallCollector, arg1: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ProtocolApp, arg2: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_functional(arg0);
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::asset_admin::update_asset_paused_state<T0, T1>(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::roles::SuperAdminRole, arg1: &0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::DragonBallCollector, arg2: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ProtocolApp, arg3: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>, arg4: u8) {
        0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::ensure_functional(arg1);
        0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::asset_admin::update_asset_paused_state<T0, T1>(0x25848c8912fcc5031b8966c87706e335ea06ff64b3117508b54ed5bde9528a25::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

