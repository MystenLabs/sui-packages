module 0x6a216dd65b31827a85e9e74f69f8eafa9d9264121d89dfe4f6fe1ce30c769bc3::suif {
    struct SUIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIF>(arg0, 6, b"SUIF", b"SUILVER SURFER", x"5269646520746865207761766573206f6620537569207769746820535549462c20746865205375696c7665722053757266657220636f696e210a0a4f757220666561726c657373206865726f20626174746c6573206a65657465727320616e6420706170657268616e64732c20656e737572696e672065766572796f6e652063616e20726561636820746865206d6f6f6e20746f6765746865722e0a0a4a6f696e2074686520626174746c6520616e64207375726620746f206e657720686569676874732077697468205355494621", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/URF_2_5d1d616b55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

