module 0x6d3af25bfa36337021c5e73f1a91e3aaea7e04fc5f426306f0b1f081c305b32f::swp {
    struct SWP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWP>(arg0, 6, b"SWP", b"SuiWaterPokemon", x"2d2d3e205355495761746572506f6b656d6f6e203c2d2d0a0a23312045564f4c56453a20284b4f5453290a2d5447202f2058202f2057454253495445200a57696c6c2062652073686172656420696e20636f6d6d656e74732e0a0a23322045564f4c56453a202834354b204d43290a2d444558202b204445582041445320505245504149442e0a0a23332045564f4c453a2028424f4e44290a2d44455820424f4f5354203130300a0a2346494e414c204d4547412045564f4c5554494f4e20283130304b204d43290a2d204d4f524520424f4f53540a2d2042696720535550524953450a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035590_bd285b7704.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWP>>(v1);
    }

    // decompiled from Move bytecode v6
}

