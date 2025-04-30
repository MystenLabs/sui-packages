module 0x1dcea1514f9948f688c648cda8f07221f1c2288329a408c2c4109287dc936612::mgirls {
    struct MGIRLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGIRLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGIRLS>(arg0, 6, b"MGirls", b"MOON GIRLS", b"z", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiewinmgmyz5y5ibq7hk6rrc3ty32ygfkajxg6potv3zghxg4wmoti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGIRLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MGIRLS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

