module 0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::marketplace {
    struct NFTListed has copy, drop {
        nft_id: 0x2::object::ID,
        price: u64,
        seller: address,
    }

    struct NFTSold has copy, drop {
        nft_id: 0x2::object::ID,
        price: u64,
        seller: address,
        buyer: address,
        admin_fee: u64,
    }

    struct NFTDelisted has copy, drop {
        nft_id: 0x2::object::ID,
        seller: address,
    }

    struct MARKETPLACE has drop {
        dummy_field: bool,
    }

    public fun buy_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::player_registry::AdminInfo, arg2: &mut 0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::player_registry::Registry, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::transfer_policy::TransferPolicy<0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft::MinerNFT>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        if (!0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::player_registry::is_registered(arg2, v0)) {
            0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::player_registry::register_player(arg2, v0, 1, arg6);
        };
        let v2 = v1 * (1000 as u64) / (10000 as u64);
        0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::player_registry::add_admin_balance(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v2, arg7)));
        let (v3, v4) = 0x2::kiosk::purchase<0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft::MinerNFT>(arg0, arg3, arg4);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft::MinerNFT>(arg5, v4);
        0x2::transfer::public_transfer<0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft::MinerNFT>(v3, v0);
        let v8 = NFTSold{
            nft_id    : arg3,
            price     : v1,
            seller    : 0x2::kiosk::owner(arg0),
            buyer     : v0,
            admin_fee : v2,
        };
        0x2::event::emit<NFTSold>(v8);
    }

    public fun delist_nft(arg0: &0x2::kiosk::KioskOwnerCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::delist<0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft::MinerNFT>(arg1, arg0, arg2);
        let v0 = NFTDelisted{
            nft_id : arg2,
            seller : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<NFTDelisted>(v0);
    }

    fun init(arg0: MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MARKETPLACE>(arg0, arg1);
        let (v1, v2) = 0x2::kiosk::new(arg1);
        let (v3, v4) = 0x2::transfer_policy::new<0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft::MinerNFT>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft::MinerNFT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft::MinerNFT>>(v3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun list_nft(arg0: &0x2::kiosk::KioskOwnerCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::list<0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft::MinerNFT>(arg1, arg0, arg2, arg3);
        let v0 = NFTListed{
            nft_id : arg2,
            price  : arg3,
            seller : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<NFTListed>(v0);
    }

    public fun place_nft(arg0: &0x2::kiosk::KioskOwnerCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft::MinerNFT) {
        0x2::kiosk::place<0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft::MinerNFT>(arg1, arg0, arg2);
    }

    public fun take_nft(arg0: &0x2::kiosk::KioskOwnerCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID) : 0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft::MinerNFT {
        0x2::kiosk::take<0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::nft::MinerNFT>(arg1, arg0, arg2)
    }

    public fun withdraw_admin_fees(arg0: &0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::player_registry::AdminCap, arg1: &mut 0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::player_registry::AdminInfo, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x22f16bb720d9dedea2fc7305b57a26c3a5c1716eb962ae4be2c3c06f364b3096::player_registry::withdraw_admin_balance(arg0, arg1, arg2, arg3)
    }

    public fun withdraw_profits(arg0: &0x2::kiosk::KioskOwnerCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::kiosk::withdraw(arg1, arg0, 0x1::option::none<u64>(), arg2)
    }

    // decompiled from Move bytecode v6
}

