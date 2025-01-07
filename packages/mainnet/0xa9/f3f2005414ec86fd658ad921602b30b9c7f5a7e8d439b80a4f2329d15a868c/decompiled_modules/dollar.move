module 0xa9f3f2005414ec86fd658ad921602b30b9c7f5a7e8d439b80a4f2329d15a868c::dollar {
    struct DOLLAR has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<DOLLAR>,
    }

    public fun burn(arg0: &mut CapWrapper, arg1: 0x2::coin::Coin<DOLLAR>) : u64 {
        0x2::coin::burn<DOLLAR>(&mut arg0.cap, arg1)
    }

    public(friend) fun mint(arg0: &mut CapWrapper, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DOLLAR> {
        0x2::coin::mint<DOLLAR>(&mut arg0.cap, arg1, arg2)
    }

    fun init(arg0: DOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLAR>(arg0, 9, b"SUID", b"Sui Dollar", b"Stable coin issued by Sui Bank", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = CapWrapper{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<CapWrapper>(v2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLLAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

