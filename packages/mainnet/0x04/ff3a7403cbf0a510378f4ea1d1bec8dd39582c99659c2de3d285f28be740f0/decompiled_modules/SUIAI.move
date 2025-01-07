module 0x4ff3a7403cbf0a510378f4ea1d1bec8dd39582c99659c2de3d285f28be740f0::SUIAI {
    struct SUIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAI>(arg0, 9, b"SUIAI", b"SUIAI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIAI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIAI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIAI>>(0x2::coin::mint<SUIAI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

