module 0x845d106a278356b9fd17980ad1047eb92544bc20700afe79275d4ca90f251b70::suigpt {
    struct SUIGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGPT>(arg0, 6, b"SUIGPT", b"Sui GPT", b"Let Sui Gpt generate Sui Move smart contract code for you based on your instructions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736045225565_50e36ccafd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

