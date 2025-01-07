module 0x98fcf5cf71437d5c71aba2974eb1fd9589bd75bbc50dff5863af266eb802a437::sblack {
    struct SBLACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLACK>(arg0, 6, b"SBLACK", b"SUIBLACK", b"New black meta dog on SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D9_AF_0_D10_4_E6_C_4_CF_4_A57_D_AA_21_E5_F28236_537ec1ae99.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBLACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

