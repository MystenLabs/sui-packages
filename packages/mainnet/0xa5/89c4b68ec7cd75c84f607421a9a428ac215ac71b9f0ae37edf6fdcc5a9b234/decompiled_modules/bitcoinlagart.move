module 0xa589c4b68ec7cd75c84f607421a9a428ac215ac71b9f0ae37edf6fdcc5a9b234::bitcoinlagart {
    struct BITCOINLAGART has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOINLAGART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOINLAGART>(arg0, 6, b"BITCOINlagart", b"lagartobtc", b"reptil abil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_b956388879.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOINLAGART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCOINLAGART>>(v1);
    }

    // decompiled from Move bytecode v6
}

