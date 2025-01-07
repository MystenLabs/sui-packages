module 0xf718cec00f3e014e4caf8afeac02084d919db6f9f0e46ccf79445c569f66aec8::trn {
    struct TRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRN>(arg0, 6, b"TRN", b"TRON", b"Tron is the main character in American science fiction and adventure films.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732210500190.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

