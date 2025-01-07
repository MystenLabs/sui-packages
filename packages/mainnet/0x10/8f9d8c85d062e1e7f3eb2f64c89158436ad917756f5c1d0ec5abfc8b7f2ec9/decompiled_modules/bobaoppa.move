module 0x108f9d8c85d062e1e7f3eb2f64c89158436ad917756f5c1d0ec5abfc8b7f2ec9::bobaoppa {
    struct BOBAOPPA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOBAOPPA>, arg1: 0x2::coin::Coin<BOBAOPPA>) {
        0x2::coin::burn<BOBAOPPA>(arg0, arg1);
    }

    fun init(arg0: BOBAOPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBAOPPA>(arg0, 9, b"BOBAOPPA", b"BOBAOPPA", b"BOBAOPPA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/bobaM3u8QmqZhY1HwAtnvze9DLXvkgKYk3td3t8MLva.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 1000000000000000, @0x504a65cf35fe3edd7b0232341b84e0adbed6b8d7e9f251fd7cc5cf8924ea5600, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBAOPPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBAOPPA>>(v2, @0x504a65cf35fe3edd7b0232341b84e0adbed6b8d7e9f251fd7cc5cf8924ea5600);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOBAOPPA>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BOBAOPPA>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

