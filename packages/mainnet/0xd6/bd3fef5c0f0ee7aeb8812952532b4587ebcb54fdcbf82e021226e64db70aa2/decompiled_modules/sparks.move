module 0xd6bd3fef5c0f0ee7aeb8812952532b4587ebcb54fdcbf82e021226e64db70aa2::sparks {
    struct SPARKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARKS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SPARKS>(arg0, 6, b"SPARKS", b"SparksAI by SuiAI", b"Sparks is a cutting-edge cryptocurrency designed to empower individuals and businesses worldwide. With its sleek golden design and shiny finish, Sparks represents innovation, value, and progress..Our mission is to provide a secure, transparent, and accessible financial ecosystem, enabling fast and efficient transactions..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000261449_69def40878.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPARKS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARKS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

