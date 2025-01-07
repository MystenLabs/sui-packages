module 0x5ca48c6313696d18b084b5d85159cbf6701475554d19fdcad63d3f9aa158cde6::balt {
    struct BALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALT>(arg0, 6, b"BALT", b"SUI BALT CAT", b"First Balt Cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/balt_ticker_c6a085b3d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALT>>(v1);
    }

    // decompiled from Move bytecode v6
}

