module 0x6f95ed2503f9d2db0a8e237ef89af92d52b77bc70871b75c5294a342f55109cb::babysui {
    struct BABYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUI>(arg0, 9, b"BABYSUI", b"BABY SUI", b"Baby SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYSUI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUI>>(v2, @0x54ec17e44a9eabd7895c112cd8c6fd06c56bfe6846e6e7eac51f897a5254ee7d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

