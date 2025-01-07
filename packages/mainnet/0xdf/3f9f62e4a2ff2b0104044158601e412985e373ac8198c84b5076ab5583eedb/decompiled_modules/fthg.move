module 0xdf3f9f62e4a2ff2b0104044158601e412985e373ac8198c84b5076ab5583eedb::fthg {
    struct FTHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTHG>(arg0, 9, b"FTHG", b"Faith", b"Claim and cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69819043-8f28-445d-b585-d7fa950dff88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

