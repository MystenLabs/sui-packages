module 0x11c3c41b66c122d7a6a9a58496f5371425bcc83ca3d43478d37c35716fa5fb4e::splob {
    struct SPLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLOB>(arg0, 6, b"SPLOB", b"SPLO BACK?", x"53504c4f2043544f207c200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/splo_back_0dda90bde0.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

