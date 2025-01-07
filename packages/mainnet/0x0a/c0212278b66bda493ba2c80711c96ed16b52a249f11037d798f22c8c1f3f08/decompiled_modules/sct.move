module 0xac0212278b66bda493ba2c80711c96ed16b52a249f11037d798f22c8c1f3f08::sct {
    struct SCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCT>(arg0, 6, b"SCT", b"little cats", b"Cats are so cute that humans have kept them as pets for thousands of years. When it comes to wild cats, many start out as adorable kittens, then grow into intimidatingly large adults. Some wild cats, however, stay small for life, keeping their cutene", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732430754528.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

