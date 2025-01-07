module 0x708d3aa8ade0ca9cf66bca5583284b9d510a2334e2bc6b6a000619b19129d44::momoj {
    struct MOMOJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMOJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMOJ>(arg0, 6, b"MOMOJ", b"MOMOJ on SUI", b"$MOMOJI is a meme token on the SUI network, bringing excitement and fun to the crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tr_Mp_Zfp_D_400x400_543fef4977.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMOJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMOJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

