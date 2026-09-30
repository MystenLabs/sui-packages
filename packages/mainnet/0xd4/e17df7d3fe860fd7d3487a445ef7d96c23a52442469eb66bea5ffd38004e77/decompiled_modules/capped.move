module 0xd4e17df7d3fe860fd7d3487a445ef7d96c23a52442469eb66bea5ffd38004e77::capped {
    struct CappedTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<T0>,
        minted: u64,
        max: u64,
    }

    struct MinterCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::object::ID,
    }

    struct Locked has copy, drop {
        treasury: 0x2::object::ID,
        minted: u64,
        max: u64,
        supply: u64,
    }

    struct Minted has copy, drop {
        treasury: 0x2::object::ID,
        amount: u64,
        minted: u64,
    }

    struct Burned has copy, drop {
        treasury: 0x2::object::ID,
        amount: u64,
    }

    public fun burn<T0>(arg0: &mut CappedTreasury<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return
        };
        0x2::coin::burn<T0>(&mut arg0.cap, arg1);
        let v1 = Burned{
            treasury : 0x2::object::id<CappedTreasury<T0>>(arg0),
            amount   : v0,
        };
        0x2::event::emit<Burned>(v1);
    }

    public fun mint<T0>(arg0: &mut CappedTreasury<T0>, arg1: &MinterCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.treasury == 0x2::object::id<CappedTreasury<T0>>(arg0), 2);
        let v0 = arg0.max - arg0.minted;
        let v1 = if (arg2 > v0) {
            v0
        } else {
            arg2
        };
        if (v1 == 0) {
            return 0x2::coin::zero<T0>(arg3)
        };
        arg0.minted = arg0.minted + v1;
        let v2 = Minted{
            treasury : 0x2::object::id<CappedTreasury<T0>>(arg0),
            amount   : v1,
            minted   : arg0.minted,
        };
        0x2::event::emit<Minted>(v2);
        0x2::coin::mint<T0>(&mut arg0.cap, v1, arg3)
    }

    public fun total_supply<T0>(arg0: &CappedTreasury<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.cap)
    }

    public fun update_description<T0>(arg0: &CappedTreasury<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String) {
        0x2::coin::update_description<T0>(&arg0.cap, arg1, arg2);
    }

    public fun update_icon_url<T0>(arg0: &CappedTreasury<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<T0>(&arg0.cap, arg1, arg2);
    }

    public fun lock<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : MinterCap<T0> {
        let v0 = 0x2::coin::total_supply<T0>(&arg0);
        assert!(arg1 >= v0 && arg1 <= arg2, 1);
        let v1 = CappedTreasury<T0>{
            id     : 0x2::object::new(arg3),
            cap    : arg0,
            minted : arg1,
            max    : arg2,
        };
        let v2 = 0x2::object::id<CappedTreasury<T0>>(&v1);
        let v3 = Locked{
            treasury : v2,
            minted   : arg1,
            max      : arg2,
            supply   : v0,
        };
        0x2::event::emit<Locked>(v3);
        0x2::transfer::share_object<CappedTreasury<T0>>(v1);
        MinterCap<T0>{
            id       : 0x2::object::new(arg3),
            treasury : v2,
        }
    }

    public fun max<T0>(arg0: &CappedTreasury<T0>) : u64 {
        arg0.max
    }

    public fun minted<T0>(arg0: &CappedTreasury<T0>) : u64 {
        arg0.minted
    }

    public fun room<T0>(arg0: &CappedTreasury<T0>) : u64 {
        arg0.max - arg0.minted
    }

    public fun treasury_cap<T0>(arg0: &CappedTreasury<T0>) : &0x2::coin::TreasuryCap<T0> {
        &arg0.cap
    }

    public fun treasury_of<T0>(arg0: &MinterCap<T0>) : 0x2::object::ID {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

