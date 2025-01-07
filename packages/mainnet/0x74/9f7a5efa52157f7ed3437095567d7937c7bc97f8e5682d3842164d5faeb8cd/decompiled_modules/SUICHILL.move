module 0x749f7a5efa52157f7ed3437095567d7937c7bc97f8e5682d3842164d5faeb8cd::SUICHILL {
    struct SUICHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHILL>(arg0, 9, b"SUICHILL", b"SUICHILL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICHILL>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUICHILL>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUICHILL>>(0x2::coin::mint<SUICHILL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

