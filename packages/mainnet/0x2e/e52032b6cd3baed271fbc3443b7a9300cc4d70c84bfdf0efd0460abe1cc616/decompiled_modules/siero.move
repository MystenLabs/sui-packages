module 0x2ee52032b6cd3baed271fbc3443b7a9300cc4d70c84bfdf0efd0460abe1cc616::siero {
    struct SIERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIERO>(arg0, 6, b"SIERO", b"Sui Neiro", b"NIERO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NIERO_b21fdd1196.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

