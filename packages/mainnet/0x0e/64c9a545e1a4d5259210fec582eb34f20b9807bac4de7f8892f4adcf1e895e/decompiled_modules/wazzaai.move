module 0xe64c9a545e1a4d5259210fec582eb34f20b9807bac4de7f8892f4adcf1e895e::wazzaai {
    struct WAZZAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAZZAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAZZAAI>(arg0, 6, b"WAZZAAI", b"Wazza AI", b"AI AgEntS eVEryWheRE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7253_4cbfdc7bbd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAZZAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAZZAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

