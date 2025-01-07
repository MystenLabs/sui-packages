module 0x535b243ee0a7d8f104367c86b4fba3cb231356136516f812c787fe71a1cd706d::xjh1996_coin {
    struct XJH1996_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XJH1996_COIN>, arg1: 0x2::coin::Coin<XJH1996_COIN>) {
        0x2::coin::burn<XJH1996_COIN>(arg0, arg1);
    }

    fun init(arg0: XJH1996_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XJH1996_COIN>(arg0, 6, b"xjh1996 COIN", b"xjh1996 COIN", b"Amazing Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XJH1996_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XJH1996_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XJH1996_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XJH1996_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

