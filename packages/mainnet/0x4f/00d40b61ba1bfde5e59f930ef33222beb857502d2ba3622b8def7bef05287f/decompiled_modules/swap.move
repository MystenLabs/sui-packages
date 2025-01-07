module 0x4f00d40b61ba1bfde5e59f930ef33222beb857502d2ba3622b8def7bef05287f::swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        krypton: 0x2::balance::Balance<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>,
        krypton_faucet_coin: 0x2::balance::Balance<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>,
    }

    public entry fun deposit(arg0: &AdminCap, arg1: &mut Bank, arg2: 0x2::coin::Coin<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>(&mut arg1.krypton, 0x2::coin::into_balance<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>(arg2));
    }

    public entry fun deposit_faucet(arg0: &AdminCap, arg1: &mut Bank, arg2: 0x2::coin::Coin<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>(&mut arg1.krypton_faucet_coin, 0x2::coin::into_balance<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id                  : 0x2::object::new(arg0),
            krypton             : 0x2::balance::zero<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>(),
            krypton_faucet_coin : 0x2::balance::zero<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_a_to_b(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>(&mut arg0.krypton, 0x2::coin::into_balance<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>>(0x2::coin::from_balance<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>(0x2::balance::split<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>(&mut arg0.krypton_faucet_coin, 0x2::coin::value<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>(&arg1) * 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_b_to_a(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>(&mut arg0.krypton_faucet_coin, 0x2::coin::into_balance<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>>(0x2::coin::from_balance<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>(0x2::balance::split<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>(&mut arg0.krypton, 0x2::coin::value<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>(&arg1) / 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>>(0x2::coin::from_balance<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>(0x2::balance::split<0x90faf1f4b8745ca038e6380ec4516bcaf7daf2b6e7b3e8b89c2665ac88de203e::krypton_coin::KRYPTON_COIN>(&mut arg1.krypton, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_krypton_faucet(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>>(0x2::coin::from_balance<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>(0x2::balance::split<0x4ee0007853d35fcc8e2832e2000e5c08a1a81b117c2865672b6bc3c98baf328b::krypton_faucet_coin::KRYPTON_FAUCET_COIN>(&mut arg1.krypton_faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

