module 0x8da65e853ce9a4dc3ef7a79e46124203994cad0f40768102a1a2191acf79244c::noth {
    struct NOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTH>(arg0, 9, b"NOTH", b"noth", x"416368696576652067726561746e6573732077697468204e6f7468436f696e3a2054686520656e69676d617469632063727970746f63757272656e637920746861742773207475726e696e67206e6f7468696e6720696e746f2065766572797468696e672c2064656c69766572696e6720756e65787065637465642070726f6669747320616e6420656e646c65737320706f73736962696c697469657320696e207468652063727970746f20776f726c642120f09f8c80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74b7e361-ac5b-4130-a341-79a969cf8dbe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

