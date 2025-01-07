module 0xe03d03e43def69b841891d643157f0390b59ab55ad5facaa48a8441356837462::g4 {
    struct G4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: G4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G4>(arg0, 6, b"G4", b"Gunther IV", b"Sui richest instagram dog worth $400m", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2416_5f2ad5b214.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<G4>>(v1);
    }

    // decompiled from Move bytecode v6
}

