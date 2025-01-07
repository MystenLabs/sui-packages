module 0x6d92af0dbd42847da17b6ee24f415c3b80bee61710eacc69858d56a417843009::vip {
    struct VIP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<VIP>, arg1: 0x2::coin::Coin<VIP>) {
        0x2::coin::burn<VIP>(arg0, arg1);
    }

    fun init(arg0: VIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIP>(arg0, 2, b"VIP", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<VIP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<VIP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

