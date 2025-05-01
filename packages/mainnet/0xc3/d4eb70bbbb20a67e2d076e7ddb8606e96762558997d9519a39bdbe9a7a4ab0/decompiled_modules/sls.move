module 0xc3d4eb70bbbb20a67e2d076e7ddb8606e96762558997d9519a39bdbe9a7a4ab0::sls {
    struct SLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLS>(arg0, 6, b"SLS", b"Slus", b"Need to reed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_48_d0b849b23f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

