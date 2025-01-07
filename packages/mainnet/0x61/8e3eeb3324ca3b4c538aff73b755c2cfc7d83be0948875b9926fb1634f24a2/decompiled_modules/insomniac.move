module 0x618e3eeb3324ca3b4c538aff73b755c2cfc7d83be0948875b9926fb1634f24a2::insomniac {
    struct INSOMNIAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSOMNIAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSOMNIAC>(arg0, 6, b"INSOMNIAC", b"Insomniac", b"Sleep? Overrated. Were here for the 2 AM pumps and those unexpected gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_edc2fc29cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSOMNIAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INSOMNIAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

