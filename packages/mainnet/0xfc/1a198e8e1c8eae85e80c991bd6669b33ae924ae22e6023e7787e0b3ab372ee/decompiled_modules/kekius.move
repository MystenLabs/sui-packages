module 0xfc1a198e8e1c8eae85e80c991bd6669b33ae924ae22e6023e7787e0b3ab372ee::kekius {
    struct KEKIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKIUS>(arg0, 6, b"KEKIUS", b"KEKIUS", b"KEKIUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/1-0x26e550ac11b26f78a04489d5f20f24e3559f7dd9-97.png/type=default_350_0?v=1735475191833&x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKIUS>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KEKIUS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKIUS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

