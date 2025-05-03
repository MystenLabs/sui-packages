module 0xd4180c825c3870653c72cd06cfa8996e2748cb3ee39b41a92192d08e23d6917b::mm {
    struct MM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MM>(arg0, 9, b"MM", b"gm", b"Good morning", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4f803fb37a2a78ada00b3024289f522eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

