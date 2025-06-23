module 0xd0680e1af7da0a0011abf13fe0ef336b909169471a9d233609850b285ef02585::t {
    struct T has drop {
        dummy_field: bool,
    }

    fun init(arg0: T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T>(arg0, 6, b"T", b"test", b"test1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif3kwpak7dp3n6t2u7dajw7lunjyeiknegnide2vydxfho4nmgis4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<T>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

