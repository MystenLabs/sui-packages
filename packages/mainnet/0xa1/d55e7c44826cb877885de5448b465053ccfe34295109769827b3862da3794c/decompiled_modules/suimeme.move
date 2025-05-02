module 0xa1d55e7c44826cb877885de5448b465053ccfe34295109769827b3862da3794c::suimeme {
    struct SUIMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEME>(arg0, 9, b"Suimeme", b"suiking", b"sui killer solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/be6c52d3cba26bb7a7a076a0cf90d677blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

