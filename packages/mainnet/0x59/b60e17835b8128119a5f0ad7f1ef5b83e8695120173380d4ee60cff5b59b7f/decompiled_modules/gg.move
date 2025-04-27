module 0x59b60e17835b8128119a5f0ad7f1ef5b83e8695120173380d4ee60cff5b59b7f::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 6, b"GG", b"GorillaGrip", b"1 Gorilla versus 100 Humans", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiejddzqsrwzpvv2e4x4wtrzcdfxjubi7zgpewxvlmugsrhioeul6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

