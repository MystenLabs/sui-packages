module 0xf82457d617d34dedb0e35de87e1be4f5d070c29680bf51cc461ee4c0bd3f6a3c::summer {
    struct SUMMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMMER>(arg0, 6, b"SUMMER", b"Sui Summer", b"Dive into the world of $Summer, the ultimate community token that captures the essence of summer vibes, joy, and good times ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040529_ebe1c581a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

