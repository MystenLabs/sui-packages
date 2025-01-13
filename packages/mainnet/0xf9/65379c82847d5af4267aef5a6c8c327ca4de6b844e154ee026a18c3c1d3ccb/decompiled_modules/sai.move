module 0xf965379c82847d5af4267aef5a6c8c327ca4de6b844e154ee026a18c3c1d3ccb::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"Satoshi AI", b"Hi! I'm your agent creation assistant. Tell me about the bot you want to create, and I'll help you set it up. What type of bot are you looking to build?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6320_2f9f65e7ab.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

