module 0x19c53d4e813c86f42c4f51d8afdccf0c36e2b1902aa2f9985a3907bdd6d5b5f2::chi {
    struct CHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHI>(arg0, 6, b"CHI", b"SUICHI", b"The coolest dog on the sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_11df771791.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

