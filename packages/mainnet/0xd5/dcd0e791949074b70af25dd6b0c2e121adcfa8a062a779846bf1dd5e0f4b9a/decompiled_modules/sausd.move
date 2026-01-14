module 0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::sausd {
    struct SAUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAUSD>(arg0, 6, b"saUSD", b"saUSD", b"A synthetic aggregated aUSD stablecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/6319/standard/usdc.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_treasury(arg0: 0x2::coin::TreasuryCap<SAUSD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAUSD>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

