module 0x17680fe1e84c217f540095e10664596ac9e2ad9a23b3192a5409862fa20cc337::lol_onsui {
    struct LOL_ONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL_ONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL_ONSUI>(arg0, 9, b"LOL_ONSUI", b"LOL", b"Trump will win", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b260e249-058e-4928-a4f4-eb2652e063f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL_ONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOL_ONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

