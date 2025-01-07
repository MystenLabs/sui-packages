module 0x9b233fac188a91f6c4b58300eb3b476d2f49c747600ce859c8671db7855a74c5::manny {
    struct MANNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANNY>(arg0, 6, b"MANNY", b"Selfie Cat", b"Welcome To Selfie Cat  on Sui Enjoy and have Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000164941_4c161930b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

