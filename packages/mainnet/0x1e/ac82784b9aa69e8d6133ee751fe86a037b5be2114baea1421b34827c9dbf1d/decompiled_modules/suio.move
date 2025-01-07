module 0x1eac82784b9aa69e8d6133ee751fe86a037b5be2114baea1421b34827c9dbf1d::suio {
    struct SUIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIO>(arg0, 6, b"SUIO", b"Sui Olaf", b"At Sui Olaf, every step is an adventureearn fun rewards, collect exclusive NFTs, and grow with the coolest community in Web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_W5_Enz_400x400_0a5d6c977c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

