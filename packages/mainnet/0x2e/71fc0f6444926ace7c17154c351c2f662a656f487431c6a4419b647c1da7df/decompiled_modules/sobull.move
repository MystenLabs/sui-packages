module 0x2e71fc0f6444926ace7c17154c351c2f662a656f487431c6a4419b647c1da7df::sobull {
    struct SOBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOBULL>(arg0, 9, b"SoBULL", b"SoBull", b"$SoBULL - A Fan Meme Token of #Sui Mascot - SoBull!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DBNCHKkwHLkP7TSnaqarXqC3tPhxU6ss7G5kBW6yt1zW.png?size=xl&key=6f61fb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOBULL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOBULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

