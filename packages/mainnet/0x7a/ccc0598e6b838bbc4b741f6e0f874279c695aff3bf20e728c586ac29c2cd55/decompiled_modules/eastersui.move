module 0x7accc0598e6b838bbc4b741f6e0f874279c695aff3bf20e728c586ac29c2cd55::eastersui {
    struct EASTERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EASTERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EASTERSUI>(arg0, 6, b"EASTERSUI", b"$EASTER SUI", b"Happy Easter to everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_3070f353f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EASTERSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EASTERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

