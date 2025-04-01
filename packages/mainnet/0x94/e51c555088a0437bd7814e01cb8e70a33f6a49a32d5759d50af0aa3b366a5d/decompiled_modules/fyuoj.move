module 0x94e51c555088a0437bd7814e01cb8e70a33f6a49a32d5759d50af0aa3b366a5d::fyuoj {
    struct FYUOJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYUOJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYUOJ>(arg0, 9, b"FYUOJ", b"kdyukd", b"ey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a0e876453c610c4434bb91a16d943e58blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FYUOJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYUOJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

