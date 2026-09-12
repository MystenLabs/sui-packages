module 0xe9c1897e25b15fae4dd1398f71a5ae9231814bb46875b70f58d00542ef44a673::lane_protocol {
    struct LANE_PROTOCOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANE_PROTOCOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LANE_PROTOCOL>(arg0, 6, b"LANE", b"LANE Protocol", b"LANE Protocol omnichain utility token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LANE_PROTOCOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LANE_PROTOCOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

