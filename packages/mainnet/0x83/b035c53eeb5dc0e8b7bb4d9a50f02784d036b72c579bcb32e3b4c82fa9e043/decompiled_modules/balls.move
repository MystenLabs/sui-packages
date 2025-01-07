module 0x83b035c53eeb5dc0e8b7bb4d9a50f02784d036b72c579bcb32e3b4c82fa9e043::balls {
    struct BALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLS>(arg0, 6, b"BALLS", b"Sui Balls", x"457665722068616420626c75652062616c6c733f205375692042616c6c73202442414c4c53206973206865726520666f7220657665727920646567656e2077686f206b6e6f777320746865207374727567676c652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_51_1_e90620e188.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

