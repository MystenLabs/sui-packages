module 0x77cc320c2cab695610ca6aa02970aaaa7bc2d61b433d42a07695cc0a9d2565b1::pookie {
    struct POOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOKIE>(arg0, 6, b"POOKIE", b"POOKIE CAT", b"Always chasing charts and sniping memecoins, this fluffy little degen lives for the thrill of the trade. With paws on the Sui chain and eyes locked on the next moonshot, $POOKIE brings charm, chaos, and community to the memecoin world. Meow or never  ride with $POOKIE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_40c01f7169.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

