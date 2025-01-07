module 0x7275a10b794b518a9140d76034e4baab08e018e75d7bf1f73bbd373cf96e100e::SUIBUG {
    struct SUIBUG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIBUG>, arg1: 0x2::coin::Coin<SUIBUG>) {
        0x2::coin::burn<SUIBUG>(arg0, arg1);
    }

    fun init(arg0: SUIBUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBUG>(arg0, 1, b"SUIBUG", b"SUIBUG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBUG>>(v1);
        0x2::coin::mint_and_transfer<SUIBUG>(&mut v2, 4200000000000000, @0x968fa1041658d0ab16a38bb00cf3a24284d94c679cd42c171ac4f6da1ac2a363, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBUG>>(v2, @0x968fa1041658d0ab16a38bb00cf3a24284d94c679cd42c171ac4f6da1ac2a363);
    }

    // decompiled from Move bytecode v6
}

