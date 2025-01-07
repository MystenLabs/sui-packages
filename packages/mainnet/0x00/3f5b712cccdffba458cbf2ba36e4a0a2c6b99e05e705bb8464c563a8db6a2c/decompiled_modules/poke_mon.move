module 0x3f5b712cccdffba458cbf2ba36e4a0a2c6b99e05e705bb8464c563a8db6a2c::poke_mon {
    struct POKE_MON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKE_MON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKE_MON>(arg0, 9, b"POKE_MON", b"Pokemon", b"For Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5b85b9b-d307-4f1d-a9f1-9c2632c916fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKE_MON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKE_MON>>(v1);
    }

    // decompiled from Move bytecode v6
}

