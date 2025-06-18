module 0xc8ed9124514fbcdc44e582fd13b168b232906688d997f09e372c72a1e8fa3d47::rdog {
    struct RDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDOG>(arg0, 6, b"RDOG", b"RED  DOOGGO", b"RED DOGGO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia7q6cw7wtcath2eiaayi5gv2si5h2xheiokwbfs33a5kokfiz2zq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

