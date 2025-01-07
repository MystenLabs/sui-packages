module 0xd00c31261bbdaead044f5e2f49a6bd942335e01f97dc0aaec41ba422a2facfe3::sunsui {
    struct SUNSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNSUI>(arg0, 6, b"SUNSUI", b"SunSui", b"The sun is only just rising on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sunsui_c750d7db88.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

