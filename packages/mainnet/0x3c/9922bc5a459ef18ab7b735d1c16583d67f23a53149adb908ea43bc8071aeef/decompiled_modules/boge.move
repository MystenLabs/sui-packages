module 0x3c9922bc5a459ef18ab7b735d1c16583d67f23a53149adb908ea43bc8071aeef::boge {
    struct BOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGE>(arg0, 6, b"BOGE", b"First Boge on Sui Real", b"Born in a lab on Sui, BOGE is the genetic clone of DOGE with a blue twist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_boge2_286x300_8f5a018c20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

