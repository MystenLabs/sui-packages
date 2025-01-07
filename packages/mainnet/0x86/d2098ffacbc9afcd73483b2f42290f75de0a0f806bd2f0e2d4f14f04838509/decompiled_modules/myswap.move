module 0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::myswap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        coin1: 0x2::balance::Balance<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>,
        coin2: 0x2::balance::Balance<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>,
    }

    public entry fun deposit_coin1(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>(&mut arg0.coin1, 0x2::coin::into_balance<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>(arg1));
    }

    public entry fun deposit_coin2(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>(&mut arg0.coin2, 0x2::coin::into_balance<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id    : 0x2::object::new(arg0),
            coin1 : 0x2::balance::zero<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>(),
            coin2 : 0x2::balance::zero<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_coin1_coin2(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>(&mut arg0.coin1, 0x2::coin::into_balance<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>(0x2::balance::split<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>(&mut arg0.coin2, 0x2::coin::value<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>(&arg1) * 1 / 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_coin2_coin1(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>(&mut arg0.coin2, 0x2::coin::into_balance<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>>(0x2::coin::from_balance<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>(0x2::balance::split<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>(&mut arg0.coin1, 0x2::coin::value<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>(&arg1) * 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_coin1(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>>(0x2::coin::from_balance<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>(0x2::balance::split<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::mycoin::MYCOIN>(&mut arg1.coin1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_coin2(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>(0x2::balance::split<0x86d2098ffacbc9afcd73483b2f42290f75de0a0f806bd2f0e2d4f14f04838509::faucetcoin::FAUCETCOIN>(&mut arg1.coin2, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

