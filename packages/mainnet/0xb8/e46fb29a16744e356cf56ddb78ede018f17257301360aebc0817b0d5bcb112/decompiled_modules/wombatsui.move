module 0xb8e46fb29a16744e356cf56ddb78ede018f17257301360aebc0817b0d5bcb112::wombatsui {
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

