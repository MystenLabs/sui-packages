module 0xf53742b8e3b34d84b52c1ee57bda6505d41d3b5de400a430de9748b982f84fc::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 9, b"BSUI", b"BABYSUI", b"This is a baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70136007-9c4b-4537-a1cc-49140219e88d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

