module 0xf4842690b5e5d10bdbcc9c568cc809f9cedcb14654af9ff129e1248558d56cf3::yun {
    struct YUN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YUN>, arg1: 0x2::coin::Coin<YUN>) {
        0x2::coin::burn<YUN>(arg0, arg1);
    }

    fun init(arg0: YUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUN>(arg0, 2, b"Azhan", b"YUN", b"this is a test coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<YUN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YUN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

