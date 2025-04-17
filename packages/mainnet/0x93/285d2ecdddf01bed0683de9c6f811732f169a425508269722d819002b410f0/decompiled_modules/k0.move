module 0x93285d2ecdddf01bed0683de9c6f811732f169a425508269722d819002b410f0::k0 {
    struct K0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: K0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K0>(arg0, 6, b"K0", b"Kill Zero Token", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://static.okx.com/cdn/web3/currency/token/small/56-0xcdc80a63d24bb2b3c7de48ef4a69a00000000000-96?v=1744831629580&x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K0>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<K0>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K0>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

