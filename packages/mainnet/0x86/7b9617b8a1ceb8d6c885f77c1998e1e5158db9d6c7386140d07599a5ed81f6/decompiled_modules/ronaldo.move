module 0x867b9617b8a1ceb8d6c885f77c1998e1e5158db9d6c7386140d07599a5ed81f6::ronaldo {
    struct RONALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONALDO>(arg0, 9, b"RONALDO", b"RONALDO Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://images.baoangiang.com.vn/image/fckeditor/upload/2024/20240110/images/ronaldo-the-ky-21-1-5129.jpg.webp"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RONALDO>(&mut v2, 1000000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RONALDO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RONALDO>>(v2);
    }

    // decompiled from Move bytecode v6
}

