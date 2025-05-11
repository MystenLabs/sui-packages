module 0x7a325a9b721ee048f099411a0e84c8392db5f8f0be003233431758210ae5513a::woito {
    struct WOITO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WOITO>, arg1: 0x2::coin::Coin<WOITO>) {
        0x2::coin::burn<WOITO>(arg0, arg1);
    }

    fun init(arg0: WOITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOITO>(arg0, 2, b"WOITO", b"oituy", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOITO>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 10000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOITO>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WOITO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WOITO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

