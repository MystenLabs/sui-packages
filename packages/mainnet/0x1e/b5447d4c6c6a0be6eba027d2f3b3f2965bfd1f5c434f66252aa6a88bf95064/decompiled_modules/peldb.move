module 0x1eb5447d4c6c6a0be6eba027d2f3b3f2965bfd1f5c434f66252aa6a88bf95064::peldb {
    struct PELDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELDB>(arg0, 9, b"PELDB", b"jeneb", b"vebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7aacbe9a-96b1-45f8-b72d-1b5a3dd905e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PELDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

