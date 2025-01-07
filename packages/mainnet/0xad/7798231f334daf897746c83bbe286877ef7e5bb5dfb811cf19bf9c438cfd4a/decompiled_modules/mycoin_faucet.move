module 0xad7798231f334daf897746c83bbe286877ef7e5bb5dfb811cf19bf9c438cfd4a::mycoin_faucet {
    struct MyCoinFaucet has key {
        id: 0x2::object::UID,
        mycoinbalance: 0x2::balance::Balance<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_mycoin(arg0: &AdminCap, arg1: &mut MyCoinFaucet, arg2: 0x2::coin::Coin<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(&mut arg1.mycoinbalance, 0x2::coin::into_balance<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyCoinFaucet{
            id            : 0x2::object::new(arg0),
            mycoinbalance : 0x2::balance::zero<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(),
        };
        0x2::transfer::share_object<MyCoinFaucet>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun mycoinfaucet(arg0: &mut MyCoinFaucet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(&arg0.mycoinbalance) <= 10000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>>(0x2::coin::from_balance<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(0x2::balance::split<0x3a360817c4c45c70d77bb633c8f80244d8a1542b69befdd05b842acfcf845c0c::mycoin::MYCOIN>(&mut arg0.mycoinbalance, 10000000), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

