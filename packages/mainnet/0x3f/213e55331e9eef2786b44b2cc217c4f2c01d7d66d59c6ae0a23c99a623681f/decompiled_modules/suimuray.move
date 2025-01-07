module 0x3f213e55331e9eef2786b44b2cc217c4f2c01d7d66d59c6ae0a23c99a623681f::suimuray {
    struct SUIMURAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMURAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMURAY>(arg0, 6, b"Suimuray", b"SUIMURAY", b"Suimuray is a unique memecoin that combines the iconic humor of the troll face with the spirit of Japanese samurai.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241030_140445_155a7014d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMURAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMURAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

