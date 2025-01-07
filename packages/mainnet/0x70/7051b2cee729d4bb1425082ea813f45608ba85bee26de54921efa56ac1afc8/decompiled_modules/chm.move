module 0x707051b2cee729d4bb1425082ea813f45608ba85bee26de54921efa56ac1afc8::chm {
    struct CHM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHM>(arg0, 6, b"CHM", b"Cheems", b"Cheems is an OG meme token on SUI Ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4861_5addc8cf0c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHM>>(v1);
    }

    // decompiled from Move bytecode v6
}

