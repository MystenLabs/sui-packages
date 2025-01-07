module 0xf230247e4819240cf5bc715d03b68253113fccb3839a12e73ea51c957b228e4f::red {
    struct RED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RED>(arg0, 6, b"RED", b"RED EYED DOG", b"dog with red eyes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_10_09_141826602_90551d0d1a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RED>>(v1);
    }

    // decompiled from Move bytecode v6
}

