module 0xc33bf65f7599cacd775ac183184d713db9042d6a23b26ab3023e3031dc877f2::swap0xhutou {
    struct SwapPool has key {
        id: 0x2::object::UID,
        faucetbalance: 0x2::balance::Balance<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>,
        mycoinbalance: 0x2::balance::Balance<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_faucet(arg0: &AdminCap, arg1: &mut SwapPool, arg2: 0x2::coin::Coin<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&mut arg1.faucetbalance, 0x2::coin::into_balance<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(arg2));
    }

    public entry fun deposit_mycoin(arg0: &AdminCap, arg1: &mut SwapPool, arg2: 0x2::coin::Coin<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(&mut arg1.mycoinbalance, 0x2::coin::into_balance<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = SwapPool{
            id            : 0x2::object::new(arg0),
            faucetbalance : 0x2::balance::zero<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(),
            mycoinbalance : 0x2::balance::zero<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(),
        };
        0x2::transfer::share_object<SwapPool>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_faucet_mycoin(arg0: &mut SwapPool, arg1: 0x2::coin::Coin<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(arg1);
        let v1 = 0x2::balance::value<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&v0);
        assert!(v1 <= 0x2::balance::value<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(&arg0.mycoinbalance), 0);
        0x2::balance::join<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&mut arg0.faucetbalance, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>>(0x2::coin::from_balance<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(0x2::balance::split<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(&mut arg0.mycoinbalance, v1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_mycoin_faucet(arg0: &mut SwapPool, arg1: 0x2::coin::Coin<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(arg1);
        let v1 = 0x2::balance::value<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(&v0);
        assert!(v1 <= 0x2::balance::value<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&arg0.faucetbalance), 0);
        0x2::balance::join<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(&mut arg0.mycoinbalance, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>>(0x2::coin::from_balance<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(0x2::balance::split<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&mut arg0.faucetbalance, v1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdral_faucet(arg0: &AdminCap, arg1: &mut SwapPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&arg1.faucetbalance), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>>(0x2::coin::from_balance<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(0x2::balance::split<0xf1785e2b449ca1be793d91777db04ad7cb6965b3bb029d6b2620203fbd324974::faucet::FAUCET>(&mut arg1.faucetbalance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdral_mycoin(arg0: &AdminCap, arg1: &mut SwapPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(&arg1.mycoinbalance), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>>(0x2::coin::from_balance<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(0x2::balance::split<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(&mut arg1.mycoinbalance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

