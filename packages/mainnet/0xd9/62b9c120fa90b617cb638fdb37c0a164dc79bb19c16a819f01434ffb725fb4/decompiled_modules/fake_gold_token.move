module 0xd962b9c120fa90b617cb638fdb37c0a164dc79bb19c16a819f01434ffb725fb4::fake_gold_token {
    struct FAKE_GOLD_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAKE_GOLD_TOKEN>, arg1: 0x2::coin::Coin<FAKE_GOLD_TOKEN>) {
        0x2::coin::burn<FAKE_GOLD_TOKEN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAKE_GOLD_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAKE_GOLD_TOKEN>(arg0, arg1, arg2, arg3);
    }

    public fun total_supply<T0>(arg0: &0x2::coin::TreasuryCap<T0>) : u64 {
        0x2::coin::total_supply<T0>(arg0)
    }

    fun init(arg0: FAKE_GOLD_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_GOLD_TOKEN>(arg0, 9, b"FGT", b"FakeGoldToken", b"A fake gold token for demonstration purposes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/fgt-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE_GOLD_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE_GOLD_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<FAKE_GOLD_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FAKE_GOLD_TOKEN> {
        0x2::coin::mint<FAKE_GOLD_TOKEN>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

