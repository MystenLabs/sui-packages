module 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault {
    struct NaviSubVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        asset_id: u8,
        deposits_open: bool,
    }

    public fun asset_id<T0, T1>(arg0: &NaviSubVault<T0, T1>) : u8 {
        arg0.asset_id
    }

    public(friend) fun create_vault<T0, T1>(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviSubVault<T0, T1>{
            id            : 0x2::object::new(arg1),
            asset_id      : arg0,
            deposits_open : true,
        };
        0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_events::navi_vault_created<T0, T1>(0x2::object::id_address<NaviSubVault<T0, T1>>(&v0));
        0x2::transfer::share_object<NaviSubVault<T0, T1>>(v0);
    }

    public fun deposits_open<T0, T1>(arg0: &NaviSubVault<T0, T1>) : bool {
        arg0.deposits_open
    }

    public(friend) fun toggle_deposits<T0, T1>(arg0: &mut NaviSubVault<T0, T1>, arg1: bool) {
        arg0.deposits_open = arg1;
    }

    public(friend) fun uid<T0, T1>(arg0: &mut NaviSubVault<T0, T1>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

