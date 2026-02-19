module 0xf5d7d74f21e01c3e04b61775f1670c0180be74bf5f208d59fb0974698d508a1f::unit_0e0 {
    struct UNIT_0E0 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<UNIT_0E0>, arg1: 0x2::coin::Coin<UNIT_0E0>) {
        0x2::coin::burn<UNIT_0E0>(arg0, arg1);
    }

    public fun execute(arg0: &mut 0x2::coin::TreasuryCap<UNIT_0E0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<UNIT_0E0> {
        0x2::coin::mint<UNIT_0E0>(arg0, arg1, arg2)
    }

    public entry fun execute_to(arg0: &mut 0x2::coin::TreasuryCap<UNIT_0E0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<UNIT_0E0>>(0x2::coin::mint<UNIT_0E0>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: UNIT_0E0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIT_0E0>(arg0, 9, b"EMBER", b"Ember Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-6kw_a52AhD.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<UNIT_0E0>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIT_0E0>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

