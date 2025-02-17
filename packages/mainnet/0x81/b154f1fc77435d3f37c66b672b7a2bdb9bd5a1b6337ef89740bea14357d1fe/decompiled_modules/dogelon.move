module 0x81b154f1fc77435d3f37c66b672b7a2bdb9bd5a1b6337ef89740bea14357d1fe::dogelon {
    struct DOGELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGELON>(arg0, 6, b"DOGELON", b"Dogelon Mars on SUI", b"I am Dogelon. Dogelon Mars. Join me and together we will reach the stars... ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_HV_9f0r1_400x400_171bfbc55b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

