module 0x531d1a6cd34dae8267130ccf23df437ef80162d6a5f7c26d99890259d3911099::luga {
    struct LUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUGA>(arg0, 6, b"LUGA", b"LUGA Whale", b"hallo - it a beluga whale.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_120821_dd52691aa9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

