module 0xc6b0047bfd89ee7464b82e423993f943bb958246e82e794a553e0ca41b60ab46::toli {
    struct TOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOLI>(arg0, 6, b"TOLI", b"Toli", b"The government may lie to you, Toli won't", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_07_01_T212227_287_9a767fdf6e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

