module 0xe70fe2a314a9b38f8102c2cbabd7716d7bbe93b11a989deed7f22d488fa446fc::broccoli {
    struct BROCCOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCCOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCCOLI>(arg0, 6, b"BROCCOLI", b"CZ'S DOG", b"Community Takeover. #BROCCOLI has it all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x6d5ad1592ed9d6d1df9b93c793ab759573ed6714_35f4f93e6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCCOLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROCCOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

