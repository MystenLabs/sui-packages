module 0x2b9f4bbd2fea95f9ae4a344dbb1ee6e74c6ad254d3b515a29119af1829fd318b::tomocoin {
    struct TOMOCOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOMOCOIN>, arg1: 0x2::coin::Coin<TOMOCOIN>) {
        0x2::coin::burn<TOMOCOIN>(arg0, arg1);
    }

    fun init(arg0: TOMOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMOCOIN>(arg0, 2, b"IQ300", b"IQ300", b"This is meme coin for TOMO", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMOCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMOCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOMOCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOMOCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

