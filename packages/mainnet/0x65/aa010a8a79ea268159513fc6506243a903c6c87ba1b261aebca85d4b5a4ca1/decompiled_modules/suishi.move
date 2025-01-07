module 0x65aa010a8a79ea268159513fc6506243a903c6c87ba1b261aebca85d4b5a4ca1::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 9, b"suishi", b"Suishicat", b"0xebb4eb552f807a28a1601e804ccaf91796ddc46407ba1b07381333111ed29d46::suishi::SUISHI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xebb4eb552f807a28a1601e804ccaf91796ddc46407ba1b07381333111ed29d46::suishi::suishi.png?size=xl&key=2ae8e3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISHI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

