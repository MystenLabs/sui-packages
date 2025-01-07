module 0xe8bba8caa4f066740d201931d5ca4823d7acd91a821bd417747e35cc52e4b62a::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POP>(arg0, 6, b"POP", b"Moonwave POP", b"Moonwave POP can thrill you more than any dare try!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F8_F928_BD_BBC_4_46_B8_BBF_4_FC_16_A17_EBE_7_A_36f34d8f70.WEBP")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POP>>(v1);
    }

    // decompiled from Move bytecode v6
}

