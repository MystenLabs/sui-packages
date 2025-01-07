module 0xd7714805134751d49d0b6535bba89b137e6caf3f71b81ffa961d07cc9011d218::aaaaratt {
    struct AAAARATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAARATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAARATT>(arg0, 6, b"AaaaRatt", b"Aaa Rat", b"Riding on the trend, making wave AaaRat taking over the house of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/00_2ae329a6fa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAARATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAARATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

