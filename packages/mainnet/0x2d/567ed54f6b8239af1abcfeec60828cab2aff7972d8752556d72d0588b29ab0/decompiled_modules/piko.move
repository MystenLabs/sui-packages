module 0x2d567ed54f6b8239af1abcfeec60828cab2aff7972d8752556d72d0588b29ab0::piko {
    struct PIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKO>(arg0, 6, b"PIKO", b"Piko On Sui", b"PIKO  - Smile up, Sui on!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifl6zwyelkv4ixtf6tujzwpteoc65cwnio35iwn7jxtd65bvvkjqe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

