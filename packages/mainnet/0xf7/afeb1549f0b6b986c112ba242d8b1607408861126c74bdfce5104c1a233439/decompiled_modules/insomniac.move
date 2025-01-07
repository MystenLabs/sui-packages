module 0xf7afeb1549f0b6b986c112ba242d8b1607408861126c74bdfce5104c1a233439::insomniac {
    struct INSOMNIAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSOMNIAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSOMNIAC>(arg0, 6, b"INSOMNIAC", b"Insomniac Sui", b"Sleep? Overrated. Were here for the 2 AM pumps and those unexpected gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_fa0ed8d180.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSOMNIAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INSOMNIAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

