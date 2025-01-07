module 0xeb400145365f0e79182d0d4fd02b28056839ddf869d19ddc81caf095a5c85644::shorse {
    struct SHORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHORSE>(arg0, 6, b"Shorse", b"Suihorse", b"The most cute and funny animal on the sea coming to Sui ecosystem, horse always help human to conqueror everything and this cute seahorse cult ready to help Sui to conqueror blockchain world and to become number 1  most use chain, join the cult", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000089752_eccaddb6d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

