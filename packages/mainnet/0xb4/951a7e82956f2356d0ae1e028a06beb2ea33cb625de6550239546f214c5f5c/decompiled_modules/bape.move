module 0xb4951a7e82956f2356d0ae1e028a06beb2ea33cb625de6550239546f214c5f5c::bape {
    struct BAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPE>(arg0, 6, b"BAPE", b"BALD PEPE", b"DeFi project on Sui 100% BALD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3814_10bca8ac7f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

