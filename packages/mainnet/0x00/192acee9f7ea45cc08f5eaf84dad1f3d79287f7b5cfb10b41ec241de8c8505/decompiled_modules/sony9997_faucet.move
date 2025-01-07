module 0x192acee9f7ea45cc08f5eaf84dad1f3d79287f7b5cfb10b41ec241de8c8505::sony9997_faucet {
    struct SONY9997_FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun burn<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::burn<T0>(arg0, arg1);
    }

    public entry fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SONY9997_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONY9997_FAUCET>(arg0, 6, b"SONY9997_FAUCET", b"sony9997 Faucet", b"sony9997 Faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONY9997_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONY9997_FAUCET>>(v1);
    }

    // decompiled from Move bytecode v6
}

