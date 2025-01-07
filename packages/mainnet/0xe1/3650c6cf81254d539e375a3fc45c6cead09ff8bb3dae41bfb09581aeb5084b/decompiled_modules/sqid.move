module 0xe13650c6cf81254d539e375a3fc45c6cead09ff8bb3dae41bfb09581aeb5084b::sqid {
    struct SQID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQID>(arg0, 9, b"SQID", b"AstroSquid", b"A squid-themed space explorer.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14e3982a-7710-4e72-bbd4-f39909ce9a73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQID>>(v1);
    }

    // decompiled from Move bytecode v6
}

