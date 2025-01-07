module 0xb997e93fda4e4615315a06f6e9290b3386100e6735e3214044b95cb9aa096113::bfh {
    struct BFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFH>(arg0, 6, b"BFH", b"BlubFish", x"4576656e20696e2074686520726f7567686573742074696465732c20426c75624669736820686f6c647320746865207472656173757265207469676874210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blubfish_9c8c9dfd32.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

