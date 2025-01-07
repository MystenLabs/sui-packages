module 0x88e7c3fbe85e2fee8cf0802b30cc8394d25484555d5cad4775cbe0a0d60b2315::shhhh {
    struct SHHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHHHH>(arg0, 6, b"SHHHH", b"SHHHH SUI", b"Silence speaks louder than words. Just keep your stinking mouth shut and listen to the lessons of silence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_7_180x180_8cba840104.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHHHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

