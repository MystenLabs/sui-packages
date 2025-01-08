module 0x85e7da81ce38a1902a0fe259be739d4c9e776a8786fcddb20c7cdfc4e86bea9b::spengu {
    struct SPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPENGU>(arg0, 6, b"SPENGU", b"Spengu", b"SPENGU- Once upon a time, a colony of SpacePenguins lived in Antarctica, but now they don spacesuits and jump into spaceships in search of a new habitat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022510_5e6f27d4bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

