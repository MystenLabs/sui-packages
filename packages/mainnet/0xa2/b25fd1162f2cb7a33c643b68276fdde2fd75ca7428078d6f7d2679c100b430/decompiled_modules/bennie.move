module 0xa2b25fd1162f2cb7a33c643b68276fdde2fd75ca7428078d6f7d2679c100b430::bennie {
    struct BENNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENNIE>(arg0, 6, b"BENNIE", b"Bennie The Frenchie", b"A Meme Coin of Empowerment! $Bennie is all about accessing your highest potential and infinite paws-abilities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cok_L93x_R_400x400_9d51e09fb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

