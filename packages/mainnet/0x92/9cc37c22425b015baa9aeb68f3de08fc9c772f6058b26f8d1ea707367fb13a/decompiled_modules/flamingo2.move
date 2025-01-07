module 0x929cc37c22425b015baa9aeb68f3de08fc9c772f6058b26f8d1ea707367fb13a::flamingo2 {
    struct FLAMINGO2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAMINGO2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAMINGO2>(arg0, 6, b"FLAMINGO2", b"FLAMINGO-CTO", b"The flamingo rugged dev. And he has appointed me as a moderator to make FLAMINGO2. We will recover from the ashes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CTO_cd044121e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAMINGO2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAMINGO2>>(v1);
    }

    // decompiled from Move bytecode v6
}

