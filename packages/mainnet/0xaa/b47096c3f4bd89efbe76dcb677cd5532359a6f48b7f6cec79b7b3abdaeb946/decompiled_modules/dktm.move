module 0xaab47096c3f4bd89efbe76dcb677cd5532359a6f48b7f6cec79b7b3abdaeb946::dktm {
    struct DKTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKTM>(arg0, 6, b"DKTM", b"DOGEKNIGHT", b"DOGE KNIGHT BORN TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/doge_knight_Copy_954fbfdf55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DKTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

