module 0x125aa9b263fd44380dab19891a535c6e582d33988c2e2cb309db4ac90fc1d893::tokenB {
    struct TOKENB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKENB>(arg0, 9, b"TOKENB", b"TOKENB", b"TOKENB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"TOKENB")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TOKENB>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENB>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKENB>>(v1);
    }

    // decompiled from Move bytecode v6
}

