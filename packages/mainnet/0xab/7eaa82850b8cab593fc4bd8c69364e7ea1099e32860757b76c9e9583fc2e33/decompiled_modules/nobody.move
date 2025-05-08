module 0xab7eaa82850b8cab593fc4bd8c69364e7ea1099e32860757b76c9e9583fc2e33::nobody {
    struct NOBODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBODY>(arg0, 9, b"NOBODY", b"Nobody Sausage", b"Anybody Can be a Nobody", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/94a23f640779ef4a3740cba0badb5d8edfd900c9829c16f1b1d8921706c4f25a?width=400&height=400&fit=crop&quality=95&format=auto")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOBODY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBODY>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOBODY>>(v1);
    }

    // decompiled from Move bytecode v6
}

