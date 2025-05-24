module 0x684f7385ffd58b12db11c93de10547408825f1f4eeac271adba1f5e0a68da82c::ksui {
    struct KSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSUI>(arg0, 9, b"KSUI", b"kingsui", b"A new meme token powered by Persian internet humor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ec0e96f11a1d44b8ab452438b33c53c8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

