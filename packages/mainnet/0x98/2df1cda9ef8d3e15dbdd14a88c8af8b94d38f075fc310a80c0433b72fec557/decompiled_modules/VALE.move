module 0x982df1cda9ef8d3e15dbdd14a88c8af8b94d38f075fc310a80c0433b72fec557::VALE {
    struct VALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VALE>(arg0, 9, b"VALE", b"Valentine", b"Test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ih1.redbubble.net/image.5148959844.2540/st,small,507x507-pad,600x600,f8f8f8.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VALE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VALE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

