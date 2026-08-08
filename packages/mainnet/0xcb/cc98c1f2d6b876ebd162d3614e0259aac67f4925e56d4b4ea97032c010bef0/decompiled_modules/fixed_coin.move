module 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::fixed_coin {
    struct CappedTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        cap: 0x2::coin::TreasuryCap<T0>,
        max_supply: u64,
        minted: u64,
    }

    public fun burn<T0>(arg0: &mut CappedTreasury<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        assert_version<T0>(arg0);
        let v0 = 0x2::coin::burn<T0>(&mut arg0.cap, arg1);
        arg0.minted = arg0.minted - v0;
        v0
    }

    fun assert_version<T0>(arg0: &CappedTreasury<T0>) {
        assert!(arg0.version == 1, 13906834376206974979);
    }

    public fun finalize<T0>(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<T0>, arg1: CappedTreasury<T0>) {
        assert_version<T0>(&arg1);
        let CappedTreasury {
            id         : v0,
            version    : _,
            cap        : v2,
            max_supply : _,
            minted     : _,
        } = arg1;
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(v2);
        0x2::object::delete(v0);
    }

    public fun max_supply<T0>(arg0: &CappedTreasury<T0>) : u64 {
        arg0.max_supply
    }

    public fun migrate<T0>(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<T0>, arg1: &mut CappedTreasury<T0>) {
        assert!(arg1.version < 1, 13906834401976909829);
        arg1.version = 1;
    }

    public fun mint_capped<T0>(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<T0>, arg1: &mut CappedTreasury<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg1);
        assert!(arg2 <= arg1.max_supply - arg1.minted, 13906834453516255233);
        arg1.minted = arg1.minted + arg2;
        0x2::coin::mint<T0>(&mut arg1.cap, arg2, arg3)
    }

    public fun minted<T0>(arg0: &CappedTreasury<T0>) : u64 {
        arg0.minted
    }

    public fun remaining<T0>(arg0: &CappedTreasury<T0>) : u64 {
        arg0.max_supply - arg0.minted
    }

    public fun version<T0>(arg0: &CappedTreasury<T0>) : u64 {
        arg0.version
    }

    public fun wrap<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : CappedTreasury<T0> {
        CappedTreasury<T0>{
            id         : 0x2::object::new(arg2),
            version    : 1,
            cap        : arg0,
            max_supply : arg1,
            minted     : 0,
        }
    }

    // decompiled from Move bytecode v7
}

