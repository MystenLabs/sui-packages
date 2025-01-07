module 0x92e961b5059bdc3d361eebf167cec3c94d5bd5a5926b65c0e32ed25b38118573::foxyclan {
    struct FOXYCLAN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FOXYCLAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FOXYCLAN>>(0x2::coin::mint<FOXYCLAN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FOXYCLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXYCLAN>(arg0, 6, b"SUI FOXY CLAN", b"sFoxyClan", b"SUI FOXY CLAN MEME COIN", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOXYCLAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXYCLAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

