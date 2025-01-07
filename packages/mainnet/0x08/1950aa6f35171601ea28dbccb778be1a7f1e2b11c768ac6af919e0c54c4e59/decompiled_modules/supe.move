module 0x81950aa6f35171601ea28dbccb778be1a7f1e2b11c768ac6af919e0c54c4e59::supe {
    struct SUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPE>(arg0, 6, b"SUPE", b"SUI PEPE", b"SUI PEPE - a new, based, PEPE-inspired token, a new token on SUI. Its strength lies in the accessibility and power of the new meme community. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pupe_f7e7129d90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

