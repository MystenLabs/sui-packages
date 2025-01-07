module 0x8075bac5a6c902875ed489a5e464c9c3ed1579f71428026a2bfa03471c4d56f4::szen {
    struct SZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZEN>(arg0, 6, b"Szen", b"Suizen", b"SuSuiSuisSuisSuisSuisuSuisuSuisuSuisusSuisusSuisusSuisusuSuisusuSuisusu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3044_f0ba165c62.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SZEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

