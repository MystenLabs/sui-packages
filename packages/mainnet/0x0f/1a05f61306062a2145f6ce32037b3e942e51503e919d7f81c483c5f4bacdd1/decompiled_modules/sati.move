module 0xf1a05f61306062a2145f6ce32037b3e942e51503e919d7f81c483c5f4bacdd1::sati {
    struct SATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATI>(arg0, 6, b"Sati", b"Hsh", b"Jsudnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiacrpzlpneywayabasla3b25l3lxw37zb7grhgk6qyjqz4p2yigh4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SATI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

