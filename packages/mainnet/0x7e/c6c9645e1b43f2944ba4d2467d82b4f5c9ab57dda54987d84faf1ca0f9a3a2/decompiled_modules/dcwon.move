module 0x7ec6c9645e1b43f2944ba4d2467d82b4f5c9ab57dda54987d84faf1ca0f9a3a2::dcwon {
    struct Bank has key {
        id: 0x2::object::UID,
        mycoin: 0x2::balance::Balance<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>,
        faucetcoin: 0x2::balance::Balance<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>,
        mc_prop: u64,
        fc_prop: u64,
    }

    struct AdaminCap has key {
        id: 0x2::object::UID,
    }

    public fun deposit_faucetcoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(&mut arg0.faucetcoin, 0x2::coin::into_balance<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(arg1));
    }

    public fun deposit_mycoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>(&mut arg0.mycoin, 0x2::coin::into_balance<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id         : 0x2::object::new(arg0),
            mycoin     : 0x2::balance::zero<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>(),
            faucetcoin : 0x2::balance::zero<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(),
            mc_prop    : 1000,
            fc_prop    : 7300,
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdaminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdaminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun swap_faucetcoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>(arg1);
        0x2::balance::join<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>(&mut arg0.mycoin, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(&mut arg0.faucetcoin, 0x2::balance::value<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>(&v0) * arg0.fc_prop / arg0.mc_prop), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun swap_mycoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(arg1);
        0x2::balance::join<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(&mut arg0.faucetcoin, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>>(0x2::coin::from_balance<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>(0x2::balance::split<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>(&mut arg0.mycoin, 0x2::balance::value<0xe603bb721b3b1c12aeb5e7e0240c9ff5e2779092e0961455ee93669c78123d0::faucetcoin::FAUCETCOIN>(&v0) * arg0.mc_prop / arg0.fc_prop), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_faucetcoin(arg0: &AdaminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>>(0x2::coin::from_balance<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>(0x2::balance::split<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>(&mut arg1.mycoin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun withdraw_mycoin(arg0: &AdaminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>>(0x2::coin::from_balance<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>(0x2::balance::split<0x2d41c67a9fd9d5e4a3e5dd917545bf36770b858a763155cc6a0f94adbd2471a0::mycoin::MYCOIN>(&mut arg1.mycoin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

