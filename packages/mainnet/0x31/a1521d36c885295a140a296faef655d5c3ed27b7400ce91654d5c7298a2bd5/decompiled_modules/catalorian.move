module 0x31a1521d36c885295a140a296faef655d5c3ed27b7400ce91654d5c7298a2bd5::catalorian {
    struct CATALORIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATALORIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATALORIAN>(arg0, 6, b"CATALORIAN", b"Original Catalorian", b"The First CATALORIAN Launched on the Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zwl_Up_Kql_400x400_dc05f0731d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATALORIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATALORIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

