module 0xd1b90bc981703327d76e357e5e0be7c8628a1ed47e3a2c52593611db1d72a462::sboy {
    struct SBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOY>(arg0, 6, b"SBOY", b"Sui Boy", b"don't be one - own some", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_I_Ln_ZL_Oymg_Fw_Qs_ZRG_f85ca85932.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

