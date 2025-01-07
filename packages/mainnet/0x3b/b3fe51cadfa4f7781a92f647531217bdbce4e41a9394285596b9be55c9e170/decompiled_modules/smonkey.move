module 0x3bb3fe51cadfa4f7781a92f647531217bdbce4e41a9394285596b9be55c9e170::smonkey {
    struct SMONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMONKEY>(arg0, 6, b"SMONKEY", b"SUI MONKEYS", b"Sui #1 NFT: Introducing sui Monkeys.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1368_ba484a77a9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

