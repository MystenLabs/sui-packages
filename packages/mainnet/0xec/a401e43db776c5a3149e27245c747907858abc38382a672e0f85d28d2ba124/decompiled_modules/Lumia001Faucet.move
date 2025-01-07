module 0xeca401e43db776c5a3149e27245c747907858abc38382a672e0f85d28d2ba124::Lumia001Faucet {
    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<LUMIA001FAUCET>,
    }

    struct LUMIA001FAUCET has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut TreasuryCapHolder, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUMIA001FAUCET>>(0x2::coin::mint<LUMIA001FAUCET>(&mut arg0.treasury, 1000 * 1000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: LUMIA001FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMIA001FAUCET>(arg0, 6, b"LUMIA001FAUCET", b"LUMIA001FAUCET", b"LUMIA001FAUCET faucet description.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = TreasuryCapHolder{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUMIA001FAUCET>>(v1);
        0x2::transfer::share_object<TreasuryCapHolder>(v2);
    }

    // decompiled from Move bytecode v6
}

