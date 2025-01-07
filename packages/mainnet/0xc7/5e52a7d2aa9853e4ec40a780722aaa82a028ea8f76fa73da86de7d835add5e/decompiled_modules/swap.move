module 0xc75e52a7d2aa9853e4ec40a780722aaa82a028ea8f76fa73da86de7d835add5e::swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        balanceA: 0x2::balance::Balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>,
        balanceB: 0x2::balance::Balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>,
    }

    public entry fun deposit_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>(&mut arg0.balanceA, 0x2::coin::into_balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>(arg1));
    }

    public entry fun deposit_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(&mut arg0.balanceB, 0x2::coin::into_balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id       : 0x2::object::new(arg0),
            balanceA : 0x2::balance::zero<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>(),
            balanceB : 0x2::balance::zero<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(),
        };
        0x2::transfer::share_object<Pool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_a_2_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>(&mut arg0.balanceA, 0x2::coin::into_balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>>(0x2::coin::from_balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(0x2::balance::split<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(&mut arg0.balanceB, 0x2::coin::value<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>(&arg1) * 20000 / 10000), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_b_2_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(&mut arg0.balanceB, 0x2::coin::into_balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>>(0x2::coin::from_balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>(0x2::balance::split<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>(&mut arg0.balanceA, 0x2::coin::value<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(&arg1) * 10000 / 20000), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_a(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>>(0x2::coin::from_balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>(0x2::balance::split<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge::CHENERGE>(&mut arg1.balanceA, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_b(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>>(0x2::coin::from_balance<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(0x2::balance::split<0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet::CHENERGE_FAUCET>(&mut arg1.balanceB, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

