module 0x93fae78e573c122737ca03b2f2ebec9a3302eef6ad5e7879dead7d43b293827c::gboy {
    struct GBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBOY>(arg0, 6, b"GBOY", b"GBOY on SUI", b"Old Skool Gaming Culture Meets Web3 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gh_Dbj_hl_400x400_d6bc2b86c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

