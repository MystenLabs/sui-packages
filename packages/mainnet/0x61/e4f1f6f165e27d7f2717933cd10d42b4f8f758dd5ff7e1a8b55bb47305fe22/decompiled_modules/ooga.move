module 0x61e4f1f6f165e27d7f2717933cd10d42b4f8f758dd5ff7e1a8b55bb47305fe22::ooga {
    struct OOGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOGA>(arg0, 9, b"OOGA", b"Booga", b"ooga booga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OOGA>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OOGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

