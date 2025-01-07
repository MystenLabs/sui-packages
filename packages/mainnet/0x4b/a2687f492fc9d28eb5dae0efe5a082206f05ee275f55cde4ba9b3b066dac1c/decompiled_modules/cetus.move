module 0x4ba2687f492fc9d28eb5dae0efe5a082206f05ee275f55cde4ba9b3b066dac1c::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS>(arg0, 6, b"CETUS", b"aCETUS v2 (Bridge at: cetusv2.com)", b"Cetus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/200x200/25114.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CETUS>(&mut v2, 10000000000 * 0x1::u64::pow(10, 6), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

