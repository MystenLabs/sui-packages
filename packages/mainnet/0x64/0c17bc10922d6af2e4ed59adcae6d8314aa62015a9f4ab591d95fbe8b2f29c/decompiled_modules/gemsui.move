module 0x640c17bc10922d6af2e4ed59adcae6d8314aa62015a9f4ab591d95fbe8b2f29c::gemsui {
    struct GEMSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GEMSUI>, arg1: 0x2::coin::Coin<GEMSUI>) {
        0x2::coin::burn<GEMSUI>(arg0, arg1);
    }

    fun init(arg0: GEMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEMSUI>(arg0, 9, b"gemsui", b"gem", b"t.me/gemsuitoks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/sI1MGmH.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEMSUI>>(v1);
        0x2::coin::mint_and_transfer<GEMSUI>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GEMSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GEMSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

