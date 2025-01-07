module 0xdbfeb7692ecd6b9e8dffb838f61bfbe750d85dbd92435883998849717b1e423::fac {
    struct FAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAC>(arg0, 6, b"FAC", b"Flying Avocado Cat", b"Flying Avocado Cat is as eager as a running cat to eat food, and the nutritious avocado will add energy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050523_1a1af90857.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

