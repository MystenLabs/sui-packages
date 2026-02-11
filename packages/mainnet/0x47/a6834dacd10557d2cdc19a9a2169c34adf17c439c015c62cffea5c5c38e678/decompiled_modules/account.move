module 0x47a6834dacd10557d2cdc19a9a2169c34adf17c439c015c62cffea5c5c38e678::account {
    struct ACCOUNT has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT>, arg1: 0x2::coin::Coin<ACCOUNT>) {
        0x2::coin::burn<ACCOUNT>(arg0, arg1);
    }

    fun init(arg0: ACCOUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACCOUNT>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-zg2aBoTbAY.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ACCOUNT>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACCOUNT>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    public fun supply(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ACCOUNT> {
        0x2::coin::mint<ACCOUNT>(arg0, arg1, arg2)
    }

    public entry fun supply_to(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ACCOUNT>>(0x2::coin::mint<ACCOUNT>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

