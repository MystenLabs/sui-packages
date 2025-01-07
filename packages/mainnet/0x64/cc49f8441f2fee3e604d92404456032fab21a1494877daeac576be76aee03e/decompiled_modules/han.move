module 0x64cc49f8441f2fee3e604d92404456032fab21a1494877daeac576be76aee03e::han {
    struct HAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAN>(arg0, 6, b"HAN", b"Hanbao", b"Hanbao, king of the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_7_N_Gg_VWIA_At_OO_0_591eeef377.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

