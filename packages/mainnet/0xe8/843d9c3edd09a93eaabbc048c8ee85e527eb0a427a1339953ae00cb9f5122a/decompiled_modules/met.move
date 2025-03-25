module 0xe8843d9c3edd09a93eaabbc048c8ee85e527eb0a427a1339953ae00cb9f5122a::met {
    struct MET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MET>(arg0, 6, b"MET", b"Metamorphosis", x"4d6574616d6f7270686f73697320697320746865206162696c69747920746f207472616e73666f726d2e0a54686973206d656d65636f696e20697320612073746f7265206f662076616c75652c206f6e6c792061206665772063686f6f73656e206f6e63652077696c6c20756e6465727374616e64207468652070726f6772657373206f66207472616e73666f726d6174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000148_acdc614806.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MET>>(v1);
    }

    // decompiled from Move bytecode v6
}

