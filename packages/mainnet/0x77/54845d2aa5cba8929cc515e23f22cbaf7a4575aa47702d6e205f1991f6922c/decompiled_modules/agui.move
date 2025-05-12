module 0x7754845d2aa5cba8929cc515e23f22cbaf7a4575aa47702d6e205f1991f6922c::agui {
    struct AGUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGUI>(arg0, 9, b"AGUI", b"AI CRYPTO ", b"Too many Protocol and Tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fc6eb18c92994ea12780b4030160bb6bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

