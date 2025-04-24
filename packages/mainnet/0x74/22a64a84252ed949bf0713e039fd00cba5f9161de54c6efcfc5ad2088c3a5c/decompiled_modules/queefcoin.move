module 0x7422a64a84252ed949bf0713e039fd00cba5f9161de54c6efcfc5ad2088c3a5c::queefcoin {
    struct QUEEFCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUEEFCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUEEFCOIN>(arg0, 6, b"Queefcoin", b"QUEEFCOIN", x"4e6f205447206c65742074686520776f6d656e20717565656620696e2070656163650a0a5468652046617274636f696e206265746120706c6179206f6e205375690a0a536f6c616e6120646567656e732061726520636f6d696e6720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4616_7564e22e10.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUEEFCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUEEFCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

