module 0x39b1b6706b02f8d2311309c43fc43ecc144be327ee1e757cf4fd80d9701a6f8f::gobe {
    struct GOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBE>(arg0, 6, b"GOBE", b"Gobe Sui", b"GOBE is a cute pig, ready to make a big splash at the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008787_f0942fb159.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

