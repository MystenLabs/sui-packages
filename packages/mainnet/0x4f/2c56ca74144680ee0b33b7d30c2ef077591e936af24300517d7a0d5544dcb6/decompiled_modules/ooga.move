module 0x4f2c56ca74144680ee0b33b7d30c2ef077591e936af24300517d7a0d5544dcb6::ooga {
    struct OOGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOGA>(arg0, 9, b"OOGA", b"OOGA", b"ooga booga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OOGA>(&mut v2, 6000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OOGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

