module 0xf761139e29e09bad7401f5d07bd0af311349eeba44184a85a32e315cf76bd867::sco {
    struct SCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCO>(arg0, 9, b"SCO", b"SUISCORP", b"YOU WILL BE POISON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7f2854714a23ba1f4d32a0e197dabc81blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

