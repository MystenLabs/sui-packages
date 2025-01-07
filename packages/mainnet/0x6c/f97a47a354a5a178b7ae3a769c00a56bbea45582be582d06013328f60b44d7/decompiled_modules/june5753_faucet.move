module 0x6cf97a47a354a5a178b7ae3a769c00a56bbea45582be582d06013328f60b44d7::june5753_faucet {
    struct JUNE5753_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JUNE5753_FAUCET>, arg1: 0x2::coin::Coin<JUNE5753_FAUCET>) {
        0x2::coin::burn<JUNE5753_FAUCET>(arg0, arg1);
    }

    fun init(arg0: JUNE5753_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNE5753_FAUCET>(arg0, 6, b"BRF", b"june5753Faucet", b"June5753 facet is so cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://krseoul.imgtbl.com/i/2024/08/07/66b2ffe52d644.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUNE5753_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JUNE5753_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JUNE5753_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JUNE5753_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

