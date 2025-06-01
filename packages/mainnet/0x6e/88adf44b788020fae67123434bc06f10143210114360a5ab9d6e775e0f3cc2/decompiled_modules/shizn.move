module 0x6e88adf44b788020fae67123434bc06f10143210114360a5ab9d6e775e0f3cc2::shizn {
    struct SHIZN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIZN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIZN>(arg0, 6, b"SHIZN", b"suishizn", b"$SHIZN a combination of Rice and Fresh Fish. Should be in your bag.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihqjor2nbfvupvzvhl5ooxey2jlvofxcd2evrcbjk7qelvpr5s2xq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIZN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHIZN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

