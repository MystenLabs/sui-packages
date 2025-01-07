module 0x8a00862dccf32fa3dbe7a80b13c3981075ba6ec66024db2f2eac0f450f038552::usui {
    struct USUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USUI>(arg0, 6, b"USUI", b"Unicorn Sui Dust", b"Unicorn Sui Dust: Magical, shiny, pointless, and irresistibly chaotic $USUI on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatar_83d2f81b9b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

