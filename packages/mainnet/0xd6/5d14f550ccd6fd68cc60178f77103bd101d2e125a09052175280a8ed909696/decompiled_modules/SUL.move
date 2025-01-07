module 0xd65d14f550ccd6fd68cc60178f77103bd101d2e125a09052175280a8ed909696::SUL {
    struct SUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUL>(arg0, 9, b"SUL", b"SUL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUL>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUL>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUL>>(0x2::coin::mint<SUL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

