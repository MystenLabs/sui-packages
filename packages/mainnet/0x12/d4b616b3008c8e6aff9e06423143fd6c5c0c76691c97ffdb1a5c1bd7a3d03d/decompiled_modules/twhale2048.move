module 0x12d4b616b3008c8e6aff9e06423143fd6c5c0c76691c97ffdb1a5c1bd7a3d03d::twhale2048 {
    struct TWHALE2048 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWHALE2048, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWHALE2048>(arg0, 9, b"TWHALE2048", b"TWHALE", b"Twhale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b9c65fd-7e4b-40d5-97cd-d63c30e42968.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWHALE2048>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWHALE2048>>(v1);
    }

    // decompiled from Move bytecode v6
}

