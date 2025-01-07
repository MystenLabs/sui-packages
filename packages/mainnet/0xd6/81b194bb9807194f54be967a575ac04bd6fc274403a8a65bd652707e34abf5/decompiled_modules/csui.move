module 0xd681b194bb9807194f54be967a575ac04bd6fc274403a8a65bd652707e34abf5::csui {
    struct CSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSUI>(arg0, 2, b"CSUI", b"SUICOON", b"Only a suicoon on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/buz6EZq.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CSUI>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

