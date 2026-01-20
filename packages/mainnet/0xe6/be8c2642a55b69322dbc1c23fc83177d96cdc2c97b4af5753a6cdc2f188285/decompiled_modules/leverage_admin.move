module 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::AdminCap, arg1: &mut 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_app::LeverageApp, arg2: 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::PackageCallerCap) {
        0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::AdminCap, arg1: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_market::LeverageMarket>(0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_market::new_market(0x2::object::id<0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::AdminCap, arg1: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::ProtocolApp, arg2: &mut 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_app::LeverageApp) {
        0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

