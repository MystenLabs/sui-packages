module 0xaec7fd0bd99b0558b1e564c66f7c9641740d324a42c8ba1cb91147c8c870bed6::shrett {
    struct SHRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRETT>(arg0, 6, b"SHRETT", b"Shrett", b"$SHRETT, a character like no other, struts into the Sui Network with attitude and swagger. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_83_22693a5029.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

