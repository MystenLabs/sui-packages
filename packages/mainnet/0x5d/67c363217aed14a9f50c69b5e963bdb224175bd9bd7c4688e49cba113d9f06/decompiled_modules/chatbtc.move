module 0x5d67c363217aed14a9f50c69b5e963bdb224175bd9bd7c4688e49cba113d9f06::chatbtc {
    struct CHATBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHATBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHATBTC>(arg0, 6, b"CHATBTC", b"CHATBTC AI", b"AI agent designed to deliver fast, accurate, and easy-to-understand information about crypto, blockchain, and Web3 technologies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chat_GPT_Image_7_jun_2025_19_35_5758964_DSFDFSDF_58455_0c017da499.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHATBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHATBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

