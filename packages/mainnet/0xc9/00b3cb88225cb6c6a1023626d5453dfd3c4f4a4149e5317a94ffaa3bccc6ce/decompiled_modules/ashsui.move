module 0xc900b3cb88225cb6c6a1023626d5453dfd3c4f4a4149e5317a94ffaa3bccc6ce::ashsui {
    struct ASHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASHSUI>(arg0, 6, b"ASHSUI", b"Ash Ketchum", b"Gonna catch dem all pokumons on SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibjcd6tvdl3tjtsa4gvux37bduywitbumtxmnw4l3ww6pxd5ncbre")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASHSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

