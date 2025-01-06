module 0xb5e17d16f97edf2a5f87750797b5a6c36a5ad5d928e5c3d22d1423ff6bd32fce::megaai {
    struct MEGAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGAAI>(arg0, 6, b"MegaAI", b"Mega Mind AI", x"4d656761204d696e64204149206167656e74206973206865726520746f207361746973667920616c6c20796f7572206e656564732077697468206120736f6f6e20746f2062652072656c65617365642074726164696e6720626f742c2058206167656e742c20616e64206d756368206d6f726521210a0a436f6d65206a6f696e2074686520726f636b6574207768696c65204d656761204d696e642041492074616b6573206f7665722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736200528720.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEGAAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGAAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

