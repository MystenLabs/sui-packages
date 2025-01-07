module 0xc2d3e6e1d658b732f8fb50e96c087aabff8b4dc6fc804aa493cba86110e4b9e0::sauce {
    struct SAUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAUCE>(arg0, 6, b"SAUCE", b"Sui Sauce", b"Get lost in the $Sauce", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_08_12_57_09_790d8387ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

