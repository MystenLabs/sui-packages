module 0xb3acde0f21d548ec6b1081d672609c48bad105565aff059d78c968c9b093c915::shibasui {
    struct SHIBASUI has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SHIBASUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHIBASUI>>(arg0, arg1);
    }

    fun init(arg0: SHIBASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBASUI>(arg0, 9, b"shiba", b"SHIBASUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.shibasui.com")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHIBASUI>(&mut v2, 80000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBASUI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

