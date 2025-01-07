module 0x376bd000c71844ee37ee47fa65dfdbf063a2db9c7bf5ed0099a7af8323d561c2::drgon {
    struct DRGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRGON>(arg0, 6, b"DRGON", b"DRAGONSUI", b"Im the Dragon of Sui chain, RAWRRRRRRRRR.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dragon_sui_6cffc9f4d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

