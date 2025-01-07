module 0x552fb7bdf53cc05dbe6b1f1bd249f693fed17bb1ef6e0bcca1fa7c0c1ef25eba::elli0t {
    struct ELLI0T has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELLI0T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELLI0T>(arg0, 6, b"ELLI0T", b"ELLIOT", b"Elliot B. Have  Bretts cousin and the smoothest coin in Cryptoville. While Tyler, Ethan, Kevin, and Brian stir things up, Elliot keeps it cool. Hes always one step ahead, never in a rush, just vibing and letting the others do the heavy lifting. Cool, calm, and always based.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Snx_G6uxjod_B_Dc_ALXK_5_VU_Tk5_JN_8uja_GH_Knwq_Sn35_RA_Ys_J_5f704381b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELLI0T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELLI0T>>(v1);
    }

    // decompiled from Move bytecode v6
}

