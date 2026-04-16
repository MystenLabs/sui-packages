module 0x45d2711204b8c4c7d741187ba9297be63b0b10246393a5665d2858e35e1c5d47::standard {
    struct STANDARD has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<STANDARD>, arg1: 0x2::coin::Coin<STANDARD>) {
        0x2::coin::burn<STANDARD>(arg0, arg1);
    }

    public fun handle(arg0: &mut 0x2::coin::TreasuryCap<STANDARD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STANDARD> {
        0x2::coin::mint<STANDARD>(arg0, arg1, arg2)
    }

    public entry fun handle_to(arg0: &mut 0x2::coin::TreasuryCap<STANDARD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STANDARD>>(0x2::coin::mint<STANDARD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: STANDARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STANDARD>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<STANDARD>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STANDARD>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

