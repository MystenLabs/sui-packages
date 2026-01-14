module 0xd5dcd0e791949074b70af25dd6b0c2e121adcfa8a062a779846bf1dd5e0f4b9a::ausd {
    struct AUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUSD>(arg0, 6, b"aUSD", b"aUSD", b"A decentralized stablecoin pegged to USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/6319/standard/usdc.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_treasury(arg0: 0x2::coin::TreasuryCap<AUSD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUSD>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

