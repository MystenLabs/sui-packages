module 0x828407150178f9f18f15d7be6be5c2c272271ba23443feeb3c7e2ac2d695386e::patty {
    struct PATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATTY>(arg0, 6, b"PATTY", b"Krabby Patty", b"Introducing Krabby Patty!! the latest token to make waves on the SUI NETWORK. Inspired by the beloved underwater icon, Krabby $Patty.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigw66c2pjztwsqo5yl4jhdoe2wpcderh5hvv222qeozcyropqv24y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PATTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

