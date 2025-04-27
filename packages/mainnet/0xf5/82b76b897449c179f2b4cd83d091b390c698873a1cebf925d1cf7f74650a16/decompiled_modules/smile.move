module 0xf582b76b897449c179f2b4cd83d091b390c698873a1cebf925d1cf7f74650a16::smile {
    struct SMILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILE>(arg0, 6, b"SMILE", b"SHE DONT CARE ANYMORE LOL", b"THE BEST MEME ON INTERNET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihekjow37es5jk6ro2wuwnykglnwkc5qc6ndghhqdcn5ztikcem5m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMILE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

