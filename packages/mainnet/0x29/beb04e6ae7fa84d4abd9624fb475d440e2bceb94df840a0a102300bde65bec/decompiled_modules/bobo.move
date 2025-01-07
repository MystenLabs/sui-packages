module 0x29beb04e6ae7fa84d4abd9624fb475d440e2bceb94df840a0a102300bde65bec::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO>(arg0, 9, b"BOBO", b"Bohan", b"EGO=EGO DEATH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/12d001ee4139279edee802aebfb0630dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

