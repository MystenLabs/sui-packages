module 0x69e5790586e024580a20e873f89b12c9253db0a1f84d4f74732a2318c40529a8::usdb {
    struct USDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDB>(arg0, 6, b"USDB", b"USDB For Test", b"USDB for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDB>>(v1);
        0x2::coin::mint_and_transfer<USDB>(&mut v2, 10000000000000000, @0x5cfbfd965a03883f92127ab43330c0b9527a949b93dd4d34b0c3012793fa807d, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

