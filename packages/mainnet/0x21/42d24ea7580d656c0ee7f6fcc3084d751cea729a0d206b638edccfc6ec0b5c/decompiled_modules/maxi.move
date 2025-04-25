module 0x2142d24ea7580d656c0ee7f6fcc3084d751cea729a0d206b638edccfc6ec0b5c::maxi {
    struct MAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXI>(arg0, 6, b"Maxi", b"The Sui Maxi", b"The Sui Maxi knows Sui is unstoppable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifpzyffjqxjauwxq43zbtizd3j6hyqbojjtg75sh4qylvhifrurpm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAXI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

