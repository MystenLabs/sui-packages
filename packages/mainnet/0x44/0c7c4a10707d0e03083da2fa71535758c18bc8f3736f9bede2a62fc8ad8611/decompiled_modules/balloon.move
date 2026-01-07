module 0x57bbe3eb299c27fda15be7cf5c7129b498285e7951b92483914f05ee3a2374b8::balloon {
    struct BALLOON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BALLOON>, arg1: 0x2::coin::Coin<BALLOON>) {
        0x2::coin::burn<BALLOON>(arg0, arg1);
    }

    fun init(arg0: BALLOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLOON>(arg0, 9, b"BALLOON", b"BALLOON", b"Balloon Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALLOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BALLOON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BALLOON>(arg0, arg1, arg2, arg3);
    }

    public entry fun share_treasury(arg0: 0x2::coin::TreasuryCap<BALLOON>) {
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BALLOON>>(arg0);
    }

    // decompiled from Move bytecode v6
}

