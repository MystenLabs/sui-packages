module 0x41027867513bbee723fe5ca33b955955d4340db4d5b1be9f8de4232d5b7bd049::cibi {
    struct CIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIBI>(arg0, 6, b"CIBI", b"Sui Cibi", b"$CIBI. swimming across the ocean with Cibi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_67_0e5f857997.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

