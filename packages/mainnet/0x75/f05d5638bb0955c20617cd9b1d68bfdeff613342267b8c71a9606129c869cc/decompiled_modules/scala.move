module 0x75f05d5638bb0955c20617cd9b1d68bfdeff613342267b8c71a9606129c869cc::scala {
    struct SCALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALA>(arg0, 9, b"SCALA", b"siniy", b"BEST OF THE BEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a9ae73fcda32e9cb65df02f4e73aa8ddblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

