module 0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin {
    struct KRYPTON_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRYPTON_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRYPTON_FAUCET_COIN>(arg0, 9, b"krypton faucet coin", b"KRYPTON_FAUCET_COIN", b"Krypton Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/154910746?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRYPTON_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<KRYPTON_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KRYPTON_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KRYPTON_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

