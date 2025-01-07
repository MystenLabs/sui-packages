module 0x523172db1121b9f681a61513a53514ca356376dfe11a038f0a6ed9a81b7c1e1c::momocoin {
    struct MOMOCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMOCOIN>(arg0, 9, b"MOMOCOIN", b"MOMO", b"Tip coin momo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/511b23d6-bfb4-428d-984e-d53eab4f6e19.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMOCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOMOCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

