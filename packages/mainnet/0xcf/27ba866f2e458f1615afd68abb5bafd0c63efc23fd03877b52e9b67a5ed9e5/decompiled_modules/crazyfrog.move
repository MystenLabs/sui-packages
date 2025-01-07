module 0xcf27ba866f2e458f1615afd68abb5bafd0c63efc23fd03877b52e9b67a5ed9e5::crazyfrog {
    struct CRAZYFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAZYFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAZYFROG>(arg0, 6, b"CRAZYFROG", b"CrazyFrogSui", b"The wackiest and craziest meme coin on the block. Join our fun and friendly community and be part of the crypto madness!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000502_c82d43ca83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAZYFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAZYFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

