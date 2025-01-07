module 0xb6c326c1e4a10dd5b8da319289ed4f3f7357bf0ec76382bcd588ddc18ced19e1::spw {
    struct SPW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPW>(arg0, 6, b"SPW", b"SuiPugwif", b"The Pug that doesn't quit. Biggest CTO on SU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pug_c6ce3bbac0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPW>>(v1);
    }

    // decompiled from Move bytecode v6
}

