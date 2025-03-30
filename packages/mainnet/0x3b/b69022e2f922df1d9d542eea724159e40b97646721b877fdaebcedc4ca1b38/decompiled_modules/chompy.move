module 0x3bb69022e2f922df1d9d542eea724159e40b97646721b877fdaebcedc4ca1b38::chompy {
    struct CHOMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMPY>(arg0, 6, b"CHOMPY", b"Chompy", b"$CHOMPY - Sui's apex meme shark. No rugs, just bites. Memes flowing. Swim or get eaten.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/oo_cc63f360d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

