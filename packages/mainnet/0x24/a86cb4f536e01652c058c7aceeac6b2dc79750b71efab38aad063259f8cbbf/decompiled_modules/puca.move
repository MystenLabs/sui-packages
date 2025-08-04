module 0x24a86cb4f536e01652c058c7aceeac6b2dc79750b71efab38aad063259f8cbbf::puca {
    struct PUCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUCA>(arg0, 6, b"PUCA", b"Sui Puca", b"Sui Puca is a little Pikachu who loves water and makes it a spectacular memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif35bzl73q2zs36cbxs335qhp2bv4h5twn52m5iwxgxdngjkrh3mm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUCA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

