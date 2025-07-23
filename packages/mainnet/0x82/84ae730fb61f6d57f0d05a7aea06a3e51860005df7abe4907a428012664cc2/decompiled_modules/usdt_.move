module 0x8284ae730fb61f6d57f0d05a7aea06a3e51860005df7abe4907a428012664cc2::usdt_ {
    struct USDT_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT_>(arg0, 9, b"USDT", b"USDT", b"DFSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/f2xXKiB2aBZbcFzd5Qyi6CmQvtk3ukJFScBMWVJ8sXm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDT_>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT_>>(v1);
    }

    // decompiled from Move bytecode v6
}

