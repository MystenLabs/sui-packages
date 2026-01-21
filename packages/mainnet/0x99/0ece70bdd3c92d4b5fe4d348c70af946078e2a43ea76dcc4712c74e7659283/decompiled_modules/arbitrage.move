module 0x990ece70bdd3c92d4b5fe4d348c70af946078e2a43ea76dcc4712c74e7659283::arbitrage {
    struct BaseAsset has drop {
        dummy_field: bool,
    }

    struct QuoteAsset has drop {
        dummy_field: bool,
    }

    entry fun execute(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<BaseAsset>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BaseAsset>>(0x2::coin::split<BaseAsset>(&mut v0, arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<BaseAsset>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

