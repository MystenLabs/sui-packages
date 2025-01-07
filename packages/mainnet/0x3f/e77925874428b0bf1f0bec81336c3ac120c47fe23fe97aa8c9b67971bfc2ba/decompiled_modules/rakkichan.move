module 0x3fe77925874428b0bf1f0bec81336c3ac120c47fe23fe97aa8c9b67971bfc2ba::rakkichan {
    struct RAKKICHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAKKICHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAKKICHAN>(arg0, 6, b"RAKKICHAN", b"RAKKI-CHAN", x"4d656574204e6569726f7320636f7573696e0a52616b6b692d6368616e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3561_553ce038f4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAKKICHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAKKICHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

