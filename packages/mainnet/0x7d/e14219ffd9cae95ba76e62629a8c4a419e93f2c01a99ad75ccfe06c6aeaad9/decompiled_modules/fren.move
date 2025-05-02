module 0x7de14219ffd9cae95ba76e62629a8c4a419e93f2c01a99ad75ccfe06c6aeaad9::fren {
    struct FREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREN>(arg0, 6, b"FREN", b"FREN SUI", b"$FREN is the friendliest meme coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifcl3bewbdxm6tyx2t4ciguunxdz7tqomjqctfxg3zwojhmfluelq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FREN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

