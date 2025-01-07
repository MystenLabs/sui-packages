module 0x3e5220320910dc5a94f72bf27debecf15b8a43fe253cbe9d40fce8fb9ff08728::baksosui {
    struct BAKSOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKSOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKSOSUI>(arg0, 6, b"BAKSOSUI", b"BAKSO SUI TIGER", b"FIRST LOOK  Meet two-week old, Bakso, the newest Sumatran tiger cub at Disneys Animal Kingdom ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bakso_df498f47a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKSOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAKSOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

