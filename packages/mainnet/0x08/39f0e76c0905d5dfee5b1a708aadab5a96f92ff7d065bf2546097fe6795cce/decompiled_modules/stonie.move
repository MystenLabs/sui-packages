module 0x839f0e76c0905d5dfee5b1a708aadab5a96f92ff7d065bf2546097fe6795cce::stonie {
    struct STONIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONIE>(arg0, 6, b"STONIE", b"Sui Stonie", b"Meet Stonie, the highest member of the group. He was so stoned that he missed the invitation to join the Boys' Club.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/stonie_2da7a016a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

