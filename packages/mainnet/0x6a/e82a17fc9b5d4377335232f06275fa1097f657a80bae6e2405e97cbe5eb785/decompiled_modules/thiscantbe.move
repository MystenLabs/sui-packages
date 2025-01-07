module 0x6ae82a17fc9b5d4377335232f06275fa1097f657a80bae6e2405e97cbe5eb785::thiscantbe {
    struct THISCANTBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: THISCANTBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THISCANTBE>(arg0, 6, b"ThisCantBE", b"Cantbe", b"NONO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732614851115.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THISCANTBE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THISCANTBE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

