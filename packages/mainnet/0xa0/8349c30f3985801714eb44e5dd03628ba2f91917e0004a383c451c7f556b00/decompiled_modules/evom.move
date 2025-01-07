module 0xa08349c30f3985801714eb44e5dd03628ba2f91917e0004a383c451c7f556b00::evom {
    struct EVOM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<EVOM>, arg1: 0x2::coin::Coin<EVOM>) {
        0x2::coin::burn<EVOM>(arg0, arg1);
    }

    fun init(arg0: EVOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVOM>(arg0, 2, b"EVOM", b"EVOM", b"https://pbs.twimg.com/profile_images/1607342060646051841/SkAgauhd_400x400.png", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EVOM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EVOM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

