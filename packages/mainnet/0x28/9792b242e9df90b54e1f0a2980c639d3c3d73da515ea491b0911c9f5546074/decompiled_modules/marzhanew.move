module 0x289792b242e9df90b54e1f0a2980c639d3c3d73da515ea491b0911c9f5546074::marzhanew {
    struct MARZHANEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARZHANEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARZHANEW>(arg0, 9, b"Marzhanew", b"marzhan", b"Marzhan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/085299352ba60d082f3fbe47f70ae5feblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARZHANEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARZHANEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

