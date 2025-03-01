module 0x3b6e6d813d9dd347394fcdf3bbb21161b481ee0267868b04d1752e747ccaecaf::firstnft {
    struct FIRSTNFT has drop {
        dummy_field: bool,
    }

    struct MyFirstNFT has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
    }

    struct AdminNFT has store, key {
        id: 0x2::object::UID,
    }

    struct HowManyNFTs has key {
        id: 0x2::object::UID,
        count: u64,
        addresses_minted: 0x2::table::Table<address, u64>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        exists: u64,
    }

    fun init(arg0: FIRSTNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FIRSTNFT>(arg0, arg1);
        let v1 = AdminNFT{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminNFT>(v1, 0x2::tx_context::sender(arg1));
        let v2 = HowManyNFTs{
            id               : 0x2::object::new(arg1),
            count            : 0,
            addresses_minted : 0x2::table::new<address, u64>(arg1),
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            exists           : 0,
        };
        let (v3, v4) = 0x2::transfer_policy::new<MyFirstNFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<MyFirstNFT>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<MyFirstNFT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<HowManyNFTs>(v2);
    }

    public entry fun mint(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::transfer_policy::TransferPolicy<MyFirstNFT>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut HowManyNFTs, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 1000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg4.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg5)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
        assert!(arg4.exists + 1 <= 444, 1);
        assert!(!0x2::table::contains<address, u64>(&arg4.addresses_minted, 0x2::tx_context::sender(arg5)), 2);
        let v1 = MyFirstNFT{
            id          : 0x2::object::new(arg5),
            description : 0x1::string::utf8(b"my first nft"),
        };
        arg4.exists = arg4.exists + 1;
        0x2::kiosk::lock<MyFirstNFT>(arg2, arg3, arg1, v1);
        0x2::table::add<address, u64>(&mut arg4.addresses_minted, 0x2::tx_context::sender(arg5), 1);
    }

    public entry fun withdraw(arg0: &AdminNFT, arg1: &mut HowManyNFTs, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

