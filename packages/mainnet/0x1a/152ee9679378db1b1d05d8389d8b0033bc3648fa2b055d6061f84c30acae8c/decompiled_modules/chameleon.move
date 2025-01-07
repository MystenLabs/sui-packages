module 0x1a152ee9679378db1b1d05d8389d8b0033bc3648fa2b055d6061f84c30acae8c::chameleon {
    struct CHAMELEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAMELEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAMELEON>(arg0, 6, b"CHAMELEON", b"Wizzard Chameleon", b"Moved like a spectre on SUI, $Chameleon was the unseen. The power didnt just come from being strong it came from being anyone and everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ICON_9_1_ed1a3d5458_08d0af3195.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAMELEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAMELEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

