module 0x8e9bc83dea5857c22396b2dcce3016e552861a531ba242e4daf47edadb6e69bc::stain {
    struct STAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAIN>(arg0, 6, b"STAIN", b"Poop Stain", b"Damn didnt make it. Need Sui to wash.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_b35da3b4f9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

