module 0xd7ba80e7c03fc0834f9578a8fddb562b1de07705ee2231128948e399cf26850e::soldi {
    struct SOLDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLDI>(arg0, 6, b"SOLDI", b"Soldi", b"$SOLDI of Sui. Soldies unite to bring down Sol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sff_92dbcd5ced.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

