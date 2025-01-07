module 0x9c83bf7e29c32e9f1ab9605e14576a853d369fa7f28a83ed45c668a9bcc2ec89::S7iterFaucet {
    struct S7ITERFAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<S7ITERFAUCET>, arg1: 0x2::coin::Coin<S7ITERFAUCET>) {
        0x2::coin::burn<S7ITERFAUCET>(arg0, arg1);
    }

    fun init(arg0: S7ITERFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S7ITERFAUCET>(arg0, 18, b"S7iterFaucet", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S7ITERFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<S7ITERFAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<S7ITERFAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<S7ITERFAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

