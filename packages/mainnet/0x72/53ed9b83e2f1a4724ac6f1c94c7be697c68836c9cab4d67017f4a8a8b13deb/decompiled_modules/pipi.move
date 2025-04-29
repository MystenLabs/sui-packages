module 0x7253ed9b83e2f1a4724ac6f1c94c7be697c68836c9cab4d67017f4a8a8b13deb::pipi {
    struct PIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPI>(arg0, 9, b"PIPI", b"Pietra ", b"It is a coin filled with canine love, for PET. Be sure to leave some of your love here. Come!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d6272149965a8b7227d74f22c4d742a0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

