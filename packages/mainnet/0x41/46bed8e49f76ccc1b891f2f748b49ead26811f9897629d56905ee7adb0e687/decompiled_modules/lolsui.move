module 0x4146bed8e49f76ccc1b891f2f748b49ead26811f9897629d56905ee7adb0e687::lolsui {
    struct LOLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLSUI>(arg0, 6, b"Lolsui", b"Lol", b"Lol on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003443_3df431f242.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

