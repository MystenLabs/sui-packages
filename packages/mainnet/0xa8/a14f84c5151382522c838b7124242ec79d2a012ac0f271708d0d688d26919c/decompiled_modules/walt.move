module 0xa8a14f84c5151382522c838b7124242ec79d2a012ac0f271708d0d688d26919c::walt {
    struct WALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALT>(arg0, 9, b"WALT", b"wal", b"new collection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9a37b0b9ba91739ae0de1d0309668a2fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

