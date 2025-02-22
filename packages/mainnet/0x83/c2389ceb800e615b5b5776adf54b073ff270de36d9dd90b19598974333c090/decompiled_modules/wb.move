module 0x83c2389ceb800e615b5b5776adf54b073ff270de36d9dd90b19598974333c090::wb {
    struct WB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WB>(arg0, 6, b"WB", b"WhiteBear", b"i will short all market dump. lmao!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/8dc59787-5531-4385-9abb-1bab09daad70.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

