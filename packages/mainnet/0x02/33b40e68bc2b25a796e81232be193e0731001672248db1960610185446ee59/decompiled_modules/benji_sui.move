module 0x233b40e68bc2b25a796e81232be193e0731001672248db1960610185446ee59::benji_sui {
    struct BENJI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENJI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENJI_SUI>(arg0, 9, b"Benji_sui", b"$Benji", b"Benji is the oldest dog species on the Base network and has come to $Sui to grace the ecosystem with greatness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3beb3b67e713060f54fc4b7af261832bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BENJI_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENJI_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

