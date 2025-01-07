module 0xdd762219ecaa0063ac8585728e885d23651ab878671a5b80e2e587f74bdf59cd::suiggu {
    struct SUIGGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGGU>(arg0, 6, b"Suiggu", b"Suiggur", b"The best sui meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiggur_74cb2d90ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

