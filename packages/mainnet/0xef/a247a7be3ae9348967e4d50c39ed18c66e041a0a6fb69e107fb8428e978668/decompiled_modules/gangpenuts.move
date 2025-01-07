module 0xefa247a7be3ae9348967e4d50c39ed18c66e041a0a6fb69e107fb8428e978668::gangpenuts {
    struct GANGPENUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANGPENUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANGPENUTS>(arg0, 6, b"GANGPENUTS", b"Gangster Peanuts", x"546865792061726520746f7567686572207468616e20796f752077696c6c20657665722062652e20546865792061726520746f7567686572207468616e20796f752063616e20696d6167696e652e2047616e6773746572205065616e75747320746865207265616c205065616e7574732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b08511f90f46a03e85766164a10a1ec2_1_f9b9d3b9d1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANGPENUTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GANGPENUTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

