module 0x93426cd4d5bf4f83d9819d6049f6436b9f56717c511b907e51b2470fae1b060f::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct Faucet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<FAUCET_COIN>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: 0x2::coin::Coin<FAUCET_COIN>) {
        0x2::coin::burn<FAUCET_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: u64, arg2: &mut Faucet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<FAUCET_COIN>(&mut arg2.coin, 0x2::coin::into_balance<FAUCET_COIN>(0x2::coin::mint<FAUCET_COIN>(arg0, arg1, arg3)));
    }

    public entry fun claim(arg0: &mut Faucet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_COIN>>(0x2::coin::take<FAUCET_COIN>(&mut arg0.coin, 1, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 2, b"FC", b"Faucet Coin", b"Faucet Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Faucet{
            id   : 0x2::object::new(arg1),
            coin : 0x2::balance::zero<FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Faucet>(v2);
    }

    // decompiled from Move bytecode v6
}

