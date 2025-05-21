module 0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet {
    struct OIIA_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIIA_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIIA_FAUCET>(arg0, 8, b"OIIA_FAUCET", b"OIIA_FAUCET", b"Hello,Mr.Coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/SherVite/picture/refs/heads/main/oiia.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OIIA_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<OIIA_FAUCET>>(v0);
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<OIIA_FAUCET>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OIIA_FAUCET>>(0x2::coin::mint<OIIA_FAUCET>(arg0, arg2, arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

