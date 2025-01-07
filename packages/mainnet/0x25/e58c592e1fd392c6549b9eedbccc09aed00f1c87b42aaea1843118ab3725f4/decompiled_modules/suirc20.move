module 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::suirc20 {
    struct SUIRC20Tick has store, key {
        id: 0x2::object::UID,
        p: 0x1::string::String,
        tick: 0x1::string::String,
        max: u64,
        lim: u64,
        fee: u64,
        dec: u8,
        freq: u64,
        pick: u64,
        share: bool,
        confirmed_share: bool,
        fee_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_claim_cap_id: 0x1::option::Option<0x2::object::ID>,
        creator: address,
        created_ts: u64,
    }

    struct SUIRC20Action has store, key {
        id: 0x2::object::UID,
        inscription: 0x1::string::String,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct DeployEvent has copy, drop, store {
        action_id: 0x2::object::ID,
        tick_id: 0x2::object::ID,
        p: 0x1::string::String,
        tick: 0x1::string::String,
        max: u64,
        lim: u64,
        dec: u8,
        fee: u64,
        freq: u64,
        pick: u64,
        share: bool,
        fee_claim_cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct MintEvent has copy, drop, store {
        action_id: 0x2::object::ID,
        tick_id: 0x2::object::ID,
        p: 0x1::string::String,
        tick: 0x1::string::String,
        amt: u64,
    }

    struct TransferEvent has copy, drop, store {
        action_id: 0x2::object::ID,
        p: 0x1::string::String,
        tick: 0x1::string::String,
        amt: u64,
        to: address,
    }

    struct TransferFromEvent has copy, drop, store {
        action_id: 0x2::object::ID,
        p: 0x1::string::String,
        tick: 0x1::string::String,
        amt: u64,
        from: address,
        to: address,
    }

    public fun transfer(arg0: 0x1::string::String, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = SUIRC20Action{
            id          : 0x2::object::new(arg3),
            inscription : transfer_data(arg0, arg1, arg2),
            fee         : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = 0x2::object::id<SUIRC20Action>(&v0);
        0x2::transfer::freeze_object<SUIRC20Action>(v0);
        let v2 = TransferEvent{
            action_id : v1,
            p         : protocol(),
            tick      : arg0,
            amt       : arg1,
            to        : arg2,
        };
        0x2::event::emit<TransferEvent>(v2);
        v1
    }

    public fun add_v1_tick(arg0: &mut 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::GlobalConfig, arg1: &0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::AdminCap, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::checked_package_version(arg0);
        let v0 = 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::tick_key(protocol(), arg2);
        assert!(!0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::contains_tick(arg0, v0), 0);
        assert!(arg3 <= arg5, 5);
        assert!(arg6 <= 18, 6);
        assert!(0x1::vector::length<u8>(0x1::string::bytes(&arg2)) == 4, 4);
        let v1 = create_tick(arg2, arg3, arg4, arg5, arg6, arg7, false, 0, 0x1::option::none<0x2::object::ID>(), arg8, arg9);
        0x2::transfer::public_share_object<SUIRC20Tick>(v1);
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::add_tick(arg0, v0, 0x2::object::id<SUIRC20Tick>(&v1));
    }

    fun create_tick(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: bool, arg7: u64, arg8: 0x1::option::Option<0x2::object::ID>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : SUIRC20Tick {
        SUIRC20Tick{
            id               : 0x2::object::new(arg10),
            p                : protocol(),
            tick             : arg0,
            max              : arg3,
            lim              : arg1,
            fee              : arg2,
            dec              : arg4,
            freq             : arg5,
            pick             : arg7,
            share            : arg6,
            confirmed_share  : false,
            fee_vault        : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_claim_cap_id : arg8,
            creator          : 0x2::tx_context::sender(arg10),
            created_ts       : 0x2::clock::timestamp_ms(arg9),
        }
    }

    public fun deploy(arg0: &mut 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::GlobalConfig, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::checked_package_version(arg0);
        assert!(0x1::vector::length<u8>(0x1::string::bytes(&arg1)) == 4, 4);
        assert!(arg2 <= arg4, 5);
        assert!(arg5 <= 18, 6);
        let v0 = 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::tick_key(protocol(), arg1);
        assert!(!0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::contains_tick(arg0, v0), 0);
        let v1 = 0x1::option::none<0x2::object::ID>();
        let v2 = create_tick(arg1, arg2, arg3, arg4, arg5, arg6, false, 0, v1, arg7, arg8);
        let v3 = 0x2::object::id<SUIRC20Tick>(&v2);
        0x2::transfer::public_share_object<SUIRC20Tick>(v2);
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::add_tick(arg0, v0, v3);
        let v4 = SUIRC20Action{
            id          : 0x2::object::new(arg8),
            inscription : deploy_data(protocol(), arg1, arg2, arg4, arg3, arg5, arg6, 0, false),
            fee         : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v5 = 0x2::object::id<SUIRC20Action>(&v4);
        0x2::transfer::freeze_object<SUIRC20Action>(v4);
        let v6 = DeployEvent{
            action_id        : v5,
            tick_id          : v3,
            p                : protocol(),
            tick             : arg1,
            max              : arg4,
            lim              : arg2,
            dec              : arg5,
            fee              : arg3,
            freq             : arg6,
            pick             : 0,
            share            : false,
            fee_claim_cap_id : v1,
        };
        0x2::event::emit<DeployEvent>(v6);
        v5
    }

    fun deploy_data(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: bool) : 0x1::string::String {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"p"), arg0);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"op"), 0x1::string::utf8(b"deploy"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"tick"), arg1);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"max"), 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::str(arg3));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"lim"), 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::str(arg2));
        if (arg5 != 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"dec"), 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::str((arg5 as u64)));
        };
        if (arg6 != 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"freq"), 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::str(arg6));
        };
        if (arg8) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"share"), 0x1::string::utf8(b"BOOL_TRUE"));
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"share"), 0x1::string::utf8(b"BOOL_FALSE"));
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"fee"), 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::str(arg4));
        if (arg7 > 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"pick"), 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::str(arg7));
        };
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::to_json(&v0)
    }

    public fun mint(arg0: &SUIRC20Tick, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.fee, 1);
        assert!(arg1 <= arg0.lim, 2);
        assert!(!arg0.share, 3);
        let v0 = if (arg0.fee > 0) {
            0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.fee, arg3))
        } else {
            0x2::balance::zero<0x2::sui::SUI>()
        };
        let v1 = SUIRC20Action{
            id          : 0x2::object::new(arg3),
            inscription : mint_data(arg0.tick, arg1),
            fee         : v0,
        };
        let v2 = 0x2::object::id<SUIRC20Action>(&v1);
        0x2::transfer::freeze_object<SUIRC20Action>(v1);
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::transfer_or_destory_coin<0x2::sui::SUI>(arg2, arg3);
        let v3 = MintEvent{
            action_id : v2,
            tick_id   : 0x2::object::id<SUIRC20Tick>(arg0),
            p         : protocol(),
            tick      : arg0.tick,
            amt       : arg1,
        };
        0x2::event::emit<MintEvent>(v3);
        v2
    }

    fun mint_data(arg0: 0x1::string::String, arg1: u64) : 0x1::string::String {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"p"), protocol());
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"op"), 0x1::string::utf8(b"mint"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"tick"), arg0);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"amt"), 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::str(arg1));
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::to_json(&v0)
    }

    public fun protocol() : 0x1::string::String {
        0x1::string::utf8(b"suirc-20")
    }

    fun transfer_data(arg0: 0x1::string::String, arg1: u64, arg2: address) : 0x1::string::String {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"p"), protocol());
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"op"), 0x1::string::utf8(b"transfer"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"tick"), arg0);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"amt"), 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::str(arg1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"to"), 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::address_to_str(arg2));
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::to_json(&v0)
    }

    public fun transfer_from(arg0: 0x1::string::String, arg1: u64, arg2: &0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::Account, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::Account>(arg2);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = SUIRC20Action{
            id          : 0x2::object::new(arg4),
            inscription : transfer_from_data(arg0, arg1, v1, arg3),
            fee         : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v3 = 0x2::object::id<SUIRC20Action>(&v2);
        0x2::transfer::freeze_object<SUIRC20Action>(v2);
        let v4 = TransferFromEvent{
            action_id : v3,
            p         : protocol(),
            tick      : arg0,
            amt       : arg1,
            from      : v1,
            to        : arg3,
        };
        0x2::event::emit<TransferFromEvent>(v4);
        v3
    }

    fun transfer_from_data(arg0: 0x1::string::String, arg1: u64, arg2: address, arg3: address) : 0x1::string::String {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"p"), protocol());
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"op"), 0x1::string::utf8(b"transfer_from"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"tick"), arg0);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"amt"), 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::str(arg1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"from"), 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::address_to_str(arg2));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"to"), 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::address_to_str(arg3));
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::utils::to_json(&v0)
    }

    // decompiled from Move bytecode v6
}

