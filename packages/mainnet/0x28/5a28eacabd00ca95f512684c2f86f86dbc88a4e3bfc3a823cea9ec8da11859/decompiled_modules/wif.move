module 0x285a28eacabd00ca95f512684c2f86f86dbc88a4e3bfc3a823cea9ec8da11859::wif {
    struct WIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIF>(arg0, 6, b"WIF", b"DOG WIF SUI", b"Introducing DOG $WIF SUI, the ultimate meme coin on the SUI blockchain! Dont miss out on the paw-some fun as we bring serious humor to crypto, while wagging away the FUD like a pro.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/agg_5b07752549.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

