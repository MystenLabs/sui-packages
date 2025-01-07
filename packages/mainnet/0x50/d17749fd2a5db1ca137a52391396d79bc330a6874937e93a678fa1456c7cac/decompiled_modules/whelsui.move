module 0x50d17749fd2a5db1ca137a52391396d79bc330a6874937e93a678fa1456c7cac::whelsui {
    struct WHELSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHELSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHELSUI>(arg0, 6, b"WHELSUI", b"WHELIY", b"another fish another WHELIY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028556_30f688ab8f_40a45bc677.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHELSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHELSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

