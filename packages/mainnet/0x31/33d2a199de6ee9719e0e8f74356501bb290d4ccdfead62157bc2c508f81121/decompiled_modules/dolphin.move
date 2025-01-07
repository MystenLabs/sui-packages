module 0x3133d2a199de6ee9719e0e8f74356501bb290d4ccdfead62157bc2c508f81121::dolphin {
    struct DOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHIN>(arg0, 9, b"DOLPHIN", b"Sui Dolphin", b"Dolphin in the water!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOLPHIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

