module 0x8bfb195d672bca898af3be108c6a086a7ab25288f92541210134a16742c1dd38::pearl {
    struct PEARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEARL>(arg0, 6, b"PEARL", b"SUI PEARL", b"Welcome to $PEARL, the hidden gem on sui Blockchain made of fun and community spirit, stay with us on this journey until the bonde, we're the jewell of the sea but soon we gonna be made king of the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_377c9ce64e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

