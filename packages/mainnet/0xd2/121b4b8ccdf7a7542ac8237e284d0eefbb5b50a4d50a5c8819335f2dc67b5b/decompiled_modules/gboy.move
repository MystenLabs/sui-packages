module 0xd2121b4b8ccdf7a7542ac8237e284d0eefbb5b50a4d50a5c8819335f2dc67b5b::gboy {
    struct GBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBOY>(arg0, 6, b"GBOY", b"Gboy Bot", b"Injoy the game with Gboy bot , open the new experiance for yourself and turn the game ON !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie4jaygpdoogy7lykbis6lwx3gx62kdvdab3vizhpystvp2z6xi4m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GBOY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

