module 0xb5c5db9e159c6158f8c1be4bc2b00afab0528a8e8c68b4a46084a258a4255df9::bear {
    struct BEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAR>(arg0, 6, b"Bear", b"BearD", b"123456", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/eaf87cc6-f09f-4967-aae5-a52a883d16a9.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

