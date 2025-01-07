module 0x8fce92f5a9044de1b3b19a622c2f2beb74c080321612ca546a8ddfbae089c264::brainsk {
    struct BrainskSwapBank has key {
        id: 0x2::object::UID,
        faucetcoin: 0x2::balance::Balance<0xf55b7f267fbf88f6e195bdb979316293ec492882273e7deffc078a6615ec2bfd::faucetcoin::FAUCETCOIN>,
        mycoin: 0x2::balance::Balance<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>,
        mc_prop: u64,
        fc_prop: u64,
    }

    struct AdaminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_faucetcoin(arg0: &mut BrainskSwapBank, arg1: 0x2::coin::Coin<0xf55b7f267fbf88f6e195bdb979316293ec492882273e7deffc078a6615ec2bfd::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf55b7f267fbf88f6e195bdb979316293ec492882273e7deffc078a6615ec2bfd::faucetcoin::FAUCETCOIN>(&mut arg0.faucetcoin, 0x2::coin::into_balance<0xf55b7f267fbf88f6e195bdb979316293ec492882273e7deffc078a6615ec2bfd::faucetcoin::FAUCETCOIN>(arg1));
    }

    public entry fun deposit_mycoin(arg0: &mut BrainskSwapBank, arg1: 0x2::coin::Coin<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>(&mut arg0.mycoin, 0x2::coin::into_balance<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>(arg1));
    }

    public entry fun faucte_swap_my(arg0: &mut BrainskSwapBank, arg1: 0x2::coin::Coin<0xf55b7f267fbf88f6e195bdb979316293ec492882273e7deffc078a6615ec2bfd::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xf55b7f267fbf88f6e195bdb979316293ec492882273e7deffc078a6615ec2bfd::faucetcoin::FAUCETCOIN>(arg1);
        0x2::balance::join<0xf55b7f267fbf88f6e195bdb979316293ec492882273e7deffc078a6615ec2bfd::faucetcoin::FAUCETCOIN>(&mut arg0.faucetcoin, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>>(0x2::coin::from_balance<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>(0x2::balance::split<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>(&mut arg0.mycoin, 0x2::balance::value<0xf55b7f267fbf88f6e195bdb979316293ec492882273e7deffc078a6615ec2bfd::faucetcoin::FAUCETCOIN>(&v0) * arg0.mc_prop / arg0.fc_prop), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BrainskSwapBank{
            id         : 0x2::object::new(arg0),
            faucetcoin : 0x2::balance::zero<0xf55b7f267fbf88f6e195bdb979316293ec492882273e7deffc078a6615ec2bfd::faucetcoin::FAUCETCOIN>(),
            mycoin     : 0x2::balance::zero<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>(),
            mc_prop    : 1000,
            fc_prop    : 7300,
        };
        0x2::transfer::share_object<BrainskSwapBank>(v0);
        let v1 = AdaminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdaminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun my_swap_faucet(arg0: &mut BrainskSwapBank, arg1: 0x2::coin::Coin<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>(arg1);
        0x2::balance::join<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>(&mut arg0.mycoin, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf55b7f267fbf88f6e195bdb979316293ec492882273e7deffc078a6615ec2bfd::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xf55b7f267fbf88f6e195bdb979316293ec492882273e7deffc078a6615ec2bfd::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xf55b7f267fbf88f6e195bdb979316293ec492882273e7deffc078a6615ec2bfd::faucetcoin::FAUCETCOIN>(&mut arg0.faucetcoin, 0x2::balance::value<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>(&v0) * arg0.fc_prop / arg0.mc_prop), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_faucetcoin(arg0: &AdaminCap, arg1: &mut BrainskSwapBank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>>(0x2::coin::from_balance<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>(0x2::balance::split<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>(&mut arg1.mycoin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_mycoin(arg0: &AdaminCap, arg1: &mut BrainskSwapBank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>>(0x2::coin::from_balance<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>(0x2::balance::split<0x6873544ffc55c257a31c4fac905c730ed5f69c6340528314580b0c499a23c6fb::mycoin::MYCOIN>(&mut arg1.mycoin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

