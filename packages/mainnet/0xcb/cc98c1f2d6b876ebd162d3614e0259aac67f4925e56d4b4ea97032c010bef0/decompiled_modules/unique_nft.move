module 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::unique_nft {
    struct Collection<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        minted: u64,
        max_supply: u64,
        frozen: bool,
    }

    public fun account_migrated<T0>(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<T0>, arg1: &mut Collection<T0>, arg2: u64, arg3: address) {
        assert_version<T0>(arg1);
        assert!(arg1.minted < arg1.max_supply, 13906834530825666561);
        arg1.minted = arg1.minted + 1;
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::events::collection_mint<T0>(arg2, arg3);
    }

    fun assert_version<T0>(arg0: &Collection<T0>) {
        assert!(arg0.version == 1, 13906834423451877383);
    }

    public fun create_and_share<T0>(arg0: &T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection<T0>{
            id         : 0x2::object::new(arg2),
            version    : 1,
            minted     : 0,
            max_supply : arg1,
            frozen     : false,
        };
        0x2::transfer::share_object<Collection<T0>>(v0);
    }

    public fun freeze_supply<T0>(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<T0>, arg1: &mut Collection<T0>) {
        assert_version<T0>(arg1);
        arg1.frozen = true;
    }

    public fun is_frozen<T0>(arg0: &Collection<T0>) : bool {
        arg0.frozen
    }

    public fun max_supply<T0>(arg0: &Collection<T0>) : u64 {
        arg0.max_supply
    }

    public fun migrate<T0>(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<T0>, arg1: &mut Collection<T0>) {
        assert!(arg1.version < 1, 13906834449221812233);
        arg1.version = 1;
    }

    public fun minted<T0>(arg0: &Collection<T0>) : u64 {
        arg0.minted
    }

    public fun next_number<T0>(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<T0>, arg1: &mut Collection<T0>, arg2: address) : u64 {
        assert_version<T0>(arg1);
        assert!(arg1.minted < arg1.max_supply, 13906834483581026305);
        arg1.minted = arg1.minted + 1;
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::events::collection_mint<T0>(arg1.minted, arg2);
        arg1.minted
    }

    public fun remaining<T0>(arg0: &Collection<T0>) : u64 {
        arg0.max_supply - arg0.minted
    }

    public fun set_max_supply<T0>(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<T0>, arg1: &mut Collection<T0>, arg2: u64) {
        assert_version<T0>(arg1);
        assert!(!arg1.frozen, 13906834565185667077);
        assert!(arg2 >= arg1.minted, 13906834569480503299);
        arg1.max_supply = arg2;
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::events::max_supply_changed<T0>(arg1.max_supply, arg2);
    }

    public fun version<T0>(arg0: &Collection<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

