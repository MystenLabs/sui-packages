module 0x5c1bc838400503f15167ab7ced1b7149cd02d70099ba5a7cc84473065365a228::newtokenexample {
    struct NEWTOKENEXAMPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWTOKENEXAMPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWTOKENEXAMPLE>(arg0, 9, b"NTE", b"New Token Example", b"An example token for demonstration", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/token-logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWTOKENEXAMPLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWTOKENEXAMPLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEWTOKENEXAMPLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NEWTOKENEXAMPLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

