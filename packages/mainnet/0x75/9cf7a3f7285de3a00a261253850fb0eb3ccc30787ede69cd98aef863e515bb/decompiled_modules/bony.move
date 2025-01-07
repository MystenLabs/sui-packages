module 0x759cf7a3f7285de3a00a261253850fb0eb3ccc30787ede69cd98aef863e515bb::bony {
    struct BONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONY>(arg0, 6, b"BONY", b"Sui Bony", b"$Bony. surf the ocean with Bony, and conquer the sui waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_69_2d9745ca88.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

