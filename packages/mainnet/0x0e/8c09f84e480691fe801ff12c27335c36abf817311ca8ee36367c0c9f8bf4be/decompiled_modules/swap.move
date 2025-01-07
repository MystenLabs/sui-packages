module 0xe8c09f84e480691fe801ff12c27335c36abf817311ca8ee36367c0c9f8bf4be::swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        dcm: 0x2::balance::Balance<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>,
        dcm_faucet: 0x2::balance::Balance<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>,
    }

    public entry fun deposit_dcm(arg0: &AdminCap, arg1: &mut Bank, arg2: 0x2::coin::Coin<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>(&mut arg1.dcm, 0x2::coin::into_balance<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>(arg2));
    }

    public entry fun deposit_dcm_faucet(arg0: &AdminCap, arg1: &mut Bank, arg2: 0x2::coin::Coin<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(&mut arg1.dcm_faucet, 0x2::coin::into_balance<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id         : 0x2::object::new(arg0),
            dcm        : 0x2::balance::zero<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>(),
            dcm_faucet : 0x2::balance::zero<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_dcm_to_faucet(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>(&mut arg0.dcm, 0x2::coin::into_balance<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>>(0x2::coin::from_balance<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(0x2::balance::split<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(&mut arg0.dcm_faucet, 0x2::coin::value<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_faucet_to_dcm(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(&mut arg0.dcm_faucet, 0x2::coin::into_balance<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>>(0x2::coin::from_balance<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>(0x2::balance::split<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>(&mut arg0.dcm, 0x2::coin::value<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_dcm(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>>(0x2::coin::from_balance<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>(0x2::balance::split<0x72a68fa0606318516b8f5963e428c4e30840dd0116c7a84580809c287241c03a::dcm_coin::DCM_COIN>(&mut arg1.dcm, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_dcm_faucet(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>>(0x2::coin::from_balance<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(0x2::balance::split<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(&mut arg1.dcm_faucet, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

