module 0x51754ed81b0687d0532978fe0429954c05684f804936cf7c1a6216ec29d479fa::sicx {
    struct SICX has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SICX>, arg1: 0x2::coin::Coin<SICX>) {
        0x2::coin::burn<SICX>(arg0, arg1);
    }

    fun init(arg0: SICX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SICX>(arg0, 9, b"sICX", b"Staked ICX", b"Staked ICX tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/balancednetwork/icons/refs/heads/main/tokens/sicx.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SICX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SICX>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SICX>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SICX>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

