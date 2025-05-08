module 0x7e9672002d1c0ac9c5707d1b9b281623cdd4a854c018e6e182ff884c4aa3d1d5::suikachu {
    struct SUIKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKACHU>(arg0, 6, b"SUIKACHU", b"Suikachu Pokemon", b"SUIKA SUIKA CHUUUUUUUUU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia3miepglgvan4tfiohgvmpil4fpiuwdb5ubhjzmxprpvl7q2sz7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIKACHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

