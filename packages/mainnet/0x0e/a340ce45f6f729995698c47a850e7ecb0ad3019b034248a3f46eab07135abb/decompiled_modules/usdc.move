module 0xea340ce45f6f729995698c47a850e7ecb0ad3019b034248a3f46eab07135abb::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"USDC v2 (complete bridge: usdv2.com)", b"complete migration", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/usd-coin-usdc-logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDC>(&mut v2, 10000000000 * 0x1::u64::pow(10, 6), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

