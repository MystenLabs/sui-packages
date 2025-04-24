module 0x768b9f9195c09dd63f04c3a4d91f8cb364904407026631d36739c6c5d38f53fa::ptca23 {
    struct PTCA23 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTCA23, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTCA23>(arg0, 9, b"Ptca23", b"pitacatina", b"Nem eu sei o que significa ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e6eef3f47800cf360541e8adbd856f4eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTCA23>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTCA23>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

