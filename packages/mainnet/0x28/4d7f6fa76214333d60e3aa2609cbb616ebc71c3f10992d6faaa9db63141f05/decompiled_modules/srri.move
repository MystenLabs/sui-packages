module 0x284d7f6fa76214333d60e3aa2609cbb616ebc71c3f10992d6faaa9db63141f05::srri {
    struct SRRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRRI>(arg0, 6, b"SRRI", b"SUIRRARI", x"5375692052726172693a2054686520556c74696d617465205374617475732053796d626f6c2e0a457870657269656e63652074686520746872696c6c6f66206578636c757369766974792077697468205375692052726172692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004224_c2fe18843f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

