module 0xe8c7d14f3318f02c55ced02fcd1b72119e2ec3e9d9d27f97d88e807c3369cdbd::spons {
    struct SPONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONS>(arg0, 6, b"SPONS", b"Spons SUI", b"The first meme coin on sui token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_1_f03b122163.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

