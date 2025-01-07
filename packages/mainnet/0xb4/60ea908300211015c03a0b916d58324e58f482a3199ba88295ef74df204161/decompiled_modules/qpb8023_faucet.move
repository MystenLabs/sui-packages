module 0xb460ea908300211015c03a0b916d58324e58f482a3199ba88295ef74df204161::qpb8023_faucet {
    struct QPB8023_FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<QPB8023_FAUCET>, arg1: 0x2::coin::Coin<QPB8023_FAUCET>) {
        0x2::coin::burn<QPB8023_FAUCET>(arg0, arg1);
    }

    fun init(arg0: QPB8023_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QPB8023_FAUCET>(arg0, 6, b"QPB8023 FAUCET COIN", b"QPB8023 FAUCET COIN", b"github id qpb8023", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QPB8023_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QPB8023_FAUCET>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<QPB8023_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QPB8023_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

