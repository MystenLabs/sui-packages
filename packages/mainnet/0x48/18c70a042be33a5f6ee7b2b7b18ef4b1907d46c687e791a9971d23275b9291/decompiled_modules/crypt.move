module 0x4818c70a042be33a5f6ee7b2b7b18ef4b1907d46c687e791a9971d23275b9291::crypt {
    struct CRYPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPT>(arg0, 9, b"CRYPT", b"cryptic message", b"who knows what this cryptic message means`?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3321aa8140a67a0551892ce35fa4d4cfblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

