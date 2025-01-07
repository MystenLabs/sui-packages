module 0x6d719a3192bc127e4d5a75ad352fe12ba2dafc08cd60f66e1377550973865d62::bestsui {
    struct BESTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BESTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BESTSUI>(arg0, 9, b"BESTSUI", b"BESTSUI", b"Bestsui token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/en/8/8b/Confesiones_de_invierno.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BESTSUI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BESTSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BESTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

