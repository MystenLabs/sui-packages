module 0x7cab5a4c2efa7b517dbb559ea31aa9ccab2f6e350366c915e111c633ea58094e::arie {
    struct ARIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARIE>(arg0, 6, b"ARIE", b"Arielle Zuckerberg Pump", b"Honoring Arielle Zuckerberg, partner at Long Journey Ventures with a focus on blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Arielle_Zuckerberg_Coin_d0a7e27770.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

