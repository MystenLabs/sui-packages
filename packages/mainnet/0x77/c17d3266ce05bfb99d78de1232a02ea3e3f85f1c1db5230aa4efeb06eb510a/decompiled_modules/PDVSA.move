module 0x77c17d3266ce05bfb99d78de1232a02ea3e3f85f1c1db5230aa4efeb06eb510a::PDVSA {
    struct PDVSA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PDVSA>, arg1: 0x2::coin::Coin<PDVSA>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<PDVSA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PDVSA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PDVSA>>(0x2::coin::mint<PDVSA>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<PDVSA>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PDVSA>>(arg0);
    }

    fun init(arg0: PDVSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDVSA>(arg0, 9, b"PDVSA", b"Venezuelan Petroleo", b"The only memecoin representative of the Venezuelan people and their lifeblood, currently in the hands of the los yanquis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://x.com/pdvsavenezuelan/status/2010403633267941435?s=46")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDVSA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDVSA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

