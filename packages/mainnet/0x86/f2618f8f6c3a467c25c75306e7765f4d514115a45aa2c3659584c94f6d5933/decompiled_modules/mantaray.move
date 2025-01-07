module 0x86f2618f8f6c3a467c25c75306e7765f4d514115a45aa2c3659584c94f6d5933::mantaray {
    struct MANTARAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANTARAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANTARAY>(arg0, 6, b"MANTARAY", b"Manta Ray", x"496e74726f647563696e67204d616e7461205261792c20696e73706972656420627920746865206d616a6573746963206372656174757265206b6e6f776e20666f722069747320677261636520616e64206167696c69747920696e20746865206f6365616e2e204865726520746f20636f6e717565722074686520537569204e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Manta_Ray_3027ff31cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANTARAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANTARAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

