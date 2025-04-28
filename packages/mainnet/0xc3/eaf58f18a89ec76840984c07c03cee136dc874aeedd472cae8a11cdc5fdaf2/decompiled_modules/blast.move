module 0xc3eaf58f18a89ec76840984c07c03cee136dc874aeedd472cae8a11cdc5fdaf2::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAST>(arg0, 6, b"BLAST", b"Blastoise", b"Blastoise  on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blastoise_facts_728x364_cd1749cfe8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

