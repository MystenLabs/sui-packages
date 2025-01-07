module 0x76cbd2a52b6c87eb85b0da4bd627ae1423b0ba9ded773e6a27354281edd85516::entei {
    struct ENTEI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ENTEI>, arg1: 0x2::coin::Coin<ENTEI>) {
        0x2::coin::burn<ENTEI>(arg0, arg1);
    }

    fun init(arg0: ENTEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENTEI>(arg0, 9, b"ESUI", b"Entei", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENTEI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENTEI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ENTEI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ENTEI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

