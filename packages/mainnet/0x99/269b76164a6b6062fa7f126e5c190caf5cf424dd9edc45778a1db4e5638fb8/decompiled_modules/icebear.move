module 0x99269b76164a6b6062fa7f126e5c190caf5cf424dd9edc45778a1db4e5638fb8::icebear {
    struct ICEBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICEBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICEBEAR>(arg0, 6, b"ICEBEAR", b"SUIBEAR", b"Suicebear aims to help wild animals and endangered animals in the evolving and developing world, and we will transfer a portion of our profits to the rescue of these animals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197773_64e8a8f3b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICEBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICEBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

