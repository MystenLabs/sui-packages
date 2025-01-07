module 0x37647d4b006a117d2e8b0119f96360915932e5bc6638534af74f7ff51dc529dd::frens {
    struct FRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENS>(arg0, 6, b"Frens", b"Sui Purple Frens", x"416e206578636c7573697665204e465420636f6c6c656374696f6e206f6e200a406d6f6e61645f78797a0a20666f6375736564206f6e2063756c747572652c206d656d65732c2061727420616e6420636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/purple_a2bfd358e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

