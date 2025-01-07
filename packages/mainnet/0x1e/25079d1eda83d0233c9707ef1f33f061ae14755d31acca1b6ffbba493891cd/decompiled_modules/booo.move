module 0x1e25079d1eda83d0233c9707ef1f33f061ae14755d31acca1b6ffbba493891cd::booo {
    struct BOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOO>(arg0, 6, b"BOOO", b"BOO SUI", b"booooooooooooooooooooooooooooooooooooo booooooooooooooooooooooooooooooooooooo booooooooooooooooooooooooooooooooooooo booooooooooooooooooooooooooooooooooooo booooooooooooooooooooooooooooooooooooo booooooooooooooooooooooooooooooooooooo booooooooooooooooooooooooooooooooooooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/booo_pfp_df58d513ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

