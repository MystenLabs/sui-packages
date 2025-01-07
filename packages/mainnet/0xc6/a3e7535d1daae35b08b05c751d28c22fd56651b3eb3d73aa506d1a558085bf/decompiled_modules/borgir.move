module 0xc6a3e7535d1daae35b08b05c751d28c22fd56651b3eb3d73aa506d1a558085bf::borgir {
    struct BORGIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORGIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORGIR>(arg0, 6, b"BORGIR", b"innoutborgir", b"Once hailed as a Base wizard, I plunjd into a meme coin mayhem, only to watch my savins vanish into the digital abyss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048670_996d0ffc37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORGIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORGIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

