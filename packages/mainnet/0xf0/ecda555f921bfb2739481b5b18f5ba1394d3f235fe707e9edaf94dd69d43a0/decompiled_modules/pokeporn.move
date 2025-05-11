module 0xf0ecda555f921bfb2739481b5b18f5ba1394d3f235fe707e9edaf94dd69d43a0::pokeporn {
    struct POKEPORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEPORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEPORN>(arg0, 6, b"POKEPORN", b"vaporeon nude", b"whatch my porn guys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihvak7w45bgf7scjvjrwkn3zh7lkxcvcywy7kwwuuyr5yuvdrwbrm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEPORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEPORN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

