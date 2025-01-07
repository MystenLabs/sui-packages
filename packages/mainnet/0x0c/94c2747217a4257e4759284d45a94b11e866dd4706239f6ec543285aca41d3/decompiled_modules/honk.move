module 0xc94c2747217a4257e4759284d45a94b11e866dd4706239f6ec543285aca41d3::honk {
    struct HONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONK>(arg0, 6, b"HONK", b"HONK SUI", b"Join the Circus with HONK SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_1_9e8137cb4a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

