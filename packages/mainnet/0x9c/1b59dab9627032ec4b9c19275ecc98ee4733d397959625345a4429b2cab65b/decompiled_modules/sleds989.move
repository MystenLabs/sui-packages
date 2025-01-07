module 0x9c1b59dab9627032ec4b9c19275ecc98ee4733d397959625345a4429b2cab65b::sleds989 {
    struct SLEDS989 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEDS989, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEDS989>(arg0, 6, b"SLEDS989", b"SLEDS", b"suilend into the room with my mom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001190_8fbabcdee8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEDS989>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLEDS989>>(v1);
    }

    // decompiled from Move bytecode v6
}

