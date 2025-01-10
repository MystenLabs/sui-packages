module 0x8a1f2a9d659de49d88db56104b72fe21d86d4fb183ab1fc59f70e687ab27450e::aiphone {
    struct AIPHONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPHONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPHONE>(arg0, 9, b"AIPHONE", b"AIPhone  Sui", b"AIPhone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/73b42c92840bdf50d41e561be2b02e1ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIPHONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPHONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

