module 0xbb0f57b8df4decd49f3869837da9f868ce7c398312c34edc722eba1c90cdbd66::octo {
    struct OCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTO>(arg0, 6, b"OCTO", b"Octo Labs", x"5765206e65656420594f5520746f2068656c70206275696c6420746865207374726f6e6765737420636f6d6d756e69747920696e2063727970746f21204a6f696e207573206e6f772c207374616b6520796f757220636c61696d2c20616e642072696465207468652077617665207769746820244f43544f2e20546f6765746865722c2077657265206372656174696e67206120706f776572686f75736520696e204465466920616e64204e465473210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ockto_4b13e84c65_c28e55f5f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

