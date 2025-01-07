module 0xaa9708b4d525c1c911e1718dcd4799a2812a769ddacdc18a37758c7f5bc35347::kwhales {
    struct KWHALES has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWHALES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWHALES>(arg0, 6, b"KWHALES", b"KING WHALES", b"Enter to the group.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_AVEC_TITRE_4e84dcb979.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWHALES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KWHALES>>(v1);
    }

    // decompiled from Move bytecode v6
}

