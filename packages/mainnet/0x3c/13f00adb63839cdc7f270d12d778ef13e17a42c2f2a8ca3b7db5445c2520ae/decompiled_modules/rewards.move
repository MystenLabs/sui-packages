module 0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::rewards {
    struct RewardWheel has store, key {
        id: 0x2::object::UID,
        paused: bool,
        rewards: 0x2::object_bag::ObjectBag,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        valid: bool,
    }

    struct Reward has store, key {
        id: 0x2::object::UID,
    }

    struct RewardV2 has store, key {
        id: 0x2::object::UID,
        reward: 0x1::type_name::TypeName,
        amount: u64,
        reward_id: 0x2::object::ID,
    }

    struct RewardEvent has copy, drop {
        reward: 0x1::type_name::TypeName,
        amount: u64,
        reward_item_id: 0x2::object::ID,
        reward_parent_id: 0x2::object::ID,
    }

    public fun add_rewards<T0: store + key>(arg0: &mut RewardWheel, arg1: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasAdminCap, arg2: vector<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<T0>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(&arg2)) {
            let v1 = Reward{id: 0x2::object::new(arg3)};
            let v2 = 0x2::object::id<Reward>(&v1);
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg2), 0x2::object::id_to_address(&v2));
            0x2::object_bag::add<u32, Reward>(&mut arg0.rewards, (0x2::object_bag::length(&arg0.rewards) as u32), v1);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg2);
    }

    public fun add_rewards_v2<T0: store + key>(arg0: &mut RewardWheel, arg1: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasAdminCap, arg2: vector<T0>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<u64>(&mut arg3);
        assert!(0x1::vector::length<T0>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906834599545143295);
        0x1::vector::reverse<T0>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(&arg2)) {
            let v1 = 0x1::vector::pop_back<T0>(&mut arg2);
            let v2 = RewardV2{
                id        : 0x2::object::new(arg4),
                reward    : 0x1::type_name::with_defining_ids<T0>(),
                amount    : 0x1::vector::pop_back<u64>(&mut arg3),
                reward_id : 0x2::object::id<T0>(&v1),
            };
            let v3 = 0x2::object::id<RewardV2>(&v2);
            0x2::transfer::public_transfer<T0>(v1, 0x2::object::id_to_address(&v3));
            0x2::object_bag::add<u32, RewardV2>(&mut arg0.rewards, (0x2::object_bag::length(&arg0.rewards) as u32), v2);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
    }

    public fun claim_reward<T0: store + key>(arg0: &mut Reward, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public fun claim_reward_v2<T0: store + key>(arg0: RewardV2, arg1: 0x2::transfer::Receiving<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let RewardV2 {
            id        : v0,
            reward    : _,
            amount    : _,
            reward_id : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(0x2::transfer::public_receive<T0>(&mut arg0.id, arg1), 0x2::tx_context::sender(arg2));
    }

    public fun create_reward_wheel(arg0: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasAdminCap, arg1: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardWheel{
            id       : 0x2::object::new(arg2),
            paused   : false,
            rewards  : 0x2::object_bag::new(arg2),
            metadata : arg1,
        };
        0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::events::emit_wheel_created_event(0x2::object::uid_to_inner(&v0.id), 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<RewardWheel>(v0);
    }

    public(friend) fun create_ticket(arg0: u64, arg1: u16, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : Ticket {
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = 10000;
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = v1 * (10000 - arg0);
            v1 = v3 / 10000;
            v2 = v2 + 1;
        };
        Ticket{
            id    : 0x2::object::new(arg3),
            valid : (0x2::random::generate_u32_in_range(&mut v0, 1, 1000000000) as u64) <= (10000 - v1) * (1000000000 as u64) / 10000,
        }
    }

    public fun create_ticket_admin(arg0: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasAdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = Ticket{
                id    : 0x2::object::new(arg3),
                valid : true,
            };
            0x2::transfer::public_transfer<Ticket>(v1, arg2);
            v0 = v0 + 1;
        };
    }

    public fun destroy_ticket(arg0: Ticket) {
        let Ticket {
            id    : v0,
            valid : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun is_valid(arg0: &Ticket) : bool {
        arg0.valid
    }

    public fun rewards_mut(arg0: &mut RewardWheel) : &mut 0x2::object_bag::ObjectBag {
        &mut arg0.rewards
    }

    public fun set_reward_wheel_metadata(arg0: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasAdminCap, arg1: &mut RewardWheel, arg2: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        arg1.metadata = arg2;
    }

    entry fun spin(arg0: &mut RewardWheel, arg1: Ticket, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 13906834788523835395);
        assert!(arg1.valid, 13906834792818933765);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        destroy_ticket(arg1);
        0x2::transfer::public_transfer<Reward>(0x2::object_bag::remove<u32, Reward>(&mut arg0.rewards, 0x2::random::generate_u32_in_range(&mut v0, 1, (0x2::object_bag::length(&arg0.rewards) as u32))), 0x2::tx_context::sender(arg3));
    }

    entry fun spin_v2(arg0: &mut RewardWheel, arg1: Ticket, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 13906834887308083203);
        assert!(arg1.valid, 13906834891603181573);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = 0x2::object_bag::remove<u32, RewardV2>(&mut arg0.rewards, 0x2::random::generate_u32_in_range(&mut v0, 1, (0x2::object_bag::length(&arg0.rewards) as u32)));
        let v2 = RewardEvent{
            reward           : v1.reward,
            amount           : v1.amount,
            reward_item_id   : v1.reward_id,
            reward_parent_id : 0x2::object::id<RewardV2>(&v1),
        };
        0x2::event::emit<RewardEvent>(v2);
        destroy_ticket(arg1);
        0x2::transfer::public_transfer<RewardV2>(v1, 0x2::tx_context::sender(arg3));
    }

    entry fun toggle_reward_wheel(arg0: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasAdminCap, arg1: &mut RewardWheel) {
        arg1.paused = !arg1.paused;
    }

    public fun withdraw_from_reward_wheel<T0: store + key>(arg0: &0x2ae0e738fdcddae1187d541ea2da3e028c402af1f4df8b74fc43ac2a4162a01d::canvas_admin::CanvasAdminCap, arg1: &mut RewardWheel, arg2: u32) : T0 {
        0x2::object_bag::remove<u32, T0>(&mut arg1.rewards, arg2)
    }

    // decompiled from Move bytecode v6
}

