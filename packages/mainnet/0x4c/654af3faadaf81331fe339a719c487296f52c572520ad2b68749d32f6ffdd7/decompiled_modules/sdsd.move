module 0x4c654af3faadaf81331fe339a719c487296f52c572520ad2b68749d32f6ffdd7::sdsd {
    struct SDSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDSD>(arg0, 6, b"SDsd", b"asd", b"aasd daawww", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiesuskd2z6y6gjzg2liblei5nmg3npr53hju2lswvbjvni4i4ej6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

