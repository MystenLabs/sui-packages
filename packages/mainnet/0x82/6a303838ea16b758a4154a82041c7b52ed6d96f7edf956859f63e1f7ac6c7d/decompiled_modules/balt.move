module 0x826a303838ea16b758a4154a82041c7b52ed6d96f7edf956859f63e1f7ac6c7d::balt {
    struct BALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALT>(arg0, 6, b"BALT", b"SUI BALT", b"Balt is like a roaring wild cat, a true degen, vibing on the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/balt_1_1_528b190a7e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALT>>(v1);
    }

    // decompiled from Move bytecode v6
}

