module 0xf7daed0627f8a59c94d1c0c9b3af55c7f26e1ba1a0aeb1c9066fef5723eb657c::of {
    struct OF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OF>(arg0, 9, b"OF", b"OCEAN  FISH", b"OCEAN  FISH Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5616fa5c23867a17087b198c78d95ed3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

