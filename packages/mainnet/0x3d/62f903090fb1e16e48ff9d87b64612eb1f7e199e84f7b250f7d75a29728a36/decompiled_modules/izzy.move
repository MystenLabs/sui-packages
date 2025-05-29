module 0x3d62f903090fb1e16e48ff9d87b64612eb1f7e199e84f7b250f7d75a29728a36::izzy {
    struct IZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IZZY>(arg0, 6, b"Izzy", b"IZZYSUI", b"Make meme izzy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigonvarr5hwxbrefnukvv4abiw7i5mrjkdz3tyyszde4shzplgiie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IZZY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

