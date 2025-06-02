module 0xa56d71ca6cbf4f75d217326c110b5a8961dda0b1e5027e144c864bc75ea0936f::roggles {
    struct ROGGLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROGGLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROGGLES>(arg0, 6, b"ROGGLES", b"Roggles Sui", b"Get ready to rock the crypto world with Roggles, the naughty kitty on a mission to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifcgj2cdljfbn4uoudmklhkgyqffxxtpqfxs73wpljr5y75adnxrm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROGGLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROGGLES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

