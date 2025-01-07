module 0xc1d98e816a99e60287ae5507a1a51cd94272d3f1fb027def3e4cfe1f6103c69a::exp {
    struct EXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXP>(arg0, 9, b"Exp", b"exPatryk", b"new expatryk gey ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/874d6b334ce8e70d2b46b93d1d4bc83eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

