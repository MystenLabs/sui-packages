module 0x8e958b28e89c306062e3e3b6d204b354d06bb538eaec195f7e05734287938a78::kindy {
    struct KINDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINDY>(arg0, 6, b"KINDY", b"KindyDog Sui", x"244b494e4459206973206e6f7420616e206f7264696e61727920646f672c206375746520627574207374726f6e672c20696e74656c6c6967656e7420616e642070657273697374656e742c206865206578706c6f72657320746865207661737420706c61696e732077697468206869676820676f616c732e20556e6c696b65206f7468657220646f67732077686f2061747461636b20776974686f7574207468696e6b696e672c20244b494e4459206361726566756c6c79206e6176696761746573206368616c6c656e6765732c20616c77617973206c6f6f6b696e6720666f72206f70706f7274756e697469657320746f20696d70726f76652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001335_8be025cc7c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

