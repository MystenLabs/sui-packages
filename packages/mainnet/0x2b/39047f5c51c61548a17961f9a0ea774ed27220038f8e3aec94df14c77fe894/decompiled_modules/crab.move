module 0x2b39047f5c51c61548a17961f9a0ea774ed27220038f8e3aec94df14c77fe894::crab {
    struct CRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAB>(arg0, 6, b"Crab", b"Blue-eyed Crab Wif Knife", b"Blue-eyed crab wif knife army!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_eyed_crab_w_knife_be49ee6f03.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

