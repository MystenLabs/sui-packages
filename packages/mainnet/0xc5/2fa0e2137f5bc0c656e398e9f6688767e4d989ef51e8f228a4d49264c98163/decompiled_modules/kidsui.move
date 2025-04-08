module 0xc52fa0e2137f5bc0c656e398e9f6688767e4d989ef51e8f228a4d49264c98163::kidsui {
    struct KIDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIDSUI>(arg0, 6, b"KidSui", b"SuiKid", x"43616d652066726f6d20534f4c414e41200a727567206f6e2031306d696c206d636170", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1744142057348.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

