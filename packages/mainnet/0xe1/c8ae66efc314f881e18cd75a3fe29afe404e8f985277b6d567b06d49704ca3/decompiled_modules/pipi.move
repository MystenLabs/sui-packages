module 0xe1c8ae66efc314f881e18cd75a3fe29afe404e8f985277b6d567b06d49704ca3::pipi {
    struct PIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPI>(arg0, 9, b"PIPI", b"Sui Pipi", b"pipi on his way to steal your girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmPLPBCzTQibMZF6m6uEQBHeXWNh5Ce4L9G9wxhLwysjoz?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIPI>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

