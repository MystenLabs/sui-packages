module 0x87499b4b168db8690b52650fe6a578991917c26331cbfcab518a4e85b0468e35::tad {
    struct TAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAD>(arg0, 6, b"TAD", b"Sui Tad Pole", x"53756920737061776e206f6620506570652e2057652061726520746865206f6666696369616c20616d7068696269616e206d6173636f74206f66205375692e200a4c69746572616c6c792c206a757374206120746164706f6c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tad_30f026a6ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

