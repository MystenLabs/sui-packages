module 0xa15cdff39b38e1ff86b995658ade24bec551d724c5df2cbcb99703f41bbdfb07::liz {
    struct LIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIZ>(arg0, 9, b"LIZ", b"lizliz", b"MY MEME Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cbb8ee66a8133f6819da4d5b581f825eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

