module 0xcc0a07333ea529712bf72b19d44d7efc34f57cb9febced4234d28d7f797592d8::kmax {
    struct KMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: KMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KMAX>(arg0, 9, b"KMAX", b"Kekius Maximus", b"Meme this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/dce356506ef9e38964f4d903db13adf3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KMAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KMAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

