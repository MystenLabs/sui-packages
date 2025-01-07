module 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry {
    struct ReferralRewardAdded has copy, drop {
        referrer: address,
        amount: u64,
        timestamp: u64,
    }

    struct AdminFeesWithdrawn has copy, drop {
        admin: address,
        amount: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        next_player_id: u64,
        players: 0x2::table::Table<address, PlayerInfo>,
        id_to_address: 0x2::table::Table<u64, address>,
        address_to_id: 0x2::table::Table<address, u64>,
    }

    struct PlayerInfo has store {
        id: u64,
        address: address,
        referrer_id: u64,
        registration_time: u64,
        referral_count: u64,
        total_deposit: u64,
        referral_rewards: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminInfo has key {
        id: 0x2::object::UID,
        admin: address,
        admin_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun add_admin_balance(arg0: &mut AdminInfo, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.admin_balance, arg1);
    }

    public fun add_referral_reward(arg0: &mut Registry, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<address, PlayerInfo>(&arg0.players, arg1), 0);
        0x2::balance::join<0x2::sui::SUI>(&mut 0x2::table::borrow_mut<address, PlayerInfo>(&mut arg0.players, arg1).referral_rewards, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = ReferralRewardAdded{
            referrer  : arg1,
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ReferralRewardAdded>(v0);
    }

    public fun claim_referral_rewards(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::table::contains<address, PlayerInfo>(&arg0.players, arg1), 0);
        let v0 = 0x2::table::borrow_mut<address, PlayerInfo>(&mut arg0.players, arg1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0.referral_rewards);
        assert!(v1 > 0, 1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.referral_rewards, v1), arg2)
    }

    public fun get_admin(arg0: &AdminInfo) : address {
        arg0.admin
    }

    public fun get_admin_balance(arg0: &AdminInfo) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.admin_balance
    }

    public fun get_player_address(arg0: &Registry, arg1: u64) : address {
        *0x2::table::borrow<u64, address>(&arg0.id_to_address, arg1)
    }

    public fun get_player_id(arg0: &Registry, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.address_to_id, arg1)
    }

    public fun get_referral_balance(arg0: &Registry, arg1: address) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&0x2::table::borrow<address, PlayerInfo>(&arg0.players, arg1).referral_rewards)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = AdminInfo{
            id            : 0x2::object::new(arg0),
            admin         : v0,
            admin_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<AdminInfo>(v2);
        let v3 = Registry{
            id             : 0x2::object::new(arg0),
            next_player_id : 2,
            players        : 0x2::table::new<address, PlayerInfo>(arg0),
            id_to_address  : 0x2::table::new<u64, address>(arg0),
            address_to_id  : 0x2::table::new<address, u64>(arg0),
        };
        let v4 = PlayerInfo{
            id                : 1,
            address           : v0,
            referrer_id       : 0,
            registration_time : 0,
            referral_count    : 0,
            total_deposit     : 0,
            referral_rewards  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::table::add<address, PlayerInfo>(&mut v3.players, v0, v4);
        0x2::table::add<u64, address>(&mut v3.id_to_address, 1, v0);
        0x2::table::add<address, u64>(&mut v3.address_to_id, v0, 1);
        0x2::transfer::share_object<Registry>(v3);
    }

    public fun is_registered(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, PlayerInfo>(&arg0.players, arg1)
    }

    public fun is_valid_referrer(arg0: &Registry, arg1: u64) : bool {
        0x2::table::contains<u64, address>(&arg0.id_to_address, arg1)
    }

    public fun register_player(arg0: &mut Registry, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, PlayerInfo>(&arg0.players, arg1)) {
            let v1 = arg0.next_player_id;
            arg0.next_player_id = arg0.next_player_id + 1;
            let v2 = PlayerInfo{
                id                : v1,
                address           : arg1,
                referrer_id       : arg2,
                registration_time : 0x2::clock::timestamp_ms(arg3),
                referral_count    : 0,
                total_deposit     : 0,
                referral_rewards  : 0x2::balance::zero<0x2::sui::SUI>(),
            };
            0x2::table::add<address, PlayerInfo>(&mut arg0.players, arg1, v2);
            0x2::table::add<u64, address>(&mut arg0.id_to_address, v1, arg1);
            0x2::table::add<address, u64>(&mut arg0.address_to_id, arg1, v1);
            if (arg2 != 0 && 0x2::table::contains<u64, address>(&arg0.id_to_address, arg2)) {
                let v3 = 0x2::table::borrow_mut<address, PlayerInfo>(&mut arg0.players, *0x2::table::borrow<u64, address>(&arg0.id_to_address, arg2));
                v3.referral_count = v3.referral_count + 1;
            };
            v1
        } else {
            *0x2::table::borrow<address, u64>(&arg0.address_to_id, arg1)
        }
    }

    public fun transfer_admin(arg0: &AdminCap, arg1: &mut AdminInfo, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg3), 3);
        assert!(arg2 != @0x0, 2);
        arg1.admin = arg2;
    }

    public fun update_deposit(arg0: &mut Registry, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, PlayerInfo>(&mut arg0.players, arg1);
        v0.total_deposit = v0.total_deposit + arg2;
    }

    public fun withdraw_admin_balance(arg0: &AdminCap, arg1: &mut AdminInfo, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.admin == 0x2::tx_context::sender(arg3), 3);
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            *0x1::option::borrow<u64>(&arg2)
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg1.admin_balance)
        };
        assert!(v0 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.admin_balance), 4);
        let v1 = AdminFeesWithdrawn{
            admin  : 0x2::tx_context::sender(arg3),
            amount : v0,
        };
        0x2::event::emit<AdminFeesWithdrawn>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.admin_balance, v0), arg3)
    }

    // decompiled from Move bytecode v6
}

