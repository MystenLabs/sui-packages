module 0xf4330b76fa8402893987a20066e1bb73e883e1d314c575ebf7d1d67ec7baf7c8::aijud {
    struct AIJUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIJUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIJUD>(arg0, 6, b"AIJUD", b"FirstAIJudge", b"Tyson Fury vs. Oleksandr Usyk Fight to Be Monitored by AI Judge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_48d79891d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIJUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIJUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

