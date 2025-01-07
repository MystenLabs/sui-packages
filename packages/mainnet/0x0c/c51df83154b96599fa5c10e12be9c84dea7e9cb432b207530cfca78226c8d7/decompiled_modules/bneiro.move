module 0xcc51df83154b96599fa5c10e12be9c84dea7e9cb432b207530cfca78226c8d7::bneiro {
    struct BNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNEIRO>(arg0, 6, b"BNEIRO", b"Blind Neiro", x"424c494e444e4549524f3a20746865206f6e6c7920746f6b656e206f6e2053554920776865726520536869626120496e75206d656574732065706963206661696c21204f7572206865726f206973206120536869626120646f672077686f73206c6f7374206869732077617920627574206e6f742068697320737761672e205065726665637420666f722074686f73652077686f206c6f7665206120676f6f6420636875636b6c6520616e642061707072656369617465207468652069726f6e79206f66206120626c696e6420536869626120496e7520747279696e6720746f206e617669676174652074686520776f726c64206f662063727970746f21200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/neiro_logo_f7506ebb03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

