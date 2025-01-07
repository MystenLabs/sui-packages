module 0xc536e3b665db1bdea19f43083bc2d2e89b87ada9cacc1674e9d7fa82d4bcc7d5::oekeb {
    struct OEKEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OEKEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OEKEB>(arg0, 9, b"OEKEB", b"hsjdn", b"bebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bb95967-79ae-4557-9a5a-ec9558f24cc7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OEKEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OEKEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

