module 0x9b5a09290ebeb9fc63bb6c37024b957086ff7c6a4b07d903ee1fbd056a952d7a::dognut {
    struct DOGNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGNUT>(arg0, 6, b"DOGNUT", b"Dognut", b"Dognut On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b9ab631c39b41862591ed2423da7700b_64bcff7e84.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

