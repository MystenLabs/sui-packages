module 0x5b08bb072e6582b3b7ac6327fb3fdf23ed7ed0a67cbdb23846215bf524e34a53::pur {
    struct PUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUR>(arg0, 9, b"Pur", b"purplee", b"goof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0bdc47f7a50f1c1549a5f07d874be7e6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

