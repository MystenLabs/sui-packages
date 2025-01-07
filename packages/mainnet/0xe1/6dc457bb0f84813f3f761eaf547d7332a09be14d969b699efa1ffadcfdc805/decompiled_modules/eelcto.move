module 0xe16dc457bb0f84813f3f761eaf547d7332a09be14d969b699efa1ffadcfdc805::eelcto {
    struct EELCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EELCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EELCTO>(arg0, 6, b"EELCTO", b"EEL SUI CTO", b"DEV JEETED LETS REK HIM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eel_logo_77d4e8ef39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EELCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EELCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

