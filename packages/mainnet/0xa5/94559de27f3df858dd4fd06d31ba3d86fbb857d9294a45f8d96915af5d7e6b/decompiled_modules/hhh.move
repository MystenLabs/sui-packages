module 0xa594559de27f3df858dd4fd06d31ba3d86fbb857d9294a45f8d96915af5d7e6b::hhh {
    struct HHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHH>(arg0, 6, b"HHH", b"HENTAI!", b">\\\\<", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibu4ekewt7re3zpklzxkd5s7x7ihgocrthd75axrxn7yunocfmcna")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HHH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

