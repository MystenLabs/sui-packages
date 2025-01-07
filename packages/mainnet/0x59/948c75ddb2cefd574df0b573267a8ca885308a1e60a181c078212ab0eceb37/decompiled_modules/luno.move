module 0x59948c75ddb2cefd574df0b573267a8ca885308a1e60a181c078212ab0eceb37::luno {
    struct LUNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNO>(arg0, 6, b"LUNO", b"LUNO", b"The Riftborne Legend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/501-97yp7DoguD5LNeW6TJixSo6RDBkzBqaACn4avE4Xpump-98.png/type=default_350_0?v=1736181479793&x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUNO>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUNO>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

