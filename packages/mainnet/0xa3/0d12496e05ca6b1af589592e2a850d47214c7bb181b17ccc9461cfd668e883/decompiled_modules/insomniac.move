module 0xa30d12496e05ca6b1af589592e2a850d47214c7bb181b17ccc9461cfd668e883::insomniac {
    struct INSOMNIAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSOMNIAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSOMNIAC>(arg0, 6, b"INSOMNIAC", b"Insomniac", b"Sleep? Overrated. Were here for the 2 AM pumps and those unexpected gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_7467342bcf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSOMNIAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INSOMNIAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

