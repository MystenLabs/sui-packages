module 0x4e7332f6d22070067a77d9399af5b683273939282cc115dbc9c24b2b8faf4ff5::winorloss {
    struct Vault has key {
        id: 0x2::object::UID,
        faucetbalance: 0x2::balance::Balance<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&mut arg1.faucetbalance, 0x2::coin::into_balance<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(arg2));
    }

    entry fun gameplay(arg0: &0x2::random::Random, arg1: &mut Vault, arg2: 0x2::coin::Coin<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&arg1.faucetbalance) >= 10000000, 2);
        let v0 = 0x2::coin::into_balance<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(arg2);
        assert!(0x2::balance::value<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&v0) == 10000000, 1);
        0x2::balance::join<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&mut arg1.faucetbalance, v0);
        let v1 = 0x2::random::new_generator(arg0, arg4);
        if (arg3 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>>(0x2::coin::from_balance<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(0x2::balance::split<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&mut arg1.faucetbalance, 20000000), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Vault{
            id            : 0x2::object::new(arg0),
            faucetbalance : 0x2::balance::zero<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(),
        };
        0x2::transfer::share_object<Vault>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdral(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&arg1.faucetbalance), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>>(0x2::coin::from_balance<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(0x2::balance::split<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&mut arg1.faucetbalance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

