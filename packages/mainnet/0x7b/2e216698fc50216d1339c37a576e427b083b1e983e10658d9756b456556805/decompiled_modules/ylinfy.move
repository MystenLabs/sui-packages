module 0x7b2e216698fc50216d1339c37a576e427b083b1e983e10658d9756b456556805::ylinfy {
    struct YLINFY has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YLINFY>, arg1: 0x2::coin::Coin<YLINFY>) {
        0x2::coin::burn<YLINFY>(arg0, arg1);
    }

    fun init(arg0: YLINFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YLINFY>(arg0, 6, b"YLY", b"YLINFY", b"ylinfy's first meme coin on sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YLINFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YLINFY>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YLINFY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YLINFY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

