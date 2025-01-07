module 0xb92eedc9460e5333fa1ef9ed67ff773a822179cb8fbb8353bd093bdd067b7a77::scrw {
    struct SCRW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRW>(arg0, 6, b"SCRW", b"Screwed Guy", b"Tired of Scam? So are we join the revolution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011610_de15e4b150.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCRW>>(v1);
    }

    // decompiled from Move bytecode v6
}

