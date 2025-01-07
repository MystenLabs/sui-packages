module 0xdd1535ea908cbd7fdd8902096510e2ca5ac4e43275a362b661553ba9231d7102::tad {
    struct TAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAD>(arg0, 6, b"TAD", b"TADPOLE SUI", x"426173656420737061776e206f6620506570652e2057652061726520746865206f6666696369616c20616d7068696269616e206d6173636f74206f66205355492e200a4c69746572616c6c792c206a757374206120746164706f6c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x55027a5b06f4340cc4c82dcc74c90ca93dcb173e_d125d7c7bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

