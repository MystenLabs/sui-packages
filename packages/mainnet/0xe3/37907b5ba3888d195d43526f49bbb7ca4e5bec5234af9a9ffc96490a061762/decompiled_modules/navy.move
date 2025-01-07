module 0xe337907b5ba3888d195d43526f49bbb7ca4e5bec5234af9a9ffc96490a061762::navy {
    struct NAVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVY>(arg0, 6, b"NAVY", b"SuiNAVY", x"546865206669727374204e6176616c20666f726365206f6e2074686520537569204e6574776f726b2e200a5265646566696e696e6720746865207374616e646172647320666f72206120646563656e7472616c697a656420616e642073656375726564206d656d6520667574757265206f6e2074686520537569204e6574776f726b2e200a4f6e7761726420746f20746865206d6f6f6e2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000102908_4c51460112.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

