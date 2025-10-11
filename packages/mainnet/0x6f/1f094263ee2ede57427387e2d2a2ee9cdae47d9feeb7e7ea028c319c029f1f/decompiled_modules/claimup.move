module 0x6f1f094263ee2ede57427387e2d2a2ee9cdae47d9feeb7e7ea028c319c029f1f::claimup {
    struct EventPoolRegistry has key {
        id: 0x2::object::UID,
        pool_ids: vector<0x2::object::ID>,
    }

    struct EventPool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::option::Option<0x1::string::String>,
        image_url: 0x1::option::Option<0x2::url::Url>,
        admin: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        winners: 0x2::table::Table<address, WinnerInfo>,
        winner_addresses: vector<address>,
        total_distributed: u64,
        is_active: bool,
    }

    struct WinnerInfo has store {
        project_name: 0x1::string::String,
        project_description: 0x1::option::Option<0x1::string::String>,
        project_link: 0x1::option::Option<0x2::url::Url>,
        reward_amount: u64,
        claimed: bool,
    }

    struct RewardReceipt has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::option::Option<0x2::url::Url>,
        project_name: 0x1::string::String,
        project_link: 0x1::option::Option<0x2::url::Url>,
        amount: u64,
        claimed_at: u64,
    }

    struct CLAIMUP has drop {
        dummy_field: bool,
    }

    entry fun add_winner_to_event_pool(arg0: &mut EventPool, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: address, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 101);
        assert!(!0x2::table::contains<address, WinnerInfo>(&arg0.winners, arg4), 102);
        let v0 = if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(0x1::option::extract<0x1::string::String>(&mut arg3))))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v1 = WinnerInfo{
            project_name        : arg1,
            project_description : arg2,
            project_link        : v0,
            reward_amount       : arg5,
            claimed             : false,
        };
        0x2::table::add<address, WinnerInfo>(&mut arg0.winners, arg4, v1);
        0x1::vector::push_back<address>(&mut arg0.winner_addresses, arg4);
    }

    entry fun batch_add_winners_to_event_pool(arg0: &mut EventPool, arg1: vector<address>, arg2: vector<u64>, arg3: vector<0x1::string::String>, arg4: vector<0x1::option::Option<0x1::string::String>>, arg5: vector<0x1::option::Option<0x1::string::String>>, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 101);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = if (0x1::option::is_some<0x1::string::String>(0x1::vector::borrow<0x1::option::Option<0x1::string::String>>(&arg5, v0))) {
                0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(0x1::option::extract<0x1::string::String>(0x1::vector::borrow_mut<0x1::option::Option<0x1::string::String>>(&mut arg5, v0)))))
            } else {
                0x1::option::none<0x2::url::Url>()
            };
            let v2 = WinnerInfo{
                project_name        : *0x1::vector::borrow<0x1::string::String>(&arg3, v0),
                project_description : *0x1::vector::borrow<0x1::option::Option<0x1::string::String>>(&arg4, v0),
                project_link        : v1,
                reward_amount       : *0x1::vector::borrow<u64>(&arg2, v0),
                claimed             : false,
            };
            0x2::table::add<address, WinnerInfo>(&mut arg0.winners, *0x1::vector::borrow<address>(&arg1, v0), v2);
            v0 = v0 + 1;
        };
    }

    entry fun create_event_pool(arg0: &mut EventPoolRegistry, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(0x1::option::extract<0x1::string::String>(&mut arg3))))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v1 = EventPool{
            id                : 0x2::object::new(arg4),
            name              : arg1,
            description       : arg2,
            image_url         : v0,
            admin             : 0x2::tx_context::sender(arg4),
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            winners           : 0x2::table::new<address, WinnerInfo>(arg4),
            winner_addresses  : 0x1::vector::empty<address>(),
            total_distributed : 0,
            is_active         : false,
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.pool_ids, 0x2::object::id<EventPool>(&v1));
        0x2::transfer::share_object<EventPool>(v1);
    }

    entry fun deposit_sui_to_event_pool(arg0: &mut EventPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_event_pool_admin(arg0: &EventPool) : address {
        arg0.admin
    }

    public fun get_event_pool_description(arg0: &EventPool) : 0x1::option::Option<0x1::string::String> {
        arg0.description
    }

    public fun get_event_pool_image_url(arg0: &EventPool) : 0x1::option::Option<0x2::url::Url> {
        arg0.image_url
    }

    public fun get_event_pool_name(arg0: &EventPool) : 0x1::string::String {
        arg0.name
    }

    public fun get_event_pool_total_balance(arg0: &EventPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_event_pool_total_distributed(arg0: &EventPool) : u64 {
        arg0.total_distributed
    }

    public fun get_event_pool_winner_addresses(arg0: &EventPool) : vector<address> {
        arg0.winner_addresses
    }

    public fun get_winner_info(arg0: &EventPool, arg1: address) : &WinnerInfo {
        0x2::table::borrow<address, WinnerInfo>(&arg0.winners, arg1)
    }

    public fun has_claimed(arg0: &EventPool, arg1: address) : bool {
        if (!0x2::table::contains<address, WinnerInfo>(&arg0.winners, arg1)) {
            return false
        };
        0x2::table::borrow<address, WinnerInfo>(&arg0.winners, arg1).claimed
    }

    fun init(arg0: CLAIMUP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = EventPoolRegistry{
            id       : 0x2::object::new(arg1),
            pool_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Project Name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Project Link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Reward Amount"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project_name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project_link}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{amount}"));
        let v5 = 0x2::package::claim<CLAIMUP>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<RewardReceipt>(&v5, v1, v3, arg1);
        0x2::display::update_version<RewardReceipt>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<RewardReceipt>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<EventPoolRegistry>(v0);
    }

    public fun is_winner(arg0: &EventPool, arg1: address) : bool {
        0x2::table::contains<address, WinnerInfo>(&arg0.winners, arg1)
    }

    entry fun toggle_event_pool_active(arg0: &mut EventPool, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 101);
        arg0.is_active = !arg0.is_active;
    }

    entry fun winner_claim_reward(arg0: &mut EventPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 106);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, WinnerInfo>(&arg0.winners, v0), 103);
        let v1 = 0x2::table::borrow_mut<address, WinnerInfo>(&mut arg0.winners, v0);
        assert!(!v1.claimed, 104);
        let v2 = v1.reward_amount;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v2, 105);
        v1.claimed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v2), arg2), v0);
        arg0.total_distributed = arg0.total_distributed + v2;
        let v3 = RewardReceipt{
            id           : 0x2::object::new(arg2),
            image_url    : arg0.image_url,
            project_name : v1.project_name,
            project_link : v1.project_link,
            amount       : v2,
            claimed_at   : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::transfer::transfer<RewardReceipt>(v3, v0);
    }

    entry fun withdraw_event_pool_balance_remaining(arg0: &mut EventPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 101);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 105);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

