module 0xe61bb875223bc92906e9b6fc659fb4b79a310dbd0e6412fdceac747e70efe584::rsn {
    struct RSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSN>(arg0, 6, b"RSN", b"Revealing Satoshi Nakamoto", b"Who exactly is Satoshi Nakamoto? Who exactly were the pioneers of cryptocurrencies?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_18_42_02_7e1c2addff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

