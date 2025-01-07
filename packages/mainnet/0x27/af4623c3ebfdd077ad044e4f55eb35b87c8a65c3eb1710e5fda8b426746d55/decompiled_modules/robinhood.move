module 0x27af4623c3ebfdd077ad044e4f55eb35b87c8a65c3eb1710e5fda8b426746d55::robinhood {
    struct ROBINHOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBINHOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBINHOOD>(arg0, 6, b"ROBINHOOD", b"ROBIN HOOD", x"2057656c636f6d6520746f20746865204369746164656c206f6620526f62696e686f6f642046696e616e6365200a0a5468697320697320746865206f6666696369616c20676174686572696e6720706c61636520666f722074686f73652077686f207365656b20746f207265636c61696d207765616c746820616e6420706f7765722077697468696e20535549207265616c6d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3564_e20bd2db91.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBINHOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBINHOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

