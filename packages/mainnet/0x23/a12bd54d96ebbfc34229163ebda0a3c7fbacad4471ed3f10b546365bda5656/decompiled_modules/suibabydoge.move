module 0x23a12bd54d96ebbfc34229163ebda0a3c7fbacad4471ed3f10b546365bda5656::suibabydoge {
    struct SUIBABYDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIBABYDOGE>, arg1: 0x2::coin::Coin<SUIBABYDOGE>) {
        0x2::coin::burn<SUIBABYDOGE>(arg0, arg1);
    }

    fun init(arg0: SUIBABYDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBABYDOGE>(arg0, 2, b"SUIBABYDOGE", b"SUIBABYDOGE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.shopify.com/s/files/1/0388/4833/1916/files/new-home-logo.svg?v=1646329273")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBABYDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBABYDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBABYDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIBABYDOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

