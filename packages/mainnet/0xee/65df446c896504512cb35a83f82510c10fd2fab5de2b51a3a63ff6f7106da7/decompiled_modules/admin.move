module 0xee65df446c896504512cb35a83f82510c10fd2fab5de2b51a3a63ff6f7106da7::admin {
    struct CreateRewardsPoolEvent has copy, drop {
        sender: address,
        reward_pool_id: 0x2::object::ID,
        type: 0x1::type_name::TypeName,
        signer_pk: vector<u8>,
    }

    struct UpdateRewardsPoolEvent has copy, drop {
        sender: address,
        reward_pool_id: 0x2::object::ID,
        type: 0x1::type_name::TypeName,
        signer_pk: vector<u8>,
    }

    struct AddRewardsEvent has copy, drop {
        sender: address,
        reward_pool_id: 0x2::object::ID,
        type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add_rewards<T0>(arg0: &mut 0xee65df446c896504512cb35a83f82510c10fd2fab5de2b51a3a63ff6f7106da7::rewards_pool::RewardsPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xee65df446c896504512cb35a83f82510c10fd2fab5de2b51a3a63ff6f7106da7::rewards_pool::add_rewards<T0>(arg0, arg1);
        let v0 = AddRewardsEvent{
            sender         : 0x2::tx_context::sender(arg2),
            reward_pool_id : 0x2::object::id<0xee65df446c896504512cb35a83f82510c10fd2fab5de2b51a3a63ff6f7106da7::rewards_pool::RewardsPool<T0>>(arg0),
            type           : 0x1::type_name::get<T0>(),
            amount         : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<AddRewardsEvent>(v0);
    }

    public entry fun create_rewards_pool<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xee65df446c896504512cb35a83f82510c10fd2fab5de2b51a3a63ff6f7106da7::rewards_pool::new<T0>(arg1, arg2);
        let v1 = CreateRewardsPoolEvent{
            sender         : 0x2::tx_context::sender(arg2),
            reward_pool_id : 0x2::object::id<0xee65df446c896504512cb35a83f82510c10fd2fab5de2b51a3a63ff6f7106da7::rewards_pool::RewardsPool<T0>>(&v0),
            type           : 0x1::type_name::get<T0>(),
            signer_pk      : arg1,
        };
        0x2::event::emit<CreateRewardsPoolEvent>(v1);
        0x2::transfer::public_share_object<0xee65df446c896504512cb35a83f82510c10fd2fab5de2b51a3a63ff6f7106da7::rewards_pool::RewardsPool<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun update_rewards_pool<T0>(arg0: &AdminCap, arg1: &mut 0xee65df446c896504512cb35a83f82510c10fd2fab5de2b51a3a63ff6f7106da7::rewards_pool::RewardsPool<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0xee65df446c896504512cb35a83f82510c10fd2fab5de2b51a3a63ff6f7106da7::rewards_pool::update_signer_pk<T0>(arg1, arg2);
        let v0 = UpdateRewardsPoolEvent{
            sender         : 0x2::tx_context::sender(arg3),
            reward_pool_id : 0x2::object::id<0xee65df446c896504512cb35a83f82510c10fd2fab5de2b51a3a63ff6f7106da7::rewards_pool::RewardsPool<T0>>(arg1),
            type           : 0x1::type_name::get<T0>(),
            signer_pk      : arg2,
        };
        0x2::event::emit<UpdateRewardsPoolEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

