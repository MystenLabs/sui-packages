module 0x5c6c58ff4e193a718c640656c121f655275f8ab9e51dbae452d80a1bb96689e7::ykyr {
    struct YKYR has drop {
        dummy_field: bool,
    }

    fun init(arg0: YKYR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YKYR>(arg0, 9, b"YKYR", b"YKYRonSui", x"42652070617274206f662041492f526f626fe2809973204675747572653a204a7573742042726f7773652c20536861726520446174612c20616e64204765742050616964207769746820596f7572204149204167656e7473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/f57107f0-da02-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YKYR>>(v1);
        0x2::coin::mint_and_transfer<YKYR>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YKYR>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

