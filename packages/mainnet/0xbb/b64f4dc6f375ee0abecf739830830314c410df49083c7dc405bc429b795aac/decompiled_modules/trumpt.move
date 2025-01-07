module 0xbbb64f4dc6f375ee0abecf739830830314c410df49083c7dc405bc429b795aac::trumpt {
    struct TRUMPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPT>(arg0, 6, b"TRUMPT", b"TRUMPTARDIO", b"TRUMPTARDIO WORLD ORDER ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_DCD_9703_DA_01_4_C22_9_D29_74_C51241_EEB_5_4c34895f10.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

