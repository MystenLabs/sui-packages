module 0x5149dd9e5d1006a7f4696754d621ba52b74e0404632057e065d5363092a1c3f8::annekatt {
    struct ANNEKATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANNEKATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANNEKATT>(arg0, 6, b"AnneKatt", b"Anne Katt", x"436f64656e616d653a205072696e636573732e0a4d697373696f6e3a206361707475726520796f7572206865617274732e0a5365636f6e64617279204d697373696f6e3a20696e66696c747261746520706574206d6f64656c696e672073796e6469636174652e0a0a0a68747470733a2f2f696d6775722e636f6d2f757365722f4f726a616e4e43", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_Anne_Katt_2_5efa7dc4e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANNEKATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANNEKATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

