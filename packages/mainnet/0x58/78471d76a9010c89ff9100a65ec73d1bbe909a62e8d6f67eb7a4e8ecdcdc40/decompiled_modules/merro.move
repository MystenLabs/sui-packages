module 0x5878471d76a9010c89ff9100a65ec73d1bbe909a62e8d6f67eb7a4e8ecdcdc40::merro {
    struct MERRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERRO>(arg0, 6, b"MERRO", b"Merro on sui", b"merro spreading the green gospel of memes while unearthing the juiciest opportunities in the market with Ai ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052665_33ed017c15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

