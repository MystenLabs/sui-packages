module 0x76ad18375c6931e7444d6d787008d90629094048d203b36f982827fcfea17e42::kqu {
    struct KQU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KQU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KQU>(arg0, 6, b"KQU", b"jmu", b"twj k", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihol7uhucclq7o2abx6cuh4u3x7d74acldmxsohsm6w3sdqi5gknm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KQU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KQU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

