module 0xe7fca5a482d28e8ed00ed319e4c59da981651e1677d2892c6cfcd42ea006c150::sandy {
    struct SANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANDY>(arg0, 6, b"SANDY", b"Sandy Codex", b"First Video AI Agent powered by CODEX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/501-61yG5LCoeoqzBdopXPy6BsVPTGdRXht95L68hj5ipump-98.png/type=default_350_0?v=1735742057142&x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANDY>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SANDY>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANDY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

