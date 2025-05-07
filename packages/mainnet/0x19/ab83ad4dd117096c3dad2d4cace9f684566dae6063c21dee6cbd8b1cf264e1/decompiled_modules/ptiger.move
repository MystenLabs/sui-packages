module 0x19ab83ad4dd117096c3dad2d4cace9f684566dae6063c21dee6cbd8b1cf264e1::ptiger {
    struct PTIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTIGER>(arg0, 6, b"PTIGER", b"PUMPTIGER", b"Welcome to Pump Tiger, the ultimate meme token on SUI Chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicj7tes5fwzpft3zzmemxm4l4fbsdizjku7275cc2lnmdyelakdvy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PTIGER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

