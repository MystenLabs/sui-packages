module 0x8d8a19e7cbe040eb5f371a2bd4993df255095856c0337f881873240b2a26cada::luno {
    struct LUNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNO>(arg0, 6, b"LUNO", b"LUNO", b"The Riftborne Legend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/default-logo/token_custom_logo_default_L.png/type=default_350_0?x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUNO>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUNO>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

