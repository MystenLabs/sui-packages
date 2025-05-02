module 0xd478d926ebe00d6ec36229b7a3e8bb68a6bb903acda5edf895cfcfba60b3458e::kobe {
    struct KOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBE>(arg0, 6, b"KOBE", b"Pixel Kobe", x"244b4f4245206973206d6f7265207468616e2061206d656d652e20497427732061207472696275746520746f20746865204d616d6261204d656e74616c6974792020666561726c6573732c20666f63757365642c20616e64206c6567656e646172792e0a5265696d6167696e656420696e20706978656c20666f726d2c20244b4f4245206272696e67732074686520737069726974206f66203234206261636b20746f2074686520636f7572742020746869732074696d652c206f6e2d636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_a_ae_a_c_e_2025_05_03_012204_de368d38c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

