module 0x358505ea066ff390cbca0abebc721c086aa30e376fad328d1afda4888f22c6ea::zine {
    struct ZINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZINE>(arg0, 6, b"ZINE", b"Zine The Dog", b"$ZINE is a cute dog, ZINE will rock the SUI meme world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050343_924cac240a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

