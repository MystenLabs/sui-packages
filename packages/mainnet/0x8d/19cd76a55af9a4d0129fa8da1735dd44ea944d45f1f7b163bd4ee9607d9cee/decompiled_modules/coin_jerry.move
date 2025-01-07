module 0x8d19cd76a55af9a4d0129fa8da1735dd44ea944d45f1f7b163bd4ee9607d9cee::coin_jerry {
    struct COIN_JERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_JERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_JERRY>(arg0, 9, b"coin_jerry", b"Jerry", b"Coin Jerry to study simple swap", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_JERRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_JERRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN_JERRY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COIN_JERRY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

