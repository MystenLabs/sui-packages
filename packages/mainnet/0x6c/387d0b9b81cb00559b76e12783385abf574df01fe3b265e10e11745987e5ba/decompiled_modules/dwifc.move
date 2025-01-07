module 0x6c387d0b9b81cb00559b76e12783385abf574df01fe3b265e10e11745987e5ba::dwifc {
    struct DWIFC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DWIFC>, arg1: 0x2::coin::Coin<DWIFC>) {
        0x2::coin::burn<DWIFC>(arg0, arg1);
    }

    fun init(arg0: DWIFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWIFC>(arg0, 4, b"DWIFC", b"DWIFC", b"DWIFC coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/9d7dPmPKXFgpzwo4ecoYPnG5NkopKsGiE2eGoTfmMoGG.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xaf5e0947b1d00c6f287becc210ab92f471c7cd8bba9f29f107179b535e6d4dd8, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DWIFC>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DWIFC>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<DWIFC>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DWIFC>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

