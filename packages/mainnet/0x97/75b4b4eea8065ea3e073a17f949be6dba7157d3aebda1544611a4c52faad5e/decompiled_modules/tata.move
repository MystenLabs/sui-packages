module 0x9775b4b4eea8065ea3e073a17f949be6dba7157d3aebda1544611a4c52faad5e::tata {
    struct TATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATA>(arg0, 6, b"TATA", b"HakunaMatata", b"$TATA token on Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hakuna_matata_by_kuumo_d7kssx0_fullview_185acbe5b8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

