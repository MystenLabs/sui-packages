module 0xeaa25aca80a974c1128c72399a303939788b68ad5ff49a2437cc9c2bb9476a93::punk {
    struct PUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNK>(arg0, 6, b"PUNK", b"Sui Punk", b"Rebellious and bold, $PUNK defies the norms of the Sui Network. This coin is for the rule-breakers and misfits who make their own path. Be a Sui Punk!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_23_4563dccd0b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

