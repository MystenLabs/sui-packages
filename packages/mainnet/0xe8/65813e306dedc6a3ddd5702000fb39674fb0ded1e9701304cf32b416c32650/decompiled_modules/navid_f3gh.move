module 0xe865813e306dedc6a3ddd5702000fb39674fb0ded1e9701304cf32b416c32650::navid_f3gh {
    struct NAVID_F3GH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVID_F3GH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVID_F3GH>(arg0, 9, b"NAVID_F3GH", b"navid", b"Hello World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de102f85-8bac-4653-b137-d0b24bfc0d9d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVID_F3GH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAVID_F3GH>>(v1);
    }

    // decompiled from Move bytecode v6
}

