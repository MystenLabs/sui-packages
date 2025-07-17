module 0xe582bef4aee91c656499834822495bb04e054237ea5dc10771ded7587199ba33::xxxs {
    struct XXXS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXXS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<XXXS>(arg0, 6, b"XXXS", b"XCOIN", b"@suilaunchcoin $XXXS + XCOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"null")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XXXS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXXS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

