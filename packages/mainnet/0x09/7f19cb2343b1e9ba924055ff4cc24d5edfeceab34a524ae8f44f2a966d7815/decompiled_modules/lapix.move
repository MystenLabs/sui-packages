module 0x97f19cb2343b1e9ba924055ff4cc24d5edfeceab34a524ae8f44f2a966d7815::lapix {
    struct LAPIX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LAPIX>, arg1: 0x2::coin::Coin<LAPIX>) {
        0x2::coin::burn<LAPIX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAPIX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LAPIX>>(0x2::coin::mint<LAPIX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LAPIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAPIX>(arg0, 9, b"lapix", b"LAPIX", b"this is test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAPIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAPIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

