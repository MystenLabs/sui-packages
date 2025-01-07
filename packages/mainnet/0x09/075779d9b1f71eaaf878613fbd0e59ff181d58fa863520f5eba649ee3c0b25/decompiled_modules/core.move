module 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::core {
    struct MintEvent has copy, drop {
        nft: 0x2::object::ID,
    }

    struct UpgradeEvent has copy, drop {
        nft: 0x2::object::ID,
        level: u64,
        to_level: u64,
        to_nft: 0x2::object::ID,
    }

    public fun kiosk_upgrade(arg0: &0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::config::Config, arg1: &0x2::clock::Clock, arg2: &mut 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::gated_vault::GatedVaultRegistry, arg3: &mut 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::frac_vault::VaultWrapper, arg4: 0x2::object::ID, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::transfer_policy::TransferPolicy<0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0x2::coin::Coin<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>, arg11: &mut 0x2::tx_context::TxContext) : 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT {
        0x2::kiosk::list<0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT>(arg7, arg8, arg4, 0);
        let (v0, v1) = 0x2::kiosk::purchase<0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT>(arg7, arg4, 0x2::coin::zero<0x2::sui::SUI>(arg11));
        let v2 = v1;
        0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::royalty_rule::pay<0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT>(arg6, &mut v2, 0x2::coin::zero<0x2::sui::SUI>(arg11));
        let v3 = upgrade(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg9, arg10, arg11);
        0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::kiosk_lock_rule::prove<0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT>(&mut v2, arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT>(arg6, v2);
        v3
    }

    public fun mint(arg0: &0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::config::Config, arg1: &0x2::clock::Clock, arg2: &mut 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::gated_vault::GatedVaultRegistry, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>, arg5: &mut 0x2::tx_context::TxContext) : 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT {
        payment(arg0, arg1, arg2, 1, arg3, arg4, arg5);
        let v0 = 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::mint_(1, arg5);
        let v1 = MintEvent{nft: 0x2::object::id<0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT>(&v0)};
        0x2::event::emit<MintEvent>(v1);
        v0
    }

    fun payment(arg0: &0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::config::Config, arg1: &0x2::clock::Clock, arg2: &mut 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::gated_vault::GatedVaultRegistry, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::config::a_s(arg0) == 0x2::coin::value<0x2::sui::SUI>(&arg4), 1);
        assert!(0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::config::a_g(arg0) == 0x2::coin::value<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>(&arg5), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, 0x2::coin::value<0x2::sui::SUI>(&arg4) * 175 / 1000, arg6), @0xb9728a1e9bab5baaec570cac6400d9499cd02e3d6256382fa13d7fa178f0573b);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, 0x2::coin::value<0x2::sui::SUI>(&arg4) * 175 / 1000, arg6), @0x1e74b41d4fbd76a3fd623bf079715f74cbc8823d2420b8c94d90cd79513cdb7f);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, 0x2::coin::value<0x2::sui::SUI>(&arg4) * 175 / 1000, arg6), @0xd025596112c461476cdfad4ad39a4875fa21eefb76fe80b5c6ec136be3a81e38);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, 0x2::coin::value<0x2::sui::SUI>(&arg4) * 175 / 1000, arg6), @0x9c740b0f351d6c300d6b2de7c46b56916f870eb548e160fd7b6499ec32d7500e);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, 0x2::coin::value<0x2::sui::SUI>(&arg4) * 5 / 100, arg6), @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, 0x2::coin::value<0x2::sui::SUI>(&arg4) * 5 / 100, arg6), @0x9da2dd62e4be7aaa1d20413c7d242ee79f2f21186460709d30cf216731e6ad16);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, @0xc333120e29ae0b59f924836c2eff13a06b9009324dee51fe8aa880107c7b08be);
        0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::gated_vault::add_to_registry(arg2, arg1, arg3, arg5, arg6);
    }

    public fun upgrade(arg0: &0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::config::Config, arg1: &0x2::clock::Clock, arg2: &mut 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::gated_vault::GatedVaultRegistry, arg3: &mut 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::frac_vault::VaultWrapper, arg4: 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::transfer_policy::TransferPolicy<0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x2::coin::Coin<0x18d1215fb5a050ed22da5cdefb9601adead8a9c3576e30c9bc03cbdb2eb17b47::generis::GENERIS>, arg9: &mut 0x2::tx_context::TxContext) : 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT {
        assert!(0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::level(&arg4) <= 64, 3);
        payment(arg0, arg1, arg2, 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::level(&arg4) + 1, arg7, arg8, arg9);
        let v0 = 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::mint_(0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::level(&arg4) + 1, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::frac_coin::FRAC_COIN>>(0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::frac_vault::deposit_into_storage(arg3, arg4, arg5, arg6, arg9), @0x666);
        let v1 = UpgradeEvent{
            nft      : 0x2::object::id<0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT>(&arg4),
            level    : 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::level(&v0) - 1,
            to_level : 0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::level(&v0),
            to_nft   : 0x2::object::id<0x9075779d9b1f71eaaf878613fbd0e59ff181d58fa863520f5eba649ee3c0b25::collection::HouseCollectionNFT>(&v0),
        };
        0x2::event::emit<UpgradeEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

