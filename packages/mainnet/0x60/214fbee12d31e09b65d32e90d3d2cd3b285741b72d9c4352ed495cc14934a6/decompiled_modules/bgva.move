module 0x60214fbee12d31e09b65d32e90d3d2cd3b285741b72d9c4352ed495cc14934a6::bgva {
    struct BGVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGVA>(arg0, 9, b"BGVA", b"WGT", b"CZ ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c24d9a7-19d4-4d8c-9428-9bc20cd31bfe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

