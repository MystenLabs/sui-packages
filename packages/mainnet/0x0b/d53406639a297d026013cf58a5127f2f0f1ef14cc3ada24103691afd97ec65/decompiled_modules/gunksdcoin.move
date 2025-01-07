module 0xbd53406639a297d026013cf58a5127f2f0f1ef14cc3ada24103691afd97ec65::gunksdcoin {
    struct GUNKSDCOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GUNKSDCOIN>, arg1: 0x2::coin::Coin<GUNKSDCOIN>) {
        0x2::coin::burn<GUNKSDCOIN>(arg0, arg1);
    }

    fun init(arg0: GUNKSDCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUNKSDCOIN>(arg0, 3, b"GUNKSDCOIN", b"CA", b"learning for swap", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUNKSDCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUNKSDCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUNKSDCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GUNKSDCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

