module 0xdf1f2278e59c7fae009c0527632cfe2b0ba786e4d6ed655f9add8b4997d679cf::bbb {
    struct BBB has drop {
        dummy_field: bool,
    }

    struct Burner has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<BBB>,
    }

    public fun burn(arg0: &mut Burner, arg1: 0x2::coin::Coin<BBB>) {
        0x2::coin::burn<BBB>(&mut arg0.cap, arg1);
    }

    public fun borrow_cap(arg0: &Burner, arg1: &0x2::coin::CoinMetadata<BBB>) : &0x2::coin::TreasuryCap<BBB> {
        &arg0.cap
    }

    fun init(arg0: BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBB>(arg0, 9, b"BBB", b"Testing BBB Token", b"AA BBB CCCCC", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BBB>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = Burner{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::share_object<Burner>(v3);
    }

    // decompiled from Move bytecode v6
}

