module 0x8f8477cc2ece2c724f9e2ef767c1ad30adab5e7830f4d17487e269da044a42ae::grug {
    struct GRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUG>(arg0, 6, b"GRUG", b"Fish Grug", b"Experience the beauty of Grug memecoin the most artistic and valuable fish on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009329_3691424e16.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

