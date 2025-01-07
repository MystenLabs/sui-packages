module 0x7cc672559f2cea80f9a865a2aa0c73feaf040ecdbf1ba211222b96bed392bf99::yaominglong001_coin {
    struct YAOMINGLONG001_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YAOMINGLONG001_COIN>, arg1: 0x2::coin::Coin<YAOMINGLONG001_COIN>) {
        0x2::coin::burn<YAOMINGLONG001_COIN>(arg0, arg1);
    }

    fun init(arg0: YAOMINGLONG001_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAOMINGLONG001_COIN>(arg0, 9, b"YAOMINGLONG001_COIN", b"yaominglong001", b"virtual coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167277561")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAOMINGLONG001_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAOMINGLONG001_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YAOMINGLONG001_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YAOMINGLONG001_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

