module 0xd81c1a713acb0567f311d48f7300f2350580169b0a9e397c538fcb1ce9a64879::pots {
    struct POTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTS>(arg0, 6, b"POTS", b"POT on SUI", b"hi Im Pot, made by my little brother whos autistic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z3_Zdtcq4_400x400_f09d3b19be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

