module 0x1ad461ad24d1dbba3eaa886d97e623e6f0db194751305e0324cd38f38f7f7bd5::suiwhiteseal {
    struct SUIWHITESEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWHITESEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWHITESEAL>(arg0, 6, b"SUIWHITESEAL", b"Sui white seal", x"4c657420746865207768697465207365616c207361766520796f752e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_02_07_53_fa4043b353.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWHITESEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWHITESEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

