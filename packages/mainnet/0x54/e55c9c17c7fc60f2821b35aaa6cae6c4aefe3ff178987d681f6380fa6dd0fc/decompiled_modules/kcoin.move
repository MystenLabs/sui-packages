module 0x54e55c9c17c7fc60f2821b35aaa6cae6c4aefe3ff178987d681f6380fa6dd0fc::kcoin {
    struct KCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KCOIN>(arg0, 8, b"KCOIN", b"KCOIN", b"this is kcoin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

