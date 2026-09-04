module 0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::mint {
    struct ResAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Mint has key {
        id: 0x2::object::UID,
        authority: address,
        scrap: 0x2::coin::TreasuryCap<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>,
        alloy: 0x2::coin::TreasuryCap<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>,
        dust: 0x2::coin::TreasuryCap<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::dust::DUST>,
        minted_scrap: u64,
        minted_alloy: u64,
        minted_dust: u64,
        burned_scrap: u64,
        burned_alloy: u64,
        burned_dust: u64,
    }

    struct ResourcesMinted has copy, drop {
        recipient: address,
        scrap: u64,
        alloy: u64,
        dust: u64,
        reason: 0x1::string::String,
    }

    struct ResourcesBurned has copy, drop {
        owner: address,
        scrap: u64,
        alloy: u64,
        dust: u64,
        purpose: 0x1::string::String,
    }

    public fun authority(arg0: &Mint) : address {
        arg0.authority
    }

    entry fun burn_all(arg0: &mut Mint, arg1: 0x2::coin::Coin<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>, arg2: 0x2::coin::Coin<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>, arg3: 0x2::coin::Coin<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::dust::DUST>, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        let v0 = burn_scrap(arg0, arg1);
        let v1 = burn_alloy(arg0, arg2);
        let v2 = ResourcesBurned{
            owner   : 0x2::tx_context::sender(arg5),
            scrap   : v0,
            alloy   : v1,
            dust    : burn_dust(arg0, arg3),
            purpose : arg4,
        };
        0x2::event::emit<ResourcesBurned>(v2);
    }

    public fun burn_alloy(arg0: &mut Mint, arg1: 0x2::coin::Coin<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>) : u64 {
        let v0 = 0x2::coin::value<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>(&arg1);
        0x2::coin::burn<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>(&mut arg0.alloy, arg1);
        arg0.burned_alloy = arg0.burned_alloy + v0;
        v0
    }

    public fun burn_dust(arg0: &mut Mint, arg1: 0x2::coin::Coin<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::dust::DUST>) : u64 {
        let v0 = 0x2::coin::value<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::dust::DUST>(&arg1);
        0x2::coin::burn<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::dust::DUST>(&mut arg0.dust, arg1);
        arg0.burned_dust = arg0.burned_dust + v0;
        v0
    }

    public fun burn_scrap(arg0: &mut Mint, arg1: 0x2::coin::Coin<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>) : u64 {
        let v0 = 0x2::coin::value<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>(&arg1);
        0x2::coin::burn<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>(&mut arg0.scrap, arg1);
        arg0.burned_scrap = arg0.burned_scrap + v0;
        v0
    }

    entry fun create(arg0: 0x2::coin::TreasuryCap<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>, arg1: 0x2::coin::TreasuryCap<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>, arg2: 0x2::coin::TreasuryCap<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::dust::DUST>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ResAdminCap{id: 0x2::object::new(arg4)};
        0x2::transfer::public_transfer<ResAdminCap>(v0, 0x2::tx_context::sender(arg4));
        let v1 = Mint{
            id           : 0x2::object::new(arg4),
            authority    : arg3,
            scrap        : arg0,
            alloy        : arg1,
            dust         : arg2,
            minted_scrap : 0,
            minted_alloy : 0,
            minted_dust  : 0,
            burned_scrap : 0,
            burned_alloy : 0,
            burned_dust  : 0,
        };
        0x2::transfer::share_object<Mint>(v1);
    }

    entry fun mint_batch(arg0: &mut Mint, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.authority, 1);
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>>(0x2::coin::mint<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>(&mut arg0.scrap, arg1, arg6), arg4);
            arg0.minted_scrap = arg0.minted_scrap + arg1;
        };
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>>(0x2::coin::mint<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>(&mut arg0.alloy, arg2, arg6), arg4);
            arg0.minted_alloy = arg0.minted_alloy + arg2;
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::dust::DUST>>(0x2::coin::mint<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::dust::DUST>(&mut arg0.dust, arg3, arg6), arg4);
            arg0.minted_dust = arg0.minted_dust + arg3;
        };
        let v0 = ResourcesMinted{
            recipient : arg4,
            scrap     : arg1,
            alloy     : arg2,
            dust      : arg3,
            reason    : arg5,
        };
        0x2::event::emit<ResourcesMinted>(v0);
    }

    public fun set_authority(arg0: &ResAdminCap, arg1: &mut Mint, arg2: address) {
        arg1.authority = arg2;
    }

    public fun supply(arg0: &Mint) : (u64, u64, u64) {
        (arg0.minted_scrap - arg0.burned_scrap, arg0.minted_alloy - arg0.burned_alloy, arg0.minted_dust - arg0.burned_dust)
    }

    // decompiled from Move bytecode v7
}

