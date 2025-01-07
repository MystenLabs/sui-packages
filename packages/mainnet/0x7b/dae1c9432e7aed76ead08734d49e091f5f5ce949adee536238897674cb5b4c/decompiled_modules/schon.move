module 0x7bdae1c9432e7aed76ead08734d49e091f5f5ce949adee536238897674cb5b4c::schon {
    struct SCHON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHON>(arg0, 6, b"SCHON", b"Suichon", b"Sui chon - Give rice to Suichon who lives in Sui's water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1343_ce8b73e0d9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHON>>(v1);
    }

    // decompiled from Move bytecode v6
}

