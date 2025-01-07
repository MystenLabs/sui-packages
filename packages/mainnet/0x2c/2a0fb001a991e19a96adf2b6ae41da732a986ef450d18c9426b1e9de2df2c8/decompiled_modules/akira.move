module 0x2c2a0fb001a991e19a96adf2b6ae41da732a986ef450d18c9426b1e9de2df2c8::akira {
    struct AKIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKIRA>(arg0, 6, b"Akira", b"Akira", b"Artificial Intelligence Dog named Akira and we all are ready for this meta on Solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cdn.dexscreener.com/cms/images/VD0yEfRPfxP1S-Gl?width=56&height=56&fit=crop&quality=95&format=auto"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKIRA>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AKIRA>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKIRA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

