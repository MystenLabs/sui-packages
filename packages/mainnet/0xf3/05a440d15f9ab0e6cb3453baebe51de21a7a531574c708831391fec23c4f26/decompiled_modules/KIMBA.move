module 0xf305a440d15f9ab0e6cb3453baebe51de21a7a531574c708831391fec23c4f26::KIMBA {
    struct KIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMBA>(arg0, 9, b"KIMBA", b"KIMBA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIMBA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KIMBA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<KIMBA>>(0x2::coin::mint<KIMBA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

