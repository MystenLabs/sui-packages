module 0x3b6e2a9f9a2e2acb4ecdea54609a4ae87cda0441d549a2efca8beb8dfd187341::AYOUNG_FAUCET_COIN {
    struct AYOUNG_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct Faucet has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<AYOUNG_FAUCET_COIN>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AYOUNG_FAUCET_COIN>, arg1: 0x2::coin::Coin<AYOUNG_FAUCET_COIN>) {
        0x2::coin::burn<AYOUNG_FAUCET_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AYOUNG_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AYOUNG_FAUCET_COIN>>(0x2::coin::mint<AYOUNG_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    public entry fun faucet(arg0: &mut Faucet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AYOUNG_FAUCET_COIN>>(0x2::coin::take<AYOUNG_FAUCET_COIN>(&mut arg0.balance, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: AYOUNG_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYOUNG_FAUCET_COIN>(arg0, 6, b"AYOUNG_FAUCET_COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AYOUNG_FAUCET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYOUNG_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

