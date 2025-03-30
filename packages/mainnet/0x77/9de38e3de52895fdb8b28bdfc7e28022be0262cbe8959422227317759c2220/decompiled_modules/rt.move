module 0x779de38e3de52895fdb8b28bdfc7e28022be0262cbe8959422227317759c2220::rt {
    struct RT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RT>(arg0, 9, b"RT", b"Reapertee", b"A crypto enthusiast with deaths game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/87efea7d1f56f2618efef7521ef33c0eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

