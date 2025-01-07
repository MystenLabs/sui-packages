module 0x9f304e0ca53b700194099678754ebc9086757f383eaf8f85a35c843c7a4386de::fffsgdfdsg {
    struct FFFSGDFDSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFSGDFDSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFSGDFDSG>(arg0, 6, b"FFfsgdfdsg", b"dsafas", b"dsafdasdfasfd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6715e9fcfde8e259394ba021c3767029_169916a6d1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFSGDFDSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFFSGDFDSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

