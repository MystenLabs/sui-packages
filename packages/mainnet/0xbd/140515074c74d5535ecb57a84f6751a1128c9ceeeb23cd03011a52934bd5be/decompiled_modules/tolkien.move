module 0xbd140515074c74d5535ecb57a84f6751a1128c9ceeeb23cd03011a52934bd5be::tolkien {
    struct TOLKIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOLKIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOLKIEN>(arg0, 9, b"Tolkien", b"Tolkien Tolkien", b"Tolkien Tolkien Tolkien", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreienxxqtwxxty6amru3szrs55xryplkwgpumpye62kr6tiqlg3nxay.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOLKIEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOLKIEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOLKIEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

