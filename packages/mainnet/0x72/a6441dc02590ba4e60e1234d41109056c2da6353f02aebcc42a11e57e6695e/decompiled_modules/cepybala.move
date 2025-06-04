module 0x72a6441dc02590ba4e60e1234d41109056c2da6353f02aebcc42a11e57e6695e::cepybala {
    struct CEPYBALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEPYBALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEPYBALA>(arg0, 6, b"CEPYBALA", b"Just Cepybala", b"IM JUST CEPYBALA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr5yzjk4ijzn6frriaikry5egwk5wdeanga2isxkjd3dkqfj7cwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEPYBALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CEPYBALA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

