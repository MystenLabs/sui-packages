module 0xbb56b0ac56fb001090f8ad83202c219bf7e0be385f7ce9ba93b79584c0ee510::fguy {
    struct FGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGUY>(arg0, 9, b"FGUY", b"funny guy", b"funny guy drinks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/675d028007543207b3e85592b840a4cablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGUY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

