module 0x5e4cab422386f233d1826250a972ef701306db5c3a0c2eb6dc4efc394e491b4f::coin777 {
    struct COIN777 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN777, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN777>(arg0, 6, b"Coin777", b"777Coins", b"Spin it win it then twin it double the fun double the gains Lets roll those coins like destinys dice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifktuqkv5mtddlffciz2udypsmbye3ufliuhmdl3ba5dtcia363aa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN777>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN777>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

