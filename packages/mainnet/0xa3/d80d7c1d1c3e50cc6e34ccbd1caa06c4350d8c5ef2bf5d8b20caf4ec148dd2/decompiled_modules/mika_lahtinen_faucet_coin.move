module 0xa3d80d7c1d1c3e50cc6e34ccbd1caa06c4350d8c5ef2bf5d8b20caf4ec148dd2::mika_lahtinen_faucet_coin {
    struct MIKA_LAHTINEN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct Wallet has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<MIKA_LAHTINEN_FAUCET_COIN>,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIKA_LAHTINEN_FAUCET_COIN>, arg1: u64, arg2: &mut Wallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<MIKA_LAHTINEN_FAUCET_COIN>(&mut arg2.balance, 0x2::coin::into_balance<MIKA_LAHTINEN_FAUCET_COIN>(0x2::coin::mint<MIKA_LAHTINEN_FAUCET_COIN>(arg0, arg1, arg3)));
    }

    public entry fun flow(arg0: &mut Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MIKA_LAHTINEN_FAUCET_COIN>>(0x2::coin::take<MIKA_LAHTINEN_FAUCET_COIN>(&mut arg0.balance, 500000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: MIKA_LAHTINEN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKA_LAHTINEN_FAUCET_COIN>(arg0, 6, b"MLF", b"MikaLahtinenFaucet", b"Faucet from Mika-Lahtinen", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKA_LAHTINEN_FAUCET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKA_LAHTINEN_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Wallet{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<MIKA_LAHTINEN_FAUCET_COIN>(),
        };
        0x2::transfer::public_share_object<Wallet>(v2);
    }

    // decompiled from Move bytecode v6
}

