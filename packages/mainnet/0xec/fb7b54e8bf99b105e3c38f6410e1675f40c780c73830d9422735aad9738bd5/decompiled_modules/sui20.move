module 0xecfb7b54e8bf99b105e3c38f6410e1675f40c780c73830d9422735aad9738bd5::sui20 {
    struct SUI20 has drop {
        dummy_field: bool,
    }

    struct InscriptionSui20Collection has store, key {
        id: 0x2::object::UID,
        create_timestamp: u64,
        tick: 0x1::string::String,
        total_epoch: u64,
        current_epoch: u64,
        epoch_duration: u64,
        epoch_token: u64,
        reward_epoch: u64,
        winner_epoch_reward: u64,
        total_token: u64,
        settlement_token: u64,
        total_mint_count: u64,
        is_deploy: bool,
    }

    struct InscriptionSui20 has store, key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        amount: u64,
    }

    struct EpochData has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        total_mint_count: u64,
        total_player: u64,
        total_settlement: u64,
        is_settlement: bool,
    }

    struct UserEpochData has store {
        total_mint_count: u64,
        total_token: u64,
        total_reward: u64,
        address: address,
    }

    struct InitEvent has copy, drop {
        sui20_collection: 0x2::object::ID,
    }

    public fun admin_lq(arg0: &mut InscriptionSui20Collection, arg1: &mut 0x2::tx_context::TxContext) : InscriptionSui20 {
        assert!(0x2::tx_context::sender(arg1) == @0x57185dfd2c4ed44e95ccf6375d8ffb3081a80191480fc162b08d6457e57d49ac, 0);
        InscriptionSui20{
            id     : 0x2::object::new(arg1),
            tick   : arg0.tick,
            amount : arg0.total_token - arg0.settlement_token,
        }
    }

    public entry fun deploy(arg0: &mut 0xb54de60fa35b1f7d7a5e4a7d05abd41e576e86c30e7c5e6315386777706c0e19::sui20::ModuleData, arg1: &mut InscriptionSui20Collection, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_deploy, 0);
        let v0 = arg4 * (arg6 + arg7);
        0xb54de60fa35b1f7d7a5e4a7d05abd41e576e86c30e7c5e6315386777706c0e19::sui20::deploy_sui20(arg0, arg2, arg3, arg4, arg5, arg6, arg7, v0, arg8, 0x2::object::id_address<InscriptionSui20Collection>(arg1), arg9);
        arg1.tick = arg3;
        arg1.total_epoch = arg4;
        arg1.epoch_duration = arg5;
        arg1.epoch_token = arg6;
        arg1.reward_epoch = arg7;
        arg1.total_token = v0;
        arg1.winner_epoch_reward = arg8;
        arg1.is_deploy = true;
    }

    fun init(arg0: SUI20, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUI20>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{tick}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://api.sui-20.net/api/images?tick={tick}&amt={amount}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{'p':'sui-20','tick':'{tick}','amt':'{amount}'}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://sui-20.net"));
        let v5 = 0x2::display::new_with_fields<InscriptionSui20>(&v0, v1, v3, arg1);
        0x2::display::update_version<InscriptionSui20>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, @0x57185dfd2c4ed44e95ccf6375d8ffb3081a80191480fc162b08d6457e57d49ac);
        0x2::transfer::public_transfer<0x2::display::Display<InscriptionSui20>>(v5, @0x57185dfd2c4ed44e95ccf6375d8ffb3081a80191480fc162b08d6457e57d49ac);
        let v6 = InscriptionSui20Collection{
            id                  : 0x2::object::new(arg1),
            create_timestamp    : 0,
            tick                : 0x1::string::utf8(b""),
            total_epoch         : 0,
            current_epoch       : 0,
            epoch_duration      : 0,
            epoch_token         : 0,
            reward_epoch        : 0,
            winner_epoch_reward : 0,
            total_token         : 0,
            settlement_token    : 0,
            total_mint_count    : 0,
            is_deploy           : false,
        };
        let v7 = InitEvent{sui20_collection: 0x2::object::id<InscriptionSui20Collection>(&v6)};
        0x2::event::emit<InitEvent>(v7);
        0x2::transfer::share_object<InscriptionSui20Collection>(v6);
    }

    public fun merge(arg0: InscriptionSui20, arg1: InscriptionSui20, arg2: &mut 0x2::tx_context::TxContext) : InscriptionSui20 {
        let InscriptionSui20 {
            id     : v0,
            tick   : _,
            amount : v2,
        } = arg0;
        let InscriptionSui20 {
            id     : v3,
            tick   : _,
            amount : v5,
        } = arg1;
        0x2::object::delete(v0);
        0x2::object::delete(v3);
        InscriptionSui20{
            id     : 0x2::object::new(arg2),
            tick   : arg0.tick,
            amount : v2 + v5,
        }
    }

    public fun merge_vec(arg0: vector<InscriptionSui20>, arg1: &mut 0x2::tx_context::TxContext) : InscriptionSui20 {
        let v0 = 0;
        let v1 = 0x1::vector::length<InscriptionSui20>(&arg0);
        while (v1 > 0) {
            let InscriptionSui20 {
                id     : v2,
                tick   : _,
                amount : v4,
            } = 0x1::vector::pop_back<InscriptionSui20>(&mut arg0);
            v0 = v0 + v4;
            0x2::object::delete(v2);
            v1 = v1 - 1;
        };
        0x1::vector::destroy_empty<InscriptionSui20>(arg0);
        InscriptionSui20{
            id     : 0x2::object::new(arg1),
            tick   : 0x1::vector::borrow<InscriptionSui20>(&arg0, 0).tick,
            amount : v0,
        }
    }

    public entry fun mint(arg0: &mut 0xb54de60fa35b1f7d7a5e4a7d05abd41e576e86c30e7c5e6315386777706c0e19::sui20::ModuleData, arg1: &mut InscriptionSui20Collection, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = arg1.current_epoch;
        let v3 = v2;
        if (!0x2::dynamic_field::exists_<u64>(&arg1.id, v2)) {
            let v4 = EpochData{
                id               : 0x2::object::new(arg4),
                start_time       : v1,
                total_mint_count : 0,
                total_player     : 0,
                total_settlement : 0,
                is_settlement    : false,
            };
            0x2::dynamic_field::add<u64, EpochData>(&mut arg1.id, v2, v4);
        };
        if (0x2::dynamic_field::borrow<u64, EpochData>(&arg1.id, v2).start_time + arg1.epoch_duration < v1) {
            let v5 = arg1.current_epoch + 1;
            v3 = v5;
            assert!(v5 < arg1.total_epoch, 0);
            arg1.current_epoch = v5;
            let v6 = EpochData{
                id               : 0x2::object::new(arg4),
                start_time       : v1,
                total_mint_count : 0,
                total_player     : 0,
                total_settlement : 0,
                is_settlement    : false,
            };
            0x2::dynamic_field::add<u64, EpochData>(&mut arg1.id, v5, v6);
        };
        let v7 = 0x2::dynamic_field::borrow_mut<u64, EpochData>(&mut arg1.id, v3);
        if (!0x2::dynamic_field::exists_with_type<address, u64>(&v7.id, v0)) {
            v7.total_player = v7.total_player + 1;
            0x2::dynamic_field::add<address, u64>(&mut v7.id, v0, v7.total_player);
            let v8 = UserEpochData{
                total_mint_count : 0,
                total_token      : 0,
                total_reward     : 0,
                address          : v0,
            };
            0x2::dynamic_field::add<u64, UserEpochData>(&mut v7.id, v7.total_player, v8);
        };
        let v9 = 0x2::dynamic_field::borrow_mut<u64, UserEpochData>(&mut v7.id, *0x2::dynamic_field::borrow<address, u64>(&v7.id, v0));
        v9.total_mint_count = v9.total_mint_count + 1;
        v7.total_mint_count = v7.total_mint_count + 1;
        arg1.total_mint_count = arg1.total_mint_count + 1;
        0xb54de60fa35b1f7d7a5e4a7d05abd41e576e86c30e7c5e6315386777706c0e19::sui20::inscribe(arg0, arg2, arg1.tick, v3, v0, v9.total_mint_count, v7.total_mint_count, arg1.total_mint_count, arg4);
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun settlement(arg0: &mut InscriptionSui20Collection, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < arg0.current_epoch, 0);
        assert!(0x2::tx_context::sender(arg4) == @0x57185dfd2c4ed44e95ccf6375d8ffb3081a80191480fc162b08d6457e57d49ac, 0);
        let v0 = 0x2::dynamic_field::borrow_mut<u64, EpochData>(&mut arg0.id, arg1);
        assert!(!v0.is_settlement, 0);
        let v1 = v0.total_settlement + 1;
        let v2 = if (v0.total_settlement + arg2 <= v0.total_player) {
            v0.total_settlement + arg2
        } else {
            v0.total_player
        };
        let v3 = 0;
        if (0x1::vector::length<u64>(&arg3) > 0) {
            v3 = arg0.reward_epoch / 0x1::vector::length<u64>(&arg3);
        };
        while (v1 <= v2) {
            let v4 = 0x2::dynamic_field::borrow_mut<u64, UserEpochData>(&mut v0.id, v1);
            let v5 = arg0.epoch_token * v4.total_mint_count / v0.total_mint_count;
            let v6 = v5;
            v4.total_token = v5;
            if (arg0.reward_epoch > 0 && 0x1::vector::contains<u64>(&arg3, &v1)) {
                v4.total_reward = v3;
                v6 = v5 + v3;
            };
            let v7 = InscriptionSui20{
                id     : 0x2::object::new(arg4),
                tick   : arg0.tick,
                amount : v6,
            };
            arg0.settlement_token = arg0.settlement_token + v6;
            0x2::transfer::public_transfer<InscriptionSui20>(v7, v4.address);
            0xb54de60fa35b1f7d7a5e4a7d05abd41e576e86c30e7c5e6315386777706c0e19::sui20::settlement_event(arg0.tick, arg1, v4.address, v4.total_mint_count, v4.total_token, v4.total_reward, v1 == v0.total_player, arg4);
            v1 = v1 + 1;
        };
        v0.total_settlement = v2;
        if (v0.total_settlement == v0.total_player) {
            v0.is_settlement = true;
        };
    }

    public fun split(arg0: InscriptionSui20, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : InscriptionSui20 {
        let InscriptionSui20 {
            id     : v0,
            tick   : v1,
            amount : v2,
        } = arg0;
        assert!(arg1 < v2, 0);
        let v3 = InscriptionSui20{
            id     : 0x2::object::new(arg2),
            tick   : v1,
            amount : v2 - arg1,
        };
        0x2::transfer::public_transfer<InscriptionSui20>(v3, 0x2::tx_context::sender(arg2));
        0x2::object::delete(v0);
        InscriptionSui20{
            id     : 0x2::object::new(arg2),
            tick   : v1,
            amount : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

