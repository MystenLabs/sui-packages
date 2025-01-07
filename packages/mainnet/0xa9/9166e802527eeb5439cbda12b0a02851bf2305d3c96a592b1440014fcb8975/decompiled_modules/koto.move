module 0xa99166e802527eeb5439cbda12b0a02851bf2305d3c96a592b1440014fcb8975::koto {
    struct KOTO has drop {
        dummy_field: bool,
    }

    struct Gomi has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<KOTO>,
    }

    fun init(arg0: KOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOTO>(arg0, 0, b"KOTO", b"KOTO", b"The utility token of the Studio Mirai ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://sm.xyz/images/koto.webp"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KOTO>(&mut v2, 1000000000000, @0xde0053243f3226649701a7fe2c3988be11941bf3ff3535f3c8c5bf32fc600220, arg1);
        let v3 = Gomi{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::freeze_object<Gomi>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

