module 0xc728db0934759c11cb91568039e2513fe564ced7cce0c3f4f77162f55ba7040f::sdn {
    struct SDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDN>(arg0, 6, b"SDN", b"SUIDINO", b"SUIDINO INVADED SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/71aa154ce48518da913f35e7c8b215a0_9c768a1b33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

