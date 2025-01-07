module 0x93e7b8bb753fc7a8febd027bb471e823b5767a10868ee234680e3e3e4239b98a::pampit {
    struct PAMPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAMPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAMPIT>(arg0, 6, b"PAMPIT", b"PAMP IT", b"Every time someone tries to sell this token, mysterious character comes in to the rescue and PAMPs it back!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pampit_379316af08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAMPIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAMPIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

