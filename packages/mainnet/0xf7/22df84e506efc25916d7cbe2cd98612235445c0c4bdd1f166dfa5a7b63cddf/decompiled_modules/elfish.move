module 0xf722df84e506efc25916d7cbe2cd98612235445c0c4bdd1f166dfa5a7b63cddf::elfish {
    struct ELFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELFISH>(arg0, 6, b"ELFISH", b"Elvis Fishley", b"The King of Rock and Roll on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000057252_b763451e48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

