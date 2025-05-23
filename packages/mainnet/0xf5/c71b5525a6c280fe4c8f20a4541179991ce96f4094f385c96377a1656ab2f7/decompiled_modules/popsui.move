module 0xf5c71b5525a6c280fe4c8f20a4541179991ce96f4094f385c96377a1656ab2f7::popsui {
    struct POPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPSUI>(arg0, 2, b"POPSUI", b"POPSUI", b"POPSUIIIIIIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/uAdFrJl.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPSUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<POPSUI>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<POPSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<POPSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

