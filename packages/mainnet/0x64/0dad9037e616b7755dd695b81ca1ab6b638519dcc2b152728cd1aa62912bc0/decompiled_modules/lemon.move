module 0x640dad9037e616b7755dd695b81ca1ab6b638519dcc2b152728cd1aa62912bc0::lemon {
    struct LEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMON>(arg0, 9, b"LEMON", b"Lemon on SUI", b"Squeezing out memes and making waves on the SUI Blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cebd957ce24d7c96816bcc3a3ff9f062blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEMON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

