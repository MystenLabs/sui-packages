module 0x5c79c0ab2c45682aba43b1acbe5c478d947f7c8397d47447906d6cc127e180fb::lpcoin {
    struct LPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPCOIN>(arg0, 9, b"WAL-haSUI Vault LPT", b"WAL-haSUI Haedal Vault LP Token", b"Haedal Vault LP Token, WAL-haSUI Pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://node1.irys.xyz/byrMmE8Xu83i73BKML8yQGXq9H6a-mA6pDFnIQlu_84")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

