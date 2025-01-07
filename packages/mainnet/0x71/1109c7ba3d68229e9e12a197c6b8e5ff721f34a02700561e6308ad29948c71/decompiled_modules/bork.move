module 0x711109c7ba3d68229e9e12a197c6b8e5ff721f34a02700561e6308ad29948c71::bork {
    struct BORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORK>(arg0, 6, b"BORK", b"Bork", x"48692049276d20426f726b2c206d61737465726d696e64206f662074686520756e6976657273652e200a0a496d2072616973696e672072616973696e6720616e2061726d79206f6620646567656e73206f6e205355492e2057696c6c20796f75206a6f696e2075732c20616e6f6e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KN_Hq_ODJ_2_400x400_5dc0a122f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

