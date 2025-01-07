module 0xe430d6e014350392e978f7f91b6fa035c21b8e34bf95e5c6d04aa7c72c86f0aa::grinx {
    struct GRINX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRINX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINX>(arg0, 6, b"GRINX", b"Grinx the guy", b"Grinx, just another boys' club member. Once a regular dude, turned green from degen gains, glued to bullish charts. Now searching for a new thrill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019480_c343476e7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRINX>>(v1);
    }

    // decompiled from Move bytecode v6
}

