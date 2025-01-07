module 0xe9e900b2b81b8196161bb27773ff822ed223a7149889e5af252ab78d48593202::elephant {
    struct ELEPHANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEPHANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEPHANT>(arg0, 6, b"ELEPHANT", b"SUI ELEPHANT", x"496e20746865207661737420616e642064796e616d696320657870616e7365206f66207468652063727970746f2077696c6465726e6573732c2074686572652073747269646573206120626f6c6420616e64206368617269736d6174696320666967757265206b6e6f776e2073696d706c792061732053756920456c657068616e74732e200a0a456c657068616e747320617265207361637265642e204a656574732077696c6c2062652070756e69736865642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ec4fe4e7_1e9c_49ee_91f1_d62329f9be8d_a38bed81bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEPHANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEPHANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

