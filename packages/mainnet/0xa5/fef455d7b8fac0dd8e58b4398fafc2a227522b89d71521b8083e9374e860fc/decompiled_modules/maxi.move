module 0xa5fef455d7b8fac0dd8e58b4398fafc2a227522b89d71521b8083e9374e860fc::maxi {
    struct MAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXI>(arg0, 6, b"Maxi", b"The Sui Maxi", b"The Sui maxi knows Sui is unstoppable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifpzyffjqxjauwxq43zbtizd3j6hyqbojjtg75sh4qylvhifrurpm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAXI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

