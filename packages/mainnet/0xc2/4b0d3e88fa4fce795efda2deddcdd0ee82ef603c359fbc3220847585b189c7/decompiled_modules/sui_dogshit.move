module 0xc24b0d3e88fa4fce795efda2deddcdd0ee82ef603c359fbc3220847585b189c7::sui_dogshit {
    struct SUI_DOGSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_DOGSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_DOGSHIT>(arg0, 6, b"SUI DOGSHIT", b"Sui Dogshit Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_DOGSHIT>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_DOGSHIT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI_DOGSHIT>>(v2);
    }

    // decompiled from Move bytecode v6
}

