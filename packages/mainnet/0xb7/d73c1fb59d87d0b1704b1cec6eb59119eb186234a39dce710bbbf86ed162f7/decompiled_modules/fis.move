module 0xb7d73c1fb59d87d0b1704b1cec6eb59119eb186234a39dce710bbbf86ed162f7::fis {
    struct FIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIS>(arg0, 6, b"FIS", b"Sui FIS", b"FIS is pure yoy on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avafish_min_99aba446f5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

