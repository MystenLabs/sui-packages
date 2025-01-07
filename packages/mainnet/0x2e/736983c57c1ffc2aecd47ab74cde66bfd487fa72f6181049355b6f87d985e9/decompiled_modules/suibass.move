module 0x2e736983c57c1ffc2aecd47ab74cde66bfd487fa72f6181049355b6f87d985e9::suibass {
    struct SUIBASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBASS>(arg0, 6, b"SUIBASS", b"Sui Bass LFG", b"Just another Sui Bass swimming fast. Enjoy! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735395614225.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBASS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

