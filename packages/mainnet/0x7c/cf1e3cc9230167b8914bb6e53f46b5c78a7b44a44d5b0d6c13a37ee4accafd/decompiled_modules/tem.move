module 0x7ccf1e3cc9230167b8914bb6e53f46b5c78a7b44a44d5b0d6c13a37ee4accafd::tem {
    struct TEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEM>(arg0, 9, b"TEM", b"JAPAN  Temple", b"JAPAN Temple Token  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b315a5e07f7bfdb44f4ff7e8a745b193blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

