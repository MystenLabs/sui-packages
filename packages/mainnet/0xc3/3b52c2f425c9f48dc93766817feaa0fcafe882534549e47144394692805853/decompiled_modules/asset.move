module 0xc33b52c2f425c9f48dc93766817feaa0fcafe882534549e47144394692805853::asset {
    struct ASSET has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ASSET>, arg1: 0x2::coin::Coin<ASSET>) {
        0x2::coin::burn<ASSET>(arg0, arg1);
    }

    fun init(arg0: ASSET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSET>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ASSET>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSET>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    public fun run(arg0: &mut 0x2::coin::TreasuryCap<ASSET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ASSET> {
        0x2::coin::mint<ASSET>(arg0, arg1, arg2)
    }

    public entry fun run_to(arg0: &mut 0x2::coin::TreasuryCap<ASSET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASSET>>(0x2::coin::mint<ASSET>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

