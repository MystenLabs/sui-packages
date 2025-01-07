module 0x5c7e265265c27ce6467d56fda179ed2a7f2b8d41a465964b3a0bf70dca2a0aa3::tryed {
    struct TRYED has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRYED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYED>(arg0, 9, b"TRYED", x"5452594ec4b04e47", b"TRY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/23fd6ebecff65f293deb4c861fcaebdeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRYED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

