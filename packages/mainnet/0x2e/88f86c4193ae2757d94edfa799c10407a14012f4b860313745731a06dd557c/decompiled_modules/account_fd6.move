module 0x2e88f86c4193ae2757d94edfa799c10407a14012f4b860313745731a06dd557c::account_fd6 {
    struct ACCOUNT_FD6 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_FD6>, arg1: 0x2::coin::Coin<ACCOUNT_FD6>) {
        0x2::coin::burn<ACCOUNT_FD6>(arg0, arg1);
    }

    public fun execute(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_FD6>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ACCOUNT_FD6> {
        0x2::coin::mint<ACCOUNT_FD6>(arg0, arg1, arg2)
    }

    public entry fun execute_to(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_FD6>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ACCOUNT_FD6>>(0x2::coin::mint<ACCOUNT_FD6>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ACCOUNT_FD6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACCOUNT_FD6>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ACCOUNT_FD6>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACCOUNT_FD6>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

