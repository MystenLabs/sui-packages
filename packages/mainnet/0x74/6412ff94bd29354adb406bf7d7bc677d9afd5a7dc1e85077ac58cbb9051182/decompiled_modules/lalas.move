module 0x746412ff94bd29354adb406bf7d7bc677d9afd5a7dc1e85077ac58cbb9051182::lalas {
    struct LALAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALAS>(arg0, 6, b"Lalas", b"lala", b"Lalals is a meme coin for the masses it brings joy to everyone !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidog_e86692ce8c.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LALAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

