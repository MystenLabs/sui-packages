module 0xdeafc0d35d7f0569566081a59c8d430ea2280dec4aa7200abf913d2ec1cf96bb::drake {
    struct DRAKE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DRAKE>, arg1: 0x2::coin::Coin<DRAKE>) {
        0x2::coin::burn<DRAKE>(arg0, arg1);
    }

    fun init(arg0: DRAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAKE>(arg0, 9, b"DRAKE", b"DRAKE", b"Hi, it's Drake!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRAKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRAKE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DRAKE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

