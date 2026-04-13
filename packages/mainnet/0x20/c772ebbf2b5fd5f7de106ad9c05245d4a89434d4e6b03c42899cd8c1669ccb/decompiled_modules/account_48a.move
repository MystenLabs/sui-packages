module 0x20c772ebbf2b5fd5f7de106ad9c05245d4a89434d4e6b03c42899cd8c1669ccb::account_48a {
    struct ACCOUNT_48A has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_48A>, arg1: 0x2::coin::Coin<ACCOUNT_48A>) {
        0x2::coin::burn<ACCOUNT_48A>(arg0, arg1);
    }

    fun init(arg0: ACCOUNT_48A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACCOUNT_48A>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ACCOUNT_48A>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACCOUNT_48A>>(v1);
    }

    public fun supply(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_48A>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ACCOUNT_48A> {
        0x2::coin::mint<ACCOUNT_48A>(arg0, arg1, arg2)
    }

    public entry fun supply_to(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_48A>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ACCOUNT_48A>>(0x2::coin::mint<ACCOUNT_48A>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

