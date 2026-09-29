module 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::reward {
    struct WinnerInfo has copy, drop, store {
        user: address,
        serial: u64,
        amount: u64,
    }

    struct RewardPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        start_claim_ms: u64,
        end_claim_ms: u64,
        winner_list: vector<WinnerInfo>,
        winners_map: 0x2::table::Table<u64, address>,
        codes: 0x2::table::Table<u64, 0x1::string::String>,
    }

    struct GoldenTicket has store, key {
        id: 0x2::object::UID,
        serial_number: u64,
        reward_amount: u64,
        win_date: u64,
        hashed_code: 0x1::string::String,
    }

    struct REWARD has drop {
        dummy_field: bool,
    }

    public(friend) fun check_reward_amount(arg0: u64) : u64 {
        if (arg0 == 1000) {
            100000000000
        } else if (arg0 == 2000) {
            150000000000
        } else if (arg0 == 3333) {
            200000000000
        } else if (arg0 == 5000) {
            300000000000
        } else if (arg0 == 6666) {
            250000000000
        } else if (arg0 == 8000) {
            400000000000
        } else if (arg0 == 9000) {
            500000000000
        } else if (arg0 == 9500) {
            600000000000
        } else if (arg0 == 10000) {
            1000000000000
        } else {
            0
        }
    }

    entry fun claim_reward(arg0: &mut RewardPool, arg1: GoldenTicket, arg2: &0x2::clock::Clock, arg3: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg3);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_reward_enabled(arg3);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let GoldenTicket {
            id            : v1,
            serial_number : v2,
            reward_amount : v3,
            win_date      : _,
            hashed_code   : _,
        } = arg1;
        0x2::object::delete(v1);
        assert!(arg0.start_claim_ms > 0 && arg0.end_claim_ms > 0, 3);
        assert!(v0 >= arg0.start_claim_ms, 1);
        assert!(v0 <= arg0.end_claim_ms, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v3, arg4), 0x2::tx_context::sender(arg4));
        0x2::table::remove<u64, address>(&mut arg0.winners_map, v2);
    }

    public fun deposit(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut RewardPool, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg4)));
    }

    entry fun get_winners(arg0: &RewardPool) : vector<WinnerInfo> {
        arg0.winner_list
    }

    fun init(arg0: REWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = RewardPool{
            id             : 0x2::object::new(arg1),
            balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            start_claim_ms : 0,
            end_claim_ms   : 0,
            winner_list    : 0x1::vector::empty<WinnerInfo>(),
            winners_map    : 0x2::table::new<u64, address>(arg1),
            codes          : 0x2::table::new<u64, 0x1::string::String>(arg1),
        };
        let v2 = 0x2::package::claim<REWARD>(arg0, arg1);
        let v3 = 0x2::display::new<GoldenTicket>(&v2, arg1);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"creator"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Empty Box Golden Ticket #{serial_number}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"A legendary, limited-edition cryptographic milestone certificate awarded exclusively to the collector who successfully initiated a landmark Mint ID within the Empty Box genesis launch. This Golden Ticket validates a historic contribution to the LifeFi ecosystem network, unlocking an immediate reward in SUI token."));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/{hashed_code}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://theemptyboxclub.com/"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"TEBC Co., LTD"));
        0x2::display::add_multiple<GoldenTicket>(&mut v3, v4, v6);
        0x2::display::update_version<GoldenTicket>(&mut v3);
        let (v8, v9) = 0x2::transfer_policy::new<GoldenTicket>(&v2, arg1);
        let v10 = v9;
        let v11 = v8;
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::rules::add_personal_kiosk_rule<GoldenTicket>(&mut v11, &v10);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::rules::add_royalty_rule<GoldenTicket>(&mut v11, &v10, 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::rules::new_royalty_config(500, 0));
        0x2::transfer::share_object<RewardPool>(v1);
        0x2::transfer::public_transfer<0x2::display::Display<GoldenTicket>>(v3, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<GoldenTicket>>(v10, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<GoldenTicket>>(v11);
    }

    public(friend) fun mint_winner_nft(arg0: &mut RewardPool, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::table::contains<u64, 0x1::string::String>(&arg0.codes, arg2)) {
            *0x2::table::borrow<u64, 0x1::string::String>(&arg0.codes, arg2)
        } else {
            0x1::string::utf8(b"00000000000000000000")
        };
        let v1 = GoldenTicket{
            id            : 0x2::object::new(arg5),
            serial_number : arg2,
            reward_amount : arg3,
            win_date      : 0x2::clock::timestamp_ms(arg4),
            hashed_code   : v0,
        };
        let v2 = WinnerInfo{
            user   : arg1,
            serial : arg2,
            amount : arg3,
        };
        0x1::vector::push_back<WinnerInfo>(&mut arg0.winner_list, v2);
        if (0x2::table::contains<u64, address>(&arg0.winners_map, arg2)) {
            0x2::table::remove<u64, address>(&mut arg0.winners_map, arg2);
        };
        0x2::table::add<u64, address>(&mut arg0.winners_map, arg2, arg1);
        0x2::transfer::transfer<GoldenTicket>(v1, arg1);
    }

    public fun set_claim_time(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut RewardPool, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg4);
        arg1.start_claim_ms = arg2;
        arg1.end_claim_ms = arg3;
    }

    public fun set_reward_images(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut RewardPool, arg2: vector<u64>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            let v1 = *0x1::vector::borrow<u64>(&arg2, v0);
            if (0x2::table::contains<u64, 0x1::string::String>(&arg1.codes, v1)) {
                0x2::table::remove<u64, 0x1::string::String>(&mut arg1.codes, v1);
            };
            0x2::table::add<u64, 0x1::string::String>(&mut arg1.codes, v1, *0x1::vector::borrow<0x1::string::String>(&arg3, v0));
            v0 = v0 + 1;
        };
    }

    public fun update_display(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut 0x2::display::Display<GoldenTicket>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg4);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg3), 4);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg2, v1);
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(0x2::display::fields<GoldenTicket>(arg1), &v2)) {
                0x2::display::edit<GoldenTicket>(arg1, v2, *0x1::vector::borrow<0x1::string::String>(&arg3, v1));
            } else {
                0x2::display::add<GoldenTicket>(arg1, v2, *0x1::vector::borrow<0x1::string::String>(&arg3, v1));
            };
            v1 = v1 + 1;
        };
        0x2::display::update_version<GoldenTicket>(arg1);
    }

    public fun withdraw_remaining(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut RewardPool, arg2: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

