module 0x2efd588e4ec2a96ce15ab088dda6d39073f86b74445a750fbe43162e712888f5::adssadsdads {
    struct ADSSADSDADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADSSADSDADS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADSSADSDADS>(arg0, 6, b"ADSSADsdads", b"asdasd", b"sdasfafsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiausiabi6ej4ftvikttwijpjk4p5uyikm2dinhnh3dbemhgcjxuim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADSSADSDADS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADSSADSDADS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

