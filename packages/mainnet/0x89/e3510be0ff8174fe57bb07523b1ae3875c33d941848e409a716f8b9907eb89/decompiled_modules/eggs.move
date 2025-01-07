module 0x89e3510be0ff8174fe57bb07523b1ae3875c33d941848e409a716f8b9907eb89::eggs {
    struct EGGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGS>(arg0, 6, b"EGGS", b"SUI GOLDEN EGGS", b"GOLDEN EGGS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GOLDEN_9865c00f51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

