module 0xc6faaee7d864c199b00fd1720d490fbcc6f70da9eba132a230cefbb8fa5f461b::wif {
    struct WIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIF>(arg0, 6, b"WIF", b"DOG WIF SUI", b"Introducing DOG $WIF SUI, the ultimate meme coin on the SUI blockchain! Dont miss out on the paw-some fun as we bring serious humor to crypto, while wagging away the FUD like a pro.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/agg_4462b59eff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

