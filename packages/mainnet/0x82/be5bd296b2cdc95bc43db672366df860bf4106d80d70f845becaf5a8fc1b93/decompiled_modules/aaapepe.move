module 0x82be5bd296b2cdc95bc43db672366df860bf4106d80d70f845becaf5a8fc1b93::aaapepe {
    struct AAAPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPEPE>(arg0, 6, b"AAAPEPE", b"$AAA PEPE ON SUI", b"the top pepe on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaapepe_ddab2eb3fc_67cba8db12.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

