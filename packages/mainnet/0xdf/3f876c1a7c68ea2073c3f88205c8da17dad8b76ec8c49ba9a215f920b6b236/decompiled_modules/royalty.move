module 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::royalty {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    struct ProceedsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RoyaltyPaid has copy, drop {
        drop_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        sale_price: u64,
        royalty: u64,
    }

    struct RoyaltyWithdrawn has copy, drop {
        drop_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    public fun add(arg0: &mut 0x2::transfer_policy::TransferPolicy<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>, arg1: &0x2::transfer_policy::TransferPolicyCap<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{dummy_field: false};
        0x2::transfer_policy::add_rule<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun amount(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop, arg1: u64) : u64 {
        (((arg1 as u128) * (0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::royalty_bps(arg0) as u128) / 10000) as u64)
    }

    fun collect(arg0: &mut 0x2::transfer_policy::TransferRequest<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>, arg1: &mut 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::transfer_policy::paid<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>(arg0);
        let v1 = amount(arg1, v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v1, 2);
        let v2 = 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::uid_mut(arg1);
        let v3 = ProceedsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ProceedsKey>(v2, v3)) {
            let v4 = ProceedsKey{dummy_field: false};
            0x2::dynamic_field::add<ProceedsKey, 0x2::balance::Balance<0x2::sui::SUI>>(v2, v4, 0x2::balance::zero<0x2::sui::SUI>());
        };
        let v5 = ProceedsKey{dummy_field: false};
        0x2::balance::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<ProceedsKey, 0x2::balance::Balance<0x2::sui::SUI>>(v2, v5), 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v6 = RoyaltyPaid{
            drop_id    : 0x2::object::id<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop>(arg1),
            nft_id     : arg2,
            sale_price : v0,
            royalty    : v1,
        };
        0x2::event::emit<RoyaltyPaid>(v6);
        let v7 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT, Rule>(v7, arg0);
    }

    public fun pay(arg0: &mut 0x2::transfer_policy::TransferRequest<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>, arg1: &mut 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop, arg2: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::is_kiosk_only(arg1), 4);
        assert!(0x2::object::id<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>(arg2) == 0x2::transfer_policy::item<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>(arg0), 5);
        assert!(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::nft_drop_id(arg2) == 0x2::object::id<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop>(arg1), 1);
        collect(arg0, arg1, 0x2::object::id<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>(arg2), arg3);
    }

    public fun pay_and_lock(arg0: &mut 0x2::transfer_policy::TransferRequest<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>, arg1: &mut 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop, arg2: 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>) {
        let v0 = 0x2::object::id<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>(&arg2);
        assert!(v0 == 0x2::transfer_policy::item<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>(arg0), 5);
        assert!(0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::nft_drop_id(&arg2) == 0x2::object::id<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop>(arg1), 1);
        0x2::kiosk::lock<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::DropNFT>(arg4, arg5, arg6, arg2);
        collect(arg0, arg1, v0, arg3);
    }

    public fun proceeds(arg0: &0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop) : u64 {
        let v0 = 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::uid(arg0);
        let v1 = ProceedsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ProceedsKey>(v0, v1)) {
            let v3 = ProceedsKey{dummy_field: false};
            0x2::balance::value<0x2::sui::SUI>(0x2::dynamic_field::borrow<ProceedsKey, 0x2::balance::Balance<0x2::sui::SUI>>(v0, v3))
        } else {
            0
        }
    }

    public fun withdraw(arg0: &mut 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::creator(arg0);
        assert!(0x2::tx_context::sender(arg1) == v0, 3);
        let v1 = 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::uid_mut(arg0);
        let v2 = ProceedsKey{dummy_field: false};
        let v3 = if (0x2::dynamic_field::exists<ProceedsKey>(v1, v2)) {
            let v4 = ProceedsKey{dummy_field: false};
            0x2::balance::withdraw_all<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<ProceedsKey, 0x2::balance::Balance<0x2::sui::SUI>>(v1, v4))
        } else {
            0x2::balance::zero<0x2::sui::SUI>()
        };
        let v5 = v3;
        let v6 = RoyaltyWithdrawn{
            drop_id : 0x2::object::id<0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop>(arg0),
            creator : v0,
            amount  : 0x2::balance::value<0x2::sui::SUI>(&v5),
        };
        0x2::event::emit<RoyaltyWithdrawn>(v6);
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg1)
    }

    entry fun withdraw_to_creator(arg0: &mut 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::drop::Drop, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

