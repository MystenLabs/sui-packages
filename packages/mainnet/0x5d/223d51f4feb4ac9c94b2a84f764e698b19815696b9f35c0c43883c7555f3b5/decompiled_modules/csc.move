module 0x5d223d51f4feb4ac9c94b2a84f764e698b19815696b9f35c0c43883c7555f3b5::csc {
    struct CSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSC>(arg0, 0, b"CSC", b"Casino coin", b"Casino coins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JRMvjvn.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<CSC>(&mut v2, 10000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSC>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

