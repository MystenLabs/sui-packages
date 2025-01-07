module 0x95f4cbef04e785a44488fb41a14a1b9a569414e1dd879cf0b034fcafe17bf51e::rbt {
    struct RBT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RBT>, arg1: 0x2::coin::Coin<RBT>) {
        0x2::coin::burn<RBT>(arg0, arg1);
    }

    fun init(arg0: RBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBT>(arg0, 9, b"RBT", b"RBT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RBT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RBT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

