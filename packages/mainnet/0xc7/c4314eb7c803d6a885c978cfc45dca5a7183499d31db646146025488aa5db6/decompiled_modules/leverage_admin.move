module 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &mut 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::LeverageApp, arg2: 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::PackageCallerCap) {
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::ensure_version_matches(arg1);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &mut 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::LeverageApp) : u64 {
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &mut 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::LeverageApp, arg2: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::ensure_version_matches(arg1);
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>>(arg2);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::add_market(arg1, v0, arg3);
        0x2::transfer::public_share_object<0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_market::LeverageMarket>(0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::AdminCap, arg1: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::LeverageApp) {
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::ensure_version_matches(arg2);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

