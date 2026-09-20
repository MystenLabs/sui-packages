module 0x54453c7245e0bb9a5426f94297a8e1da9edbde69db4e5ec9d65a40641577bf91::fcat {
    struct FCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FCAT>(arg0, 6, 0x1::string::utf8(b"FCAT"), 0x1::string::utf8(b"FartCAT"), 0x1::string::utf8(b"Cat farts cat goes up"), 0x1::string::utf8(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmnw9yQ-EcdTNqb6BCCKXbv1yYUZDh3UytbwIKdZj68w&s=10"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FCAT>>(0x2::coin_registry::finalize<FCAT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

