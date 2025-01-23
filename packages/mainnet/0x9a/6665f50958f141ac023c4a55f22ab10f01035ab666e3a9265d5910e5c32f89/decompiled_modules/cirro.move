module 0x9a6665f50958f141ac023c4a55f22ab10f01035ab666e3a9265d5910e5c32f89::cirro {
    struct CIRRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIRRO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CIRRO>(arg0, 6, b"CIRRO", b"Cabdiraxmaan Maxamed Cabdillaahi Cirro by SuiAI", b"Cabdiraxmaan Maxamed Cabdillaahi Cirro is a Somaliland politician and diplomat who has been the 6th and current President of Somaliland since 12 December 2024. Abdirahman served as speaker of the Somaliland House of Representatives during most of the first elected parliament.[1][2][3][4] He was announced as the presidential nominee in the 2024 Somaliland presidential election for the Waddani Party.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000018748_54908c99f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CIRRO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIRRO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

