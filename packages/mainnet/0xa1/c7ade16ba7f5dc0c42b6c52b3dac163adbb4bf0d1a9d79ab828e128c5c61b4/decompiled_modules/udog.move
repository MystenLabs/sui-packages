module 0xa1c7ade16ba7f5dc0c42b6c52b3dac163adbb4bf0d1a9d79ab828e128c5c61b4::udog {
    struct UDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UDOG>(arg0, 6, b"UDOG", b"The Underdog", b"The Underdog of SUI is here to rise again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicjyn6kctrfjv4qquvxjvsjueqpgc7nuamd45smhkm2d7wxrgpzre")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

