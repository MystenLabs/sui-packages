module 0xbe6e0c5fe59db04f483ca669ead5021dc47beb56733f1337f5881755bcc4351f::fake_usd_coin {
    struct FAKE_USD_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAKE_USD_COIN>, arg1: 0x2::coin::Coin<FAKE_USD_COIN>) {
        0x2::coin::burn<FAKE_USD_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAKE_USD_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAKE_USD_COIN>(arg0, arg1, arg2, arg3);
    }

    public fun total_supply<T0>(arg0: &0x2::coin::TreasuryCap<T0>) : u64 {
        0x2::coin::total_supply<T0>(arg0)
    }

    fun init(arg0: FAKE_USD_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_USD_COIN>(arg0, 6, b"FUSD", b"FakeUSDCoin", b"A fake USD coin for demonstration purposes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/fusd-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE_USD_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE_USD_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<FAKE_USD_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FAKE_USD_COIN> {
        0x2::coin::mint<FAKE_USD_COIN>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

