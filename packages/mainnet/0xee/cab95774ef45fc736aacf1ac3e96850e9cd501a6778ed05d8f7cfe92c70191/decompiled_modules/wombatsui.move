module 0xeecab95774ef45fc736aacf1ac3e96850e9cd501a6778ed05d8f7cfe92c70191::wombatsui {
    struct WOMBATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOMBATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOMBATSUI>(arg0, 6, b"WOMBATSUI", b"WOMBAT", x"546865204375746965737420636f696e20697320686572652e0a0a4c65742773206a6f696e2075732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_e_i_i_e98d6d9b3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOMBATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOMBATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

