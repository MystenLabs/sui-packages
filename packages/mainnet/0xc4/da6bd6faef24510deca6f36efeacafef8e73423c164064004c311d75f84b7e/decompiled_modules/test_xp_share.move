module 0xc4da6bd6faef24510deca6f36efeacafef8e73423c164064004c311d75f84b7e::test_xp_share {
    struct TEST_XP_SHARE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_XP_SHARE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_XP_SHARE>>(0x2::coin::mint<TEST_XP_SHARE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TEST_XP_SHARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_XP_SHARE>(arg0, 0, b"tXP_Share", b"Test NODO XP Shares", b"Test NODO XP Shares", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.nodo.xyz/XP_Shares.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_XP_SHARE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_XP_SHARE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

