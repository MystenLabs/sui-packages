module 0xee9fb26b92fd9677a84fa5b5133b99916eb89994b627828066c5f3389ea3d019::sini {
    struct SINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINI>(arg0, 6, b"Sini", b"Suiinu", x"535549203d2057415445520a0a494e55203d20444f470a0a574154455220444f47203a2920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036010_a73968b53c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

