module 0xc1a3e7d8c8c9d3cadf34cdac85a521078a55565653622cca356ab925aa4b6c49::pugdog {
    struct PUGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGDOG>(arg0, 6, b"PUGDOG", b"PUGGYDOG", b"Meet PUGGYDOG  The Slam-Dunk Pug Memecoin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiatbf6xulg6haehqtv4wcfh7ykq2ptarjb5jdev77mlf5fhniv6rq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUGDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

