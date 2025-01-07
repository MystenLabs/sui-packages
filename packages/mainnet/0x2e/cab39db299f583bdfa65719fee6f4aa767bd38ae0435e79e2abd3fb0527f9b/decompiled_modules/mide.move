module 0x2ecab39db299f583bdfa65719fee6f4aa767bd38ae0435e79e2abd3fb0527f9b::mide {
    struct MIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIDE>(arg0, 9, b"MIDE", b"Ade", b"My baby ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94407878-1c96-426b-939f-f5f641e9e88b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

