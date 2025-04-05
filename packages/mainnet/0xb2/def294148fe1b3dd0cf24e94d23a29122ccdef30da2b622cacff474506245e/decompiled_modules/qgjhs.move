module 0xb2def294148fe1b3dd0cf24e94d23a29122ccdef30da2b622cacff474506245e::qgjhs {
    struct QGJHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: QGJHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QGJHS>(arg0, 9, b"Qgjhs", b"j", b"tyfdj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9064e3aee7e281745253642fbc944fb1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QGJHS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QGJHS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

