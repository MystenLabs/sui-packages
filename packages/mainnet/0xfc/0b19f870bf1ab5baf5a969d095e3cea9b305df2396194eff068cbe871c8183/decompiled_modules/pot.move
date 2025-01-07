module 0xfc0b19f870bf1ab5baf5a969d095e3cea9b305df2396194eff068cbe871c8183::pot {
    struct POT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POT>(arg0, 6, b"POT", b"Pot on SUI", b"Hi Im Pot, made by my little brother whos autistic!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z3_Zdtcq4_400x400_fc3de1e6c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POT>>(v1);
    }

    // decompiled from Move bytecode v6
}

