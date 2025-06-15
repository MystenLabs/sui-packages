module 0xcd4a44aa85f80cc32e59f9ce7362215bce316515df7993c45eeaaf53a16f4545::cacti {
    struct CACTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CACTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CACTI>(arg0, 6, b"CACTI", b"SUI-YOTE", b"Enlightenment is Imminent within the walls of this community. Come to the desert, where all we need is one drop......", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749971212992.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CACTI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CACTI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

