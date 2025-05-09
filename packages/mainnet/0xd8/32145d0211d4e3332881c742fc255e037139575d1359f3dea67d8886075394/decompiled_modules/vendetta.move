module 0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta {
    struct VENDETTA has drop {
        dummy_field: bool,
    }

    struct CoinRegistry has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<VENDETTA>,
    }

    struct VBalance has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<VENDETTA>,
    }

    public fun burn(arg0: &mut CoinRegistry, arg1: 0x2::coin::Coin<VENDETTA>) {
        0x2::coin::burn<VENDETTA>(&mut arg0.treasury, arg1);
    }

    public fun total_supply(arg0: &CoinRegistry) : u64 {
        0x2::coin::total_supply<VENDETTA>(&arg0.treasury)
    }

    fun init(arg0: VENDETTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENDETTA>(arg0, 9, b"V", b"Token V", b"V token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VENDETTA>>(v1);
        let v2 = CoinRegistry{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::share_object<CoinRegistry>(v2);
        let v3 = VBalance{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<VENDETTA>(),
        };
        0x2::transfer::share_object<VBalance>(v3);
    }

    public fun mint_token(arg0: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::role::AdminCap, arg1: &mut CoinRegistry, arg2: &mut VBalance, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<VENDETTA>(&arg1.treasury) == 0, 1);
        0x2::balance::join<VENDETTA>(&mut arg2.balance, 0x2::coin::into_balance<VENDETTA>(0x2::coin::mint<VENDETTA>(&mut arg1.treasury, 10000000000000000, arg3)));
    }

    public fun unlock_token(arg0: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::role::AdminCap, arg1: &mut VBalance, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VENDETTA> {
        0x2::coin::from_balance<VENDETTA>(0x2::balance::split<VENDETTA>(&mut arg1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

