module 0x63cbed73c494aa3511b9322e2885bb42ee10712e6382d17ad58fc893794fb379::dogsifhat {
    struct DOGSIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSIFHAT>(arg0, 2, b"dogsifhat", b"SIF", b"dogsifhat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/B37gsNr.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSIFHAT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGSIFHAT>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGSIFHAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGSIFHAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

