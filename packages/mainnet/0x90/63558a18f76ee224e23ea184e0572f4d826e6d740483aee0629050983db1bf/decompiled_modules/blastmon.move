module 0x9063558a18f76ee224e23ea184e0572f4d826e6d740483aee0629050983db1bf::blastmon {
    struct BLASTMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASTMON>(arg0, 6, b"BLASTMON", b"Blastmon On Sui", b"Blastmon is more than a meme, It's a movement with no tax, renounced ownership, explosive branding and a future ready roadmap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreictkuqof332s3lq6hsxc7hhn3rf5lpo5poadhhdd75geqeipj4ddq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLASTMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

