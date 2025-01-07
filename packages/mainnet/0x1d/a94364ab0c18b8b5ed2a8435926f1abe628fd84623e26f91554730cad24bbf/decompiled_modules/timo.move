module 0x1da94364ab0c18b8b5ed2a8435926f1abe628fd84623e26f91554730cad24bbf::timo {
    struct TIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMO>(arg0, 6, b"TIMO", b"Timo", b"Timo is a revolutionary meme coin project centered around the iconic character Timo, a lion known for his strength, wisdom, and charm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008576_28be28a61f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

