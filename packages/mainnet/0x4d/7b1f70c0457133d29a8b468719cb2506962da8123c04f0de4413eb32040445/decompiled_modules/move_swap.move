module 0x4d7b1f70c0457133d29a8b468719cb2506962da8123c04f0de4413eb32040445::move_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        mycoin: 0x2::balance::Balance<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>,
        faucet_coin: 0x2::balance::Balance<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>,
    }

    public entry fun deposit_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(arg1));
    }

    public entry fun deposit_mycoin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>(&mut arg0.mycoin, 0x2::coin::into_balance<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>(arg1));
    }

    public entry fun faucet_coin_to_mycoin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>>(0x2::coin::from_balance<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>(0x2::balance::split<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>(&mut arg0.mycoin, 0x2::coin::value<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(&arg1) * 10000 / 20000), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id          : 0x2::object::new(arg0),
            mycoin      : 0x2::balance::zero<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>(),
            faucet_coin : 0x2::balance::zero<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun mycoin_to_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>(&mut arg0.mycoin, 0x2::coin::into_balance<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::value<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>(&arg1) * 20000 / 10000), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_faucet_coin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x3bd35a5bf5f3649d37a9eff58403950b99b135667be45fd776515b2d2316e63a::faucet_coin::FAUCET_COIN>(&mut arg1.faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_mycoin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>>(0x2::coin::from_balance<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>(0x2::balance::split<0xc303dc81a35841a80e40462b6f96d9b1a9e519e1b01ddfc94be00061127fa0c::mycoin::MYCOIN>(&mut arg1.mycoin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

