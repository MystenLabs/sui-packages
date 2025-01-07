module 0x68ee15954b45f599a6e858159429087d8238cd80f58eaddf1bef746bf6afb10b::powsui {
    struct POWSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POWSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POWSUI>(arg0, 9, b"POWSui", b"Power Lifting Guy", b"Power Lifting for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fb34c2debd527ab1ae71b17fdebc0f5cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POWSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POWSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

