module 0xcf2a8d7fc26473b0b5fbd40c0434bf3b6846f6faedb932672c50b62c16ec2644::yfu {
    struct YFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YFU>(arg0, 6, b"YFU", b"Waifu On Sui", b"Asian wives are the Alpha. Ushering in the new wave of Internet Culture Tokens, only on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048532_6e2b13b13d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

