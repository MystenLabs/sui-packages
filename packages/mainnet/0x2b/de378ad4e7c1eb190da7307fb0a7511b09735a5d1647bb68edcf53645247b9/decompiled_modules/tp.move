module 0x2bde378ad4e7c1eb190da7307fb0a7511b09735a5d1647bb68edcf53645247b9::tp {
    struct TP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TP>(arg0, 9, b"TP", b"Teppi", x"53696575207175e1baad79205465707069", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93294212-6d78-4a6b-b619-a042ad6a1e34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TP>>(v1);
    }

    // decompiled from Move bytecode v6
}

