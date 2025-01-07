module 0xa8e10d6c9be0167201aa6d7fdde8b507eb4da63f32609fb434bee4211057496c::meomeo {
    struct MEOMEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOMEO>(arg0, 9, b"MEOMEO", b"memeo", b"meomeopump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3022f43d-1b14-4d2e-9580-3a22a955ff5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOMEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOMEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

