module 0x6d84b66fefc815068f11fa8b44349757ae26f65329437082c194b125013b8e8::gra {
    struct GRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRA>(arg0, 9, b"GRA", b"Granitka", x"d0bfd180d0bed181d182d0be20d180d0bed184d0bb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5af8da2f2edf60c88a7320f522334a95blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

