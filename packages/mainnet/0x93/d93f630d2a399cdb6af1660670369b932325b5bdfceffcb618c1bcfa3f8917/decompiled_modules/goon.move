module 0x93d93f630d2a399cdb6af1660670369b932325b5bdfceffcb618c1bcfa3f8917::goon {
    struct GOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOON>(arg0, 6, b"GOON", b"Sui Goon", b"$GOON. Goon just wants to play", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_66_ce0ecf6095.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

