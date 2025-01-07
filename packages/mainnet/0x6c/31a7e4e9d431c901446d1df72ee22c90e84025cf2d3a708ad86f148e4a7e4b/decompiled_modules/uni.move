module 0x6c31a7e4e9d431c901446d1df72ee22c90e84025cf2d3a708ad86f148e4a7e4b::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 6, b"UNI", b"UNICHAIN", x"546865204c322064657369676e656420666f7220446546692e204279200a40556e69737761700a2e204275696c74206f6e20746865205375706572636861696e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uni_a70d70facc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

