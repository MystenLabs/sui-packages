module 0xcff602c6cac0c78079c3c32ba102aa40f868256d7142973743dda062e067c9b4::suitoshi {
    struct SUITOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOSHI>(arg0, 6, b"SUITOSHI", b"Suitoshi Nakamoto", b"Suitoshi Nakamoto is an innovative project on the Sui Blockchain, blending the mysterious legacy of Satoshi Nakamoto with SuI high throughput technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieh2jx3p3lxfke4egclxnpv6zjikaun5yyvtvqqinm6bifo7icnqe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITOSHI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

