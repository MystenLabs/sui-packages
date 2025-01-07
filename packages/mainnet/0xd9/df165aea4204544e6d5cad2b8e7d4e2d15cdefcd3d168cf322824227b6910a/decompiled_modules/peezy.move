module 0xd9df165aea4204544e6d5cad2b8e7d4e2d15cdefcd3d168cf322824227b6910a::peezy {
    struct PEEZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEZY>(arg0, 6, b"PEEZY", b"PEEZY SUI", b" The Cool Alter Ego & Social Media Persona of Pepe - Peezy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_36_6416aa6c1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

