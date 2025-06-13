module 0x424b68861bf4b94ba83b985ac4dae97f97e83ad444fc791b9a2d53a1a1bec498::allah {
    struct ALLAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALLAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALLAH>(arg0, 9, b"Allah", b"$Allah", b"?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2e52934e9e9c619cb79bbd73dd2c61d0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALLAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALLAH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

