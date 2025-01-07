module 0xd05c75da30b687ac7fcc6f85a59a7cc69a8aeb04b18f32e309a05a2a2a38ba2a::suinchan {
    struct SUINCHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINCHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINCHAN>(arg0, 6, b"SUINCHAN", b"Suinchan", b"Suin-chan is an innovative project built on the SUI chain that combine The name Shinchan creatively merges SUI and Shin-chan, drawing inspiration from the beloved character Shin-chan.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Web3_01f011a443.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINCHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINCHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

