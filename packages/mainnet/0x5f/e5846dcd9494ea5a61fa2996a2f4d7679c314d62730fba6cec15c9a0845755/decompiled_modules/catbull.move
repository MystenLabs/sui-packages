module 0x5fe5846dcd9494ea5a61fa2996a2f4d7679c314d62730fba6cec15c9a0845755::catbull {
    struct CATBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBULL>(arg0, 6, b"CATBULL", b"cat bull king", b" Built on SUI, Meme Cat Token offers investors the chance to be part of a fun, dynamic ecosystem with unlimited potential. Backed by a strong and growing community, this token is designed for serious investors who love a lighthearted approach to financial freedom. Join us in riding the wave of meme culture while securing your position in the future of digital assets!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DDDD_a37e5dcb10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

