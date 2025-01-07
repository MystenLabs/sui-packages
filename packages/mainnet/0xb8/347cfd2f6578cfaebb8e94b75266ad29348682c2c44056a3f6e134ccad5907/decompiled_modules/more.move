module 0xb8347cfd2f6578cfaebb8e94b75266ad29348682c2c44056a3f6e134ccad5907::more {
    struct MORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORE>(arg0, 6, b"More", b"shoulda bought more", b"i was waiting for an entry but it just kept going up, i shoulda bought more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731882069629.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

