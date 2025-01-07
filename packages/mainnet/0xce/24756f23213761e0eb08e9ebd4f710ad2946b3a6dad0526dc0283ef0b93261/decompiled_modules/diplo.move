module 0xce24756f23213761e0eb08e9ebd4f710ad2946b3a6dad0526dc0283ef0b93261::diplo {
    struct DIPLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIPLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIPLO>(arg0, 6, b"DIPLO", b"Autistic Diplodocus", b"Characterized by its long neck and tail, this dinosaur had an extremely elongated body.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ss_01d7bd74a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIPLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIPLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

