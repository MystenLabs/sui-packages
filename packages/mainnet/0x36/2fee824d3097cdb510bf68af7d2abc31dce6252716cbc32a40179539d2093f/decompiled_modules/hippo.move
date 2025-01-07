module 0x362fee824d3097cdb510bf68af7d2abc31dce6252716cbc32a40179539d2093f::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HIPPO>, arg1: 0x2::coin::Coin<HIPPO>) {
        0x2::coin::burn<HIPPO>(arg0, arg1);
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO>(arg0, 9, b"HIPPO on Sui", b"HIPPO", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HIPPO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HIPPO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

