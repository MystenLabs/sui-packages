module 0xac3e7a62bb4f9aed2672c99fe333883d8cddf782ccc14c42dbbb3f91192085a::sbnation {
    struct SBNATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBNATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBNATION>(arg0, 6, b"SBNATION", b"SB NATION", b"FIRST MEME GENERATOR ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SBNATION_f4f282734d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBNATION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBNATION>>(v1);
    }

    // decompiled from Move bytecode v6
}

