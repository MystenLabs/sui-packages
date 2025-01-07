module 0x2afc900a4268f69cc2b396ec64b51b3c82dd7c73c513b52add09544a6718aa3::madcatsui {
    struct MADCATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADCATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADCATSUI>(arg0, 6, b"MADCATSUI", b"MAD CAT ON SUI", b"Craziest cat on the SUI eco-system ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MAD_CAT_27f85157bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADCATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MADCATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

