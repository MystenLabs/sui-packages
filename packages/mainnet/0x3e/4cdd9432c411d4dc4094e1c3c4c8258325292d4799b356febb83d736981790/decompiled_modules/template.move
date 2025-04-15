module 0x3e4cdd9432c411d4dc4094e1c3c4c8258325292d4799b356febb83d736981790::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLATE>(arg0, 9, b"NINJA", b"Ninjav6", b"Ninjav6 200k Supply", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://jurassiq-bucket.s3.eu-north-1.amazonaws.com/anime-minimalist-and-flat-logo-illustration-vector.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMPLATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

