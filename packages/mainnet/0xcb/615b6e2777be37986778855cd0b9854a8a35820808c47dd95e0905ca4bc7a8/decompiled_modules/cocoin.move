module 0xcb615b6e2777be37986778855cd0b9854a8a35820808c47dd95e0905ca4bc7a8::cocoin {
    struct COCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCOIN>(arg0, 9, b"Cocoin", b"COCO", b"It's COCO COIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cb41f444bef7ee23e99bf94ddd3caab1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

