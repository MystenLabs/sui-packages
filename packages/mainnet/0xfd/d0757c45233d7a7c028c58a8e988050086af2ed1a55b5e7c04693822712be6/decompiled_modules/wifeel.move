module 0xfdd0757c45233d7a7c028c58a8e988050086af2ed1a55b5e7c04693822712be6::wifeel {
    struct WIFEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFEEL>(arg0, 6, b"WIFEEL", b"dogwifeel", b"HE HAS AN EEL AND HES NOT AFRAID TO USE IT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_a7aca0c856.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFEEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFEEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

