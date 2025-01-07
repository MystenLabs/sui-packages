module 0xc62df8dc8defc042e6c45dff682662f099ba4092fd13e9ee843622557bd389e5::airdrop {
    struct AIRDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRDROP>(arg0, 6, b"Airdrop", b"Deepbook", x"466f722052657461696c0a466f72204275696c64657273200a466f722054726164657273200a44656570426f6f6b20666f7220616c6c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/66b0ae79890ce8bb64f29184_deeplook_logo_preview_09_1_cbcb165a40.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIRDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

