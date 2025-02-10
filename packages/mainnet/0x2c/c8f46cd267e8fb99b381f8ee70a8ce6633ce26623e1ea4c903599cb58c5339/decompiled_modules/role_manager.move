module 0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::role_manager {
    struct Role has store, key {
        id: 0x2::object::UID,
        bot_nft_id: 0x2::object::ID,
        health: u64,
        is_active: bool,
        is_locked: bool,
        last_epoch: u64,
        inactive_epochs: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        bot_address: address,
        skills: vector<0x2::object::ID>,
    }

    public entry fun activate_role(arg0: &mut Role, arg1: &0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT) {
        assert!(0x2::object::id<0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT>(arg1) == arg0.bot_nft_id, 103);
        assert!(!arg0.is_active, 101);
        assert!(arg0.health >= 1000000000, 102);
        arg0.is_active = true;
    }

    public entry fun add_skill(arg0: &mut Role, arg1: &0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT, arg2: &0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::skill_manager::Skill, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT>(arg1) == arg0.bot_nft_id, 103);
        assert!(0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::skill_manager::is_enabled(arg2), 107);
        let v0 = 0x2::object::id<0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::skill_manager::Skill>(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.skills)) {
            assert!(0x1::vector::borrow<0x2::object::ID>(&arg0.skills, v1) != &v0, 105);
            v1 = v1 + 1;
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.skills, v0);
    }

    public entry fun create_role(arg0: address, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT>, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= 100000000000 / 1000, 102);
        let v0 = 0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::mint_bot_nft(arg1, arg2, arg3, arg4, arg6);
        let v1 = Role{
            id              : 0x2::object::new(arg6),
            bot_nft_id      : 0x2::object::id<0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT>(&v0),
            health          : 100000000000,
            is_active       : true,
            is_locked       : false,
            last_epoch      : 0x2::tx_context::epoch(arg6),
            inactive_epochs : 0,
            balance         : 0x2::coin::into_balance<0x2::sui::SUI>(arg5),
            bot_address     : arg0,
            skills          : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Role>(v1);
        0x2::transfer::public_transfer<0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun deactivate_role(arg0: &mut Role, arg1: &0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT) {
        assert!(0x2::object::id<0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT>(arg1) == arg0.bot_nft_id, 103);
        arg0.is_active = false;
    }

    public entry fun deposit_sui(arg0: &mut Role, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 102);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.health = arg0.health + v0 * 1000;
        if (arg0.health > 100000000000) {
            arg0.health = 100000000000;
        };
        arg0.inactive_epochs = 0;
        arg0.last_epoch = 0x2::tx_context::epoch(arg2);
    }

    public entry fun remove_skill(arg0: &mut Role, arg1: &0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT, arg2: 0x2::object::ID) {
        assert!(0x2::object::id<0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT>(arg1) == arg0.bot_nft_id, 103);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.skills)) {
            if (0x1::vector::borrow<0x2::object::ID>(&arg0.skills, v0) == &arg2) {
                0x1::vector::remove<0x2::object::ID>(&mut arg0.skills, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 106);
    }

    public entry fun toggle_lock(arg0: &mut Role, arg1: &0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT) {
        assert!(0x2::object::id<0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT>(arg1) == arg0.bot_nft_id, 103);
        arg0.is_locked = !arg0.is_locked;
    }

    public entry fun update_role_health(arg0: &mut Role, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.bot_address, 104);
        let v0 = 0x2::tx_context::epoch(arg1);
        let v1 = v0 - arg0.last_epoch;
        if (v1 > 0) {
            let v2 = v1 * 1000000000;
            if (arg0.health > v2) {
                arg0.health = arg0.health - v2;
            } else {
                arg0.health = 0;
            };
            if (arg0.health == 0) {
                arg0.inactive_epochs = arg0.inactive_epochs + v1;
            } else {
                arg0.inactive_epochs = 0;
            };
            if (arg0.inactive_epochs >= 100) {
                arg0.is_active = false;
            };
            arg0.last_epoch = v0;
        };
    }

    public entry fun withdraw_sui_as_bot(arg0: &mut Role, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.bot_address, 104);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 108);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_sui_with_nft(arg0: &mut Role, arg1: &0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::bot_nft::BotNFT>(arg1) == arg0.bot_nft_id, 103);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 108);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

