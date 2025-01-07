module 0x119c7352bfe1e5edae52d6048724a36b3a1d1581f53860d6d9263bc8abd8eebb::KEKIUS {
    struct KEKIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKIUS>(arg0, 9, b"KEKIUS", b"KEKIUS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKIUS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KEKIUS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<KEKIUS>>(0x2::coin::mint<KEKIUS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

