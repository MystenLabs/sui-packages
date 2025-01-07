module 0xc6cea005195546e9e40ba83d41c103c1593911e1d9c469128bb1b6e8a07fc9cd::gfsdfsdfs {
    struct GFSDFSDFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFSDFSDFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFSDFSDFS>(arg0, 9, b"GFSDFSDFS", b"dfdfsdf", b"sdfsdfsfs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b409ef0d-262a-4af0-86a5-9b0f352504c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFSDFSDFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFSDFSDFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

