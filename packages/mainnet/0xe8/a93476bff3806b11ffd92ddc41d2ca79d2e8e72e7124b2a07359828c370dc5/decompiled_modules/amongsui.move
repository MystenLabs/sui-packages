module 0xe8a93476bff3806b11ffd92ddc41d2ca79d2e8e72e7124b2a07359828c370dc5::amongsui {
    struct AMONGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMONGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMONGSUI>(arg0, 6, b"AMONGSUI", b"Among Sui", x"24414d4f4e47535549202d2061206d656d6520636f696e20696e73706972656420627920416d6f6e672055732c206275696c74206f6e207468652053756920626c6f636b636861696e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_3a60886512.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMONGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMONGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

