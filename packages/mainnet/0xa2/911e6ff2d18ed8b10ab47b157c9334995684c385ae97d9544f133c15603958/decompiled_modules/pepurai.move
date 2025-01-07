module 0xa2911e6ff2d18ed8b10ab47b157c9334995684c385ae97d9544f133c15603958::pepurai {
    struct PEPURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPURAI>(arg0, 6, b"PEPURAI", b"Pepurai Sui", b"It is a community-driven token that combines the love for Japanese culture and art. It is the first token that merges the 'Pepe-mania' phenomenon with Japanese culture as a single meme. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/iru_Imp_Go_400x400_ba0c2e7751.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPURAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

