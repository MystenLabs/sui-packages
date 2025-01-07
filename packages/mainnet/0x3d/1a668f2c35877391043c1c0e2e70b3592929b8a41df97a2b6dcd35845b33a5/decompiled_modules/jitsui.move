module 0x3d1a668f2c35877391043c1c0e2e70b3592929b8a41df97a2b6dcd35845b33a5::jitsui {
    struct JITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JITSUI>(arg0, 6, b"Jitsui", b"Jiu Jitsui", b"The Shark of the Mats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/86727_DDF_D8_DA_4_A4_C_96_E9_05563837864_B_1a209cf560.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JITSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JITSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

