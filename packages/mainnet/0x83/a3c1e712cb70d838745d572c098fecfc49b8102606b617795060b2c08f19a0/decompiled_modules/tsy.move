module 0x83a3c1e712cb70d838745d572c098fecfc49b8102606b617795060b2c08f19a0::tsy {
    struct TSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSY>(arg0, 9, b"TSY", b"SRYJSRYJ", b"SYTJSYTJ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f129f1deee5a7180663d6dba0a799b35blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

