module 0x592eb60068bb16c398ec69323fe5f4f2f3a5ac7e50e2818077be51e81d2708b::kamek {
    struct KAMEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMEK>(arg0, 9, b"KAMEK", b"Kamek", x"576520616c6c206c6f7665206d6167696320f09f94ae2020576520616c6c2061646f7265204b616d656b20f09fa7b9202054656c656772616d3a2068747470733a2f2f742e6d652f6b616d656b7375692020547769747465723a2068747470733a2f2f747769747465722e636f6d2f6b616d656b7375692020576562736974653a2068747470733a2f2f6b616d656b2e73697465", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/kameksui/kamek/refs/heads/main/kamek.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAMEK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMEK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

