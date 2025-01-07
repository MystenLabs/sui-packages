module 0xbe571e4fd0779340f434f731cf41bff92e42209eacb2b79481f936c2e4e6aed2::suition {
    struct SUITION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITION>(arg0, 6, b"SUITION", b"Sui Potion", b"Brewed to perfection, $SUITION brings magic and mystery to the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_25_a87d77898b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITION>>(v1);
    }

    // decompiled from Move bytecode v6
}

