module 0x55012c757c37bbc1f884061f4cad9842b221a36ccc5e54d70c1de97fbb1692cd::perry {
    struct PERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERRY>(arg0, 6, b"PERRY", b"PERRY ON SUI", b"Perry the Duck often feels anxious. The meme queen will appear and give the slogan \"SPIT ON THAT THANG!\" to rally the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaa2phfblkji7bfbcljraaldlybgnktkewdfb4dkra22xb4b5eo7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PERRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

