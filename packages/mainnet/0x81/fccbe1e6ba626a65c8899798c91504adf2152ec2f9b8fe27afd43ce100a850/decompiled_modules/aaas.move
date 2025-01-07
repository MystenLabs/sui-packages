module 0x81fccbe1e6ba626a65c8899798c91504adf2152ec2f9b8fe27afd43ce100a850::aaas {
    struct AAAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAS>(arg0, 6, b"AAAS", b"aaaShark", b"chow time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shark_cat_733b98f867.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

