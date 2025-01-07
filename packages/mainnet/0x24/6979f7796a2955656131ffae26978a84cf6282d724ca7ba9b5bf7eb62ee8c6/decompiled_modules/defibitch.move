module 0x246979f7796a2955656131ffae26978a84cf6282d724ca7ba9b5bf7eb62ee8c6::defibitch {
    struct DEFIBITCH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEFIBITCH>, arg1: 0x2::coin::Coin<DEFIBITCH>) {
        0x2::coin::burn<DEFIBITCH>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEFIBITCH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEFIBITCH>>(0x2::coin::mint<DEFIBITCH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DEFIBITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFIBITCH>(arg0, 9, b"Defibitch", b"DEFIBITCH", b"defibitch was here on cetus", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEFIBITCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFIBITCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

