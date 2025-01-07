module 0x5ed6cb1987220bde9ebf5f9a2e33470f5725488d39138be50a2725bf2c8e6564::boge {
    struct BOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGE>(arg0, 6, b"BOGE", b"Boge on Sui", b"Born in a lab on Sui, BOGE is the genetic clone of DOGE with a blue twist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_boge2_768x807_79e9de46a5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

