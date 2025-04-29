module 0x4bf9993b1e0e9295a903b548f820d5195cf0961edb05f062739df3156f54c9da::puggy {
    struct PUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGGY>(arg0, 6, b"Puggy", b"PuggySui", b"Meme coin dog dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiflvz3ey5vg2fpmiicc2y3ncmquyiw77vm3zdoqllf6oskqp2nhou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

