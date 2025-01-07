module 0xe075128a56f50c09420c9c15942f50f00c1f3f6a0cd47a2fdb5353402bbfad2d::djpepe {
    struct DJPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJPEPE>(arg0, 6, b"DJPEPE", b"DJ PEPE", b"DJ Pepe spins the latest tracks as he pumps up the price! Don't miss the DJ styles of crypto's most famous frog!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2d_Hfaq1fd_It_TK_Cn_N_8a0a7ba169.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

