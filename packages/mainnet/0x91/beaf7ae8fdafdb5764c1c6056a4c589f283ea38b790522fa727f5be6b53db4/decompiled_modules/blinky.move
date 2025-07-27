module 0x91beaf7ae8fdafdb5764c1c6056a4c589f283ea38b790522fa727f5be6b53db4::blinky {
    struct BLINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINKY>(arg0, 6, b"BLINKY", b"Blinky Cat", b"Blinky Cat  is the officially endorsed memecoin, backed by full IP rights from the iconic Blinky Cat brand.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiey64kghwvj6qh6hoxyadjs7xlenfu776cxr2gdprjpmbjbmk6c6m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLINKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

