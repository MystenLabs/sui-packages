module 0xa86359b77a4f6e7876851d66be877cee02879b4121ff974d38c1e53e4cf1e9c9::blo {
    struct BLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLO>(arg0, 6, b"BLO", b"Blohters", b"blothers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_21_08_39_878d32bc8a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

