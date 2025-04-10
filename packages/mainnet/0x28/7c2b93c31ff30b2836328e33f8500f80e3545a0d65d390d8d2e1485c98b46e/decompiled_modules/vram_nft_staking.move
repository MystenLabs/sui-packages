module 0x287c2b93c31ff30b2836328e33f8500f80e3545a0d65d390d8d2e1485c98b46e::vram_nft_staking {
    struct Treasury has key {
        id: 0x2::object::UID,
        whitelistOf: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        suiCoinsTreasury: 0x2::balance::Balance<0x2::sui::SUI>,
        nftIdAcountOf: 0x2::vec_map::VecMap<0x2::object::ID, address>,
        stakedTimeOf: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        rewardTimeOf: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        periodTimeOf: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        totalStaked: u64,
        totalSupply: u64,
        status: bool,
        fee: u64,
    }

    struct AdminUpdateFee has copy, drop {
        user: address,
        amount: u64,
    }

    struct PublicMint has copy, drop {
        user: address,
        price: u64,
    }

    struct WhitelistMint has copy, drop {
        user: address,
    }

    struct AdminSuiWithdrawn has copy, drop {
        user: address,
        amount: u64,
    }

    struct VRAMStaking has copy, drop {
        user: address,
        nft: 0x2::object::ID,
    }

    struct VRAMUnStaking has copy, drop {
        user: address,
        nft: 0x2::object::ID,
    }

    struct Listing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct ListingPersonal<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct VRAM_NFT_STAKING has drop {
        dummy_field: bool,
    }

    public entry fun add_whitelist(arg0: 0x2::object::ID, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg2), 0);
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(&arg1.whitelistOf, &arg0)) {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg1.whitelistOf, arg0, 1);
        };
    }

    public entry fun admin_withdraw(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.suiCoinsTreasury);
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.suiCoinsTreasury, v0, arg1), 0x2::tx_context::sender(arg1));
        let v1 = AdminSuiWithdrawn{
            user   : 0x2::tx_context::sender(arg1),
            amount : v0,
        };
        0x2::event::emit<AdminSuiWithdrawn>(v1);
    }

    fun init(arg0: VRAM_NFT_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id               : 0x2::object::new(arg1),
            whitelistOf      : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            suiCoinsTreasury : 0x2::balance::zero<0x2::sui::SUI>(),
            nftIdAcountOf    : 0x2::vec_map::empty<0x2::object::ID, address>(),
            stakedTimeOf     : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            rewardTimeOf     : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            periodTimeOf     : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            totalStaked      : 0,
            totalSupply      : 3333,
            status           : true,
            fee              : 1000000,
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public entry fun remove_whitelist(arg0: 0x2::object::ID, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg2), 0);
        if (0x2::vec_map::contains<0x2::object::ID, u64>(&arg1.whitelistOf, &arg0)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg1.whitelistOf, &arg0);
        };
    }

    public entry fun stake<T0: store + key>(arg0: &mut Treasury, arg1: 0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.whitelistOf, &arg2), 1);
        let v0 = Listing<T0>{
            id  : 0x2::object::new(arg5),
            cap : arg1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg2, v0);
        arg0.totalStaked = arg0.totalStaked + 1;
        if (!0x2::vec_map::contains<0x2::object::ID, address>(&arg0.nftIdAcountOf, &arg2)) {
            0x2::vec_map::insert<0x2::object::ID, address>(&mut arg0.nftIdAcountOf, arg2, 0x2::tx_context::sender(arg5));
        } else {
            *0x2::vec_map::get_mut<0x2::object::ID, address>(&mut arg0.nftIdAcountOf, &arg2) = 0x2::tx_context::sender(arg5);
        };
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.stakedTimeOf, &arg2)) {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.stakedTimeOf, arg2, 0x2::clock::timestamp_ms(arg4));
        } else {
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.stakedTimeOf, &arg2) = 0x2::clock::timestamp_ms(arg4);
        };
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.rewardTimeOf, &arg2)) {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.rewardTimeOf, arg2, 0x2::clock::timestamp_ms(arg4));
        } else {
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.rewardTimeOf, &arg2) = 0x2::clock::timestamp_ms(arg4);
        };
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.periodTimeOf, &arg2)) {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.periodTimeOf, arg2, 0x2::clock::timestamp_ms(arg4));
        } else {
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.periodTimeOf, &arg2) = arg3;
        };
        let v1 = VRAMStaking{
            user : 0x2::tx_context::sender(arg5),
            nft  : arg2,
        };
        0x2::event::emit<VRAMStaking>(v1);
    }

    public entry fun stake_personal<T0: store + key>(arg0: &mut Treasury, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1::type_name::get<T0>();
        let v0 = ListingPersonal<T0>{
            id  : 0x2::object::new(arg6),
            cap : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, arg4, arg6),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, ListingPersonal<T0>>(&mut arg0.id, arg3, v0);
        arg0.totalStaked = arg0.totalStaked + 1;
        if (!0x2::vec_map::contains<0x2::object::ID, address>(&arg0.nftIdAcountOf, &arg3)) {
            0x2::vec_map::insert<0x2::object::ID, address>(&mut arg0.nftIdAcountOf, arg3, 0x2::tx_context::sender(arg6));
        } else {
            *0x2::vec_map::get_mut<0x2::object::ID, address>(&mut arg0.nftIdAcountOf, &arg3) = 0x2::tx_context::sender(arg6);
        };
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.stakedTimeOf, &arg3)) {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.stakedTimeOf, arg3, 0x2::clock::timestamp_ms(arg5));
        } else {
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.stakedTimeOf, &arg3) = 0x2::clock::timestamp_ms(arg5);
        };
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.rewardTimeOf, &arg3)) {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.rewardTimeOf, arg3, 0x2::clock::timestamp_ms(arg5));
        } else {
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.rewardTimeOf, &arg3) = 0x2::clock::timestamp_ms(arg5);
        };
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.periodTimeOf, &arg3)) {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.periodTimeOf, arg3, 0x2::clock::timestamp_ms(arg5));
        } else {
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.periodTimeOf, &arg3) = arg4;
        };
        let v1 = VRAMStaking{
            user : 0x2::tx_context::sender(arg6),
            nft  : arg3,
        };
        0x2::event::emit<VRAMStaking>(v1);
    }

    public entry fun unstake<T0: store + key>(arg0: &mut Treasury, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x2::vec_map::contains<0x2::object::ID, address>(&arg0.nftIdAcountOf, &arg1)) {
            assert!(&v0 == 0x2::vec_map::get_mut<0x2::object::ID, address>(&mut arg0.nftIdAcountOf, &arg1), 5);
            let Listing {
                id  : v1,
                cap : v2,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg1);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, v0);
            0x2::object::delete(v1);
            arg0.totalStaked = arg0.totalStaked - 1;
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.stakedTimeOf, &arg1) = 0;
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.periodTimeOf, &arg1) = 0;
            let v3 = VRAMUnStaking{
                user : 0x2::tx_context::sender(arg4),
                nft  : arg1,
            };
            0x2::event::emit<VRAMUnStaking>(v3);
        };
    }

    public entry fun unstake_personal<T0: store + key>(arg0: &mut Treasury, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        if (0x2::vec_map::contains<0x2::object::ID, address>(&arg0.nftIdAcountOf, &arg2)) {
            assert!(&v0 == 0x2::vec_map::get_mut<0x2::object::ID, address>(&mut arg0.nftIdAcountOf, &arg2), 5);
            let ListingPersonal {
                id  : v1,
                cap : v2,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, ListingPersonal<T0>>(&mut arg0.id, arg2);
            0x2::kiosk::return_purchase_cap<T0>(arg1, v2);
            0x2::object::delete(v1);
            arg0.totalStaked = arg0.totalStaked - 1;
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.stakedTimeOf, &arg2) = 0;
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.periodTimeOf, &arg2) = 0;
            let v3 = VRAMUnStaking{
                user : 0x2::tx_context::sender(arg5),
                nft  : arg2,
            };
            0x2::event::emit<VRAMUnStaking>(v3);
        };
    }

    // decompiled from Move bytecode v6
}

