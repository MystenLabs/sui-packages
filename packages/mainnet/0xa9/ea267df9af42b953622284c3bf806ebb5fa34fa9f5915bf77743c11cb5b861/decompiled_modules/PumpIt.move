module 0xa9ea267df9af42b953622284c3bf806ebb5fa34fa9f5915bf77743c11cb5b861::PumpIt {
    struct PUMPIT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PUMPIT>, arg1: &mut 0x2::coin::Coin<PUMPIT>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<PUMPIT>(arg0, 0x2::coin::split<PUMPIT>(arg1, arg2, arg3));
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<PUMPIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<PUMPIT>(arg0) + arg1 <= 1000000000000000, 1);
        0x2::coin::mint_and_transfer<PUMPIT>(arg0, arg1, arg2, arg3);
    }

    public entry fun airdrop_coins(arg0: &mut 0x2::coin::TreasuryCap<PUMPIT>, arg1: vector<address>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        let v1 = 0;
        assert!(0x2::coin::total_supply<PUMPIT>(arg0) + v0 * arg2 <= 1000000000000000, 1);
        while (v1 < v0) {
            let v2 = if (v1 + arg3 < v0) {
                v1 + arg3
            } else {
                v0
            };
            while (v1 < v2) {
                mint_and_transfer(arg0, arg2, *0x1::vector::borrow<address>(&arg1, v1), arg4);
                v1 = v1 + 1;
            };
        };
    }

    fun init(arg0: PUMPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPIT>(arg0, 6, b"PUMPIT", b"PumpIt", b"PumpIt - The first memecoin on Sui inspired by the legendary 'Pump It' meme! Born from the viral Bogdanoff twins and their mythical market-moving powers. Built on the lightning-fast Sui Network, PUMPIT brings the essence of crypto culture and degen energy to life. He bought? Pamp it! He sold? Pamp it even harder! Join the ultimate meme movement on Sui.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMPIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

