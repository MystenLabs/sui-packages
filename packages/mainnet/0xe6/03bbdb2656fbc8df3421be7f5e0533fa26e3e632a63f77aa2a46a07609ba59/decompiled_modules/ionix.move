module 0xe603bbdb2656fbc8df3421be7f5e0533fa26e3e632a63f77aa2a46a07609ba59::ionix {
    struct IONIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: IONIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IONIX>(arg0, 6, b"IONIX", b"Ionix Agent by SuiAI", b"Ionix is a revolutionary AI terminal designed to cater to every aspect of user needs, from data management and analysis to automating daily tasks. Built with cutting-edge technology, Ionix serves as a versatile assistant for professionals, businesses, and individuals alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_124_min_e2847b179e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IONIX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IONIX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

