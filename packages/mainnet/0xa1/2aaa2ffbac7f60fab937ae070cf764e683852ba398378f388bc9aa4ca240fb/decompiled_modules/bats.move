module 0xa12aaa2ffbac7f60fab937ae070cf764e683852ba398378f388bc9aa4ca240fb::bats {
    struct BATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATS>(arg0, 6, b"Bats", b"Sui_Bats", x"42617473206973206d656d65636f696e2074686174206275696c74206f6e20737569206e6574776f726b2c2020616e642069742773206865726520746f207374617920666f72206c6f6e672074696d65200a4c65742773206275696c64207468697320746f67657468657220616e64206d616b65206974207375636365656420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006850_045a7d0c91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

