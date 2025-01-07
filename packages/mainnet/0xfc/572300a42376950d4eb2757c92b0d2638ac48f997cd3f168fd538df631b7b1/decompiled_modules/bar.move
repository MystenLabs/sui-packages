module 0xfc572300a42376950d4eb2757c92b0d2638ac48f997cd3f168fd538df631b7b1::bar {
    struct BAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAR>(arg0, 6, b"Bar", b"Gold Suil", x"476f6c642062617273207468617420686173206e6f20736f6369616c2c206e6f20636f6d6d756e6974792c206e6f2063656e7472616c697a656420636f6e74726f6c2c206e6f206f6e6520746f206d616e6970756c6174652e200a0a546f74616c6c79206672656520746f2062757920616e642073656c6c2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9299_7a66dcb1c3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

