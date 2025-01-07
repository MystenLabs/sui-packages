module 0x5738823af4289a19a9ab123af3b0e0902a91740f4292c8cafb940e18c7ac3cd5::KEKIUS {
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

