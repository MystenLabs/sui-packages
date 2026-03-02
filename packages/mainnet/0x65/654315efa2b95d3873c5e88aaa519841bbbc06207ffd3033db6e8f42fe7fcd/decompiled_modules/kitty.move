module 0x65654315efa2b95d3873c5e88aaa519841bbbc06207ffd3033db6e8f42fe7fcd::kitty {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct KittyEvent has key {
        id: 0x2::object::UID,
        organizer: address,
        title_encrypted: vector<u8>,
        encrypted_participants: vector<u8>,
        password_hash: vector<u8>,
        statuses: 0x2::vec_map::VecMap<0x1::string::String, u8>,
        pool_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_usdc: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        tip: 0x2::balance::Balance<0x2::sui::SUI>,
        goal_usd_cents: u64,
        deadline: u64,
        active: bool,
    }

    struct KittyEventCreated has copy, drop {
        event_id: 0x2::object::ID,
        organizer: address,
        goal_usd_cents: u64,
        deadline: u64,
    }

    public entry fun close_event(arg0: &mut KittyEvent, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.organizer == 0x2::tx_context::sender(arg1), 0);
        arg0.active = false;
    }

    public entry fun contribute_sui(arg0: &mut KittyEvent, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 1);
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg0.statuses, &arg1), 2);
        assert!(*0x2::vec_map::get<0x1::string::String, u8>(&arg0.statuses, &arg1) == 0, 3);
        *0x2::vec_map::get_mut<0x1::string::String, u8>(&mut arg0.statuses, &arg1) = 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public entry fun contribute_sui_with_tip(arg0: &mut KittyEvent, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 1);
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg0.statuses, &arg1), 2);
        assert!(*0x2::vec_map::get<0x1::string::String, u8>(&arg0.statuses, &arg1) == 0, 3);
        *0x2::vec_map::get_mut<0x1::string::String, u8>(&mut arg0.statuses, &arg1) = 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.tip, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
    }

    public entry fun contribute_usdc(arg0: &mut KittyEvent, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 1);
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg0.statuses, &arg1), 2);
        assert!(*0x2::vec_map::get<0x1::string::String, u8>(&arg0.statuses, &arg1) == 0, 3);
        *0x2::vec_map::get_mut<0x1::string::String, u8>(&mut arg0.statuses, &arg1) = 3;
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.pool_usdc, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
    }

    public entry fun create_event(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            0x2::vec_map::insert<0x1::string::String, u8>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg3, v1), 0);
            v1 = v1 + 1;
        };
        let v2 = KittyEvent{
            id                     : 0x2::object::new(arg6),
            organizer              : 0x2::tx_context::sender(arg6),
            title_encrypted        : arg0,
            encrypted_participants : arg1,
            password_hash          : arg2,
            statuses               : v0,
            pool_sui               : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_usdc              : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            tip                    : 0x2::balance::zero<0x2::sui::SUI>(),
            goal_usd_cents         : arg4,
            deadline               : arg5,
            active                 : true,
        };
        let v3 = KittyEventCreated{
            event_id       : 0x2::object::id<KittyEvent>(&v2),
            organizer      : 0x2::tx_context::sender(arg6),
            goal_usd_cents : arg4,
            deadline       : arg5,
        };
        0x2::event::emit<KittyEventCreated>(v3);
        0x2::transfer::share_object<KittyEvent>(v2);
    }

    public entry fun mark_paypal(arg0: &mut KittyEvent, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.organizer == 0x2::tx_context::sender(arg2), 0);
        assert!(arg0.active, 1);
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg0.statuses, &arg1), 2);
        assert!(*0x2::vec_map::get<0x1::string::String, u8>(&arg0.statuses, &arg1) == 0, 3);
        *0x2::vec_map::get_mut<0x1::string::String, u8>(&mut arg0.statuses, &arg1) = 2;
    }

    public entry fun mark_paypal_batch(arg0: &mut KittyEvent, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.organizer == 0x2::tx_context::sender(arg2), 0);
        assert!(arg0.active, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg1, v0);
            if (0x2::vec_map::contains<0x1::string::String, u8>(&arg0.statuses, &v1) && *0x2::vec_map::get<0x1::string::String, u8>(&arg0.statuses, &v1) == 0) {
                *0x2::vec_map::get_mut<0x1::string::String, u8>(&mut arg0.statuses, &v1) = 2;
            };
            v0 = v0 + 1;
        };
    }

    public entry fun organizer_withdraw(arg0: &mut KittyEvent, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.organizer == 0x2::tx_context::sender(arg1), 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pool_sui);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pool_sui, v0), arg1), 0x2::tx_context::sender(arg1));
        };
        let v1 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.pool_usdc);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.pool_usdc, v1), arg1), 0x2::tx_context::sender(arg1));
        };
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.tip);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.tip, v2), arg1), 0x2::tx_context::sender(arg1));
        };
        let v3 = true;
        let v4 = 0;
        while (v4 < 0x2::vec_map::size<0x1::string::String, u8>(&arg0.statuses)) {
            let (_, v6) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, u8>(&arg0.statuses, v4);
            if (*v6 == 0) {
                v3 = false;
                break
            };
            v4 = v4 + 1;
        };
        if (v3) {
            arg0.active = false;
        };
    }

    // decompiled from Move bytecode v6
}

