module 0x2f75eaa2d632fff5ea4f119fe3c26feeca2089d1063e9a2b3ffab33d5ea2e599::iloveyou {
    struct ILOVEYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILOVEYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILOVEYOU>(arg0, 9, b"ILOVEYOU", b"I LOVE YOU", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/originals/15/9d/a9/159da90bfdadfbe80a656c6d50db37ee.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ILOVEYOU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILOVEYOU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ILOVEYOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

