module 0xa77bc544ff1b67c0186a8bd3a63d9296abca9ed7cb911256afdee50bd32c17af::drippy {
    struct DRIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIPPY>(arg0, 6, b"DRIPPY", b"Drippy on Sui", x"4d616b696e6720776176657320696e206120736561206f662073616d656e657373210a4865792074686572652c206d6f69737475726520656e746875736961737473212049276d204472697070792c2053756927732064726f70206f6e20737465726f69647321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731319251409.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRIPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

