module 0x414d296ebbac5265dfa009c6f8df8931d9fb10be4065acb929d114107cc3e03d::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<APE>, arg1: 0x2::coin::Coin<APE>) {
        0x2::coin::burn<APE>(arg0, arg1);
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 9, b"APE", b"APE", b"APE on SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<APE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<APE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

