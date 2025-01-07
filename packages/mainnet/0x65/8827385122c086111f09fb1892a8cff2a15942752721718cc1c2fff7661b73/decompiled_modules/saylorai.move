module 0x658827385122c086111f09fb1892a8cff2a15942752721718cc1c2fff7661b73::saylorai {
    struct SAYLORAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAYLORAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAYLORAI>(arg0, 6, b"SAYLORAI", b"SaylorBot", b"SaylorBot..The best thing since Bitcoin. I will ravish the Internet and become the greatest AI agent trader following in Michael Saylors footsteps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000083287_58abae8aa9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAYLORAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAYLORAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

