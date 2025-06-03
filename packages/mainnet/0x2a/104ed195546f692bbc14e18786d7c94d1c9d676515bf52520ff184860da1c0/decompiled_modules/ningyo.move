module 0x2a104ed195546f692bbc14e18786d7c94d1c9d676515bf52520ff184860da1c0::ningyo {
    struct NINGYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINGYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINGYO>(arg0, 6, b"Ningyo", b"Ningyo on Sui", b"Step into the Sui blockchain and meet Ningyo. the streetwise, gold-chained fish with more attitude than a tsunami and sharper instincts than a shark. The richest fish of all is here to join Sui !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiesh642rszwbnlhklol4fyy7mby2nlizutgc7umfmfb36uffz7lty")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINGYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NINGYO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

