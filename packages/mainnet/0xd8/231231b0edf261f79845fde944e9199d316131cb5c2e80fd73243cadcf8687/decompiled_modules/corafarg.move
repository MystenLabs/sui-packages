module 0xd8231231b0edf261f79845fde944e9199d316131cb5c2e80fd73243cadcf8687::corafarg {
    struct CORAFARG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORAFARG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORAFARG>(arg0, 9, b"CORAFARG", b"Coralie Fargeat", b"Born: November 24, 1976 in Paris, France", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/CORAFARG.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CORAFARG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORAFARG>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORAFARG>>(v1);
    }

    // decompiled from Move bytecode v6
}

