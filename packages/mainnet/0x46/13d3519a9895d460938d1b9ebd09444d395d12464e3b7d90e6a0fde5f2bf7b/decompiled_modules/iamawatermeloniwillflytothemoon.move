module 0x4613d3519a9895d460938d1b9ebd09444d395d12464e3b7d90e6a0fde5f2bf7b::iamawatermeloniwillflytothemoon {
    struct IAMAWATERMELONIWILLFLYTOTHEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAMAWATERMELONIWILLFLYTOTHEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAMAWATERMELONIWILLFLYTOTHEMOON>(arg0, 6, b"IamawatermelonIwillflytothemoon", b"Eat the watermelon", b"I am a watermelon I will fly to the moon Plant my seeds, reap double the crop, and let's reach the moon and create a watermelon colony.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001173439_19e312b75b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAMAWATERMELONIWILLFLYTOTHEMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IAMAWATERMELONIWILLFLYTOTHEMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

