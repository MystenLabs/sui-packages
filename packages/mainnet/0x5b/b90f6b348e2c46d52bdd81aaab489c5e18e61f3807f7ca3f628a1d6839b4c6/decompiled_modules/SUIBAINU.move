module 0x5bb90f6b348e2c46d52bdd81aaab489c5e18e61f3807f7ca3f628a1d6839b4c6::SUIBAINU {
    struct SUIBAINU has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUIBAINU>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIBAINU>>(arg0, arg1);
    }

    fun init(arg0: SUIBAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAINU>(arg0, 9, b"SUIBAINU", b"SUIBA", b"100% liquidity will be burn, web : https://suibainu.xyz , tg : @SuibaInu_Portal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmT5XnZsYf44mEhkNM1k6Vpg19DZb2hFeogVQYhymkKjgU?_gl=1*voxio2*rs_ga*NGMxYTE0YzUtNjg3OS00MTMxLThhM2EtMGZiMjljNzQ2OWYz*rs_ga_5RMPXG14TE*MTY4MzU1NDU5Ny4yLjEuMTY4MzU1NDYzMC4yNy4wLjA.")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUIBAINU>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAINU>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBAINU>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBAINU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIBAINU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

