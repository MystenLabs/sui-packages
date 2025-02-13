module 0xef14d923e490aa2ea64fb601674c3c25cea559414c5d4ddb4cc3964d71e9d683::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 5, b"DOG.OT", x"444f47e280a2474fe280a2544fe280a2544845e280a24d4f4f4e", b"DOG GO TO THEMOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ordinals.com/content/e79134080a83fe3e0e06ed6990c5a9b63b362313341745707a2bff7d788a1375i0")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

