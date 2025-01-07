module 0x401284b46dafaaf3551d12ed2598ea24b95ab7ace6dea12a506d73612ccc949c::snailispace {
    struct SNAILISPACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAILISPACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAILISPACE>(arg0, 6, b"SnailIsPace", b"snail's pace", b"Snail's pace on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_15_07_19_621f0d0bec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAILISPACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAILISPACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

