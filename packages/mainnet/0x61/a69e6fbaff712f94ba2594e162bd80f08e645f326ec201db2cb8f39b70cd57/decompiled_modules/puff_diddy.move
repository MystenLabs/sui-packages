module 0x61a69e6fbaff712f94ba2594e162bd80f08e645f326ec201db2cb8f39b70cd57::puff_diddy {
    struct PUFF_DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF_DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF_DIDDY>(arg0, 9, b"PUFF DIDDY", b"PUFF DIDDY", b"puff the did", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUFF_DIDDY>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF_DIDDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF_DIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

