module 0x8a8fcb892c18ab26c3a2d79853987bbd2e60bb84693533cdd18c7fe53433afc4::meve {
    struct MEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEVE>(arg0, 6, b"MEVE", b"Eve the pallas's cat", b"Meet Eve - a young female Pallas's cat (Manul) born in the spring of 2020 in Novosibirsk zoo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/buy_60e08c331b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

