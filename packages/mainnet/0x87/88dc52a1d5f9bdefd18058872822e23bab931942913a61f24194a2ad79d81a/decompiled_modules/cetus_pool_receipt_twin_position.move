module 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position {
    struct Receipt has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        pool_id: 0x2::object::ID,
        pending_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        x_token_balance: u128,
        last_acc_reward_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        y_token_balance: u128,
        last_acc_reward_per_ytoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
    }

    public fun accumulate_pending_rewards(arg0: &mut Receipt, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, &arg1);
        *v0 = *v0 + arg2;
    }

    public fun add_x_token_balance(arg0: &mut Receipt, arg1: u128) {
        arg0.x_token_balance = arg0.x_token_balance + arg1;
    }

    public fun add_y_token_balance(arg0: &mut Receipt, arg1: u128) {
        arg0.y_token_balance = arg0.y_token_balance + arg1;
    }

    public fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : Receipt {
        Receipt{
            id                         : 0x2::object::new(arg3),
            owner                      : 0x2::tx_context::sender(arg3),
            name                       : arg0,
            image_url                  : arg1,
            pool_id                    : arg2,
            pending_rewards            : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            x_token_balance            : 0,
            last_acc_reward_per_xtoken : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            y_token_balance            : 0,
            last_acc_reward_per_ytoken : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
        }
    }

    public fun create_with(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg4: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>, arg5: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>, arg6: &mut 0x2::tx_context::TxContext) : Receipt {
        Receipt{
            id                         : 0x2::object::new(arg6),
            owner                      : 0x2::tx_context::sender(arg6),
            name                       : arg0,
            image_url                  : arg1,
            pool_id                    : arg2,
            pending_rewards            : arg3,
            x_token_balance            : 0,
            last_acc_reward_per_xtoken : arg4,
            y_token_balance            : 0,
            last_acc_reward_per_ytoken : arg5,
        }
    }

    public fun destroy(arg0: Receipt) {
        let Receipt {
            id                         : v0,
            owner                      : _,
            name                       : _,
            image_url                  : _,
            pool_id                    : _,
            pending_rewards            : _,
            x_token_balance            : _,
            last_acc_reward_per_xtoken : v7,
            y_token_balance            : _,
            last_acc_reward_per_ytoken : v9,
        } = arg0;
        let v10 = v9;
        let v11 = v7;
        0x2::object::delete(v0);
        let v12 = 0;
        while (v12 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&v11)) {
            let (_, _) = 0x2::vec_map::pop<0x1::type_name::TypeName, u256>(&mut v11);
            v12 = v12 + 1;
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, u256>(v11);
        let v15 = 0;
        while (v15 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&v10)) {
            let (_, _) = 0x2::vec_map::pop<0x1::type_name::TypeName, u256>(&mut v10);
            v15 = v15 + 1;
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, u256>(v10);
    }

    public fun image_url(arg0: &Receipt) : 0x1::string::String {
        arg0.image_url
    }

    public fun last_acc_reward_per_xtoken(arg0: &Receipt) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256> {
        arg0.last_acc_reward_per_xtoken
    }

    public fun last_acc_reward_per_xtoken_contains(arg0: &Receipt, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.last_acc_reward_per_xtoken, &arg1)
    }

    public fun last_acc_reward_per_xtoken_get_mut(arg0: &mut Receipt, arg1: 0x1::type_name::TypeName) : &mut u256 {
        0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, &arg1)
    }

    public fun last_acc_reward_per_xtoken_insert(arg0: &mut Receipt, arg1: 0x1::type_name::TypeName, arg2: u256) {
        0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_xtoken, arg1, arg2);
    }

    public fun last_acc_reward_per_ytoken(arg0: &Receipt) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256> {
        arg0.last_acc_reward_per_ytoken
    }

    public fun last_acc_reward_per_ytoken_contains(arg0: &Receipt, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.last_acc_reward_per_ytoken, &arg1)
    }

    public fun last_acc_reward_per_ytoken_get_mut(arg0: &mut Receipt, arg1: 0x1::type_name::TypeName) : &mut u256 {
        0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_ytoken, &arg1)
    }

    public fun last_acc_reward_per_ytoken_insert(arg0: &mut Receipt, arg1: 0x1::type_name::TypeName, arg2: u256) {
        0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.last_acc_reward_per_ytoken, arg1, arg2);
    }

    public fun name(arg0: &Receipt) : 0x1::string::String {
        arg0.name
    }

    public fun owner(arg0: &Receipt) : address {
        arg0.owner
    }

    public fun pending_rewards_contains(arg0: &mut Receipt, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.pending_rewards, &arg1)
    }

    public fun pending_rewards_extract(arg0: &mut Receipt, arg1: 0x1::type_name::TypeName) : u64 {
        let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, &arg1);
        *v0 = 0;
        *v0
    }

    public fun pending_rewards_insert(arg0: &mut Receipt, arg1: 0x1::type_name::TypeName, arg2: u64) {
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.pending_rewards, arg1, arg2);
    }

    public fun pool_id(arg0: &Receipt) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun sub_x_token_balance(arg0: &mut Receipt, arg1: u128) {
        arg0.x_token_balance = arg0.x_token_balance - arg1;
    }

    public fun sub_y_token_balance(arg0: &mut Receipt, arg1: u128) {
        arg0.y_token_balance = arg0.y_token_balance - arg1;
    }

    public fun x_token_balance(arg0: &Receipt) : u128 {
        arg0.x_token_balance
    }

    public fun y_token_balance(arg0: &Receipt) : u128 {
        arg0.y_token_balance
    }

    // decompiled from Move bytecode v6
}

