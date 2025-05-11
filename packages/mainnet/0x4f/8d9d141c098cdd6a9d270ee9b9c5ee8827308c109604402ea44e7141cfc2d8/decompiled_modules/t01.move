module 0x4f8d9d141c098cdd6a9d270ee9b9c5ee8827308c109604402ea44e7141cfc2d8::t01 {
    struct T01 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<T01>, arg1: 0x2::coin::Coin<T01>) {
        0x2::coin::burn<T01>(arg0, arg1);
    }

    fun init(arg0: T01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T01>(arg0, 9, b"T01", b"Test1", b"yolo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T01>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T01>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<T01>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T01>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

