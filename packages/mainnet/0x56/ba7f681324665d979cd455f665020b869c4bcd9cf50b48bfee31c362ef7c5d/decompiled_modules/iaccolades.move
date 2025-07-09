module 0x56ba7f681324665d979cd455f665020b869c4bcd9cf50b48bfee31c362ef7c5d::iaccolades {
    struct Accolade has store {
        accolade: 0x2::vec_map::VecMap<0x1::string::String, u128>,
        claimed_accolade_rewards: 0x2::vec_map::VecMap<0x1::string::String, vector<u128>>,
    }

    struct AccoladeRewardRegistry has key {
        id: 0x2::object::UID,
    }

    struct AccoladeReward has store, key {
        id: 0x2::object::UID,
    }

    struct AccoladeThresholdMapRegistry has store, key {
        id: 0x2::object::UID,
        rewards: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u128, u64>>,
    }

    public(friend) fun add_df_to_reward_registry(arg0: &mut AccoladeReward, arg1: 0x1::string::String, arg2: vector<0x2::vec_map::VecMap<0x1::string::String, u64>>) {
        0x2::dynamic_field::add<0x1::string::String, vector<0x2::vec_map::VecMap<0x1::string::String, u64>>>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun add_dof_to_reward_registry(arg0: &mut AccoladeRewardRegistry, arg1: u64, arg2: AccoladeReward) {
        0x2::dynamic_object_field::add<u64, AccoladeReward>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun delete_accolade_reward(arg0: &mut AccoladeRewardRegistry, arg1: u64) {
        let AccoladeReward { id: v0 } = 0x2::dynamic_object_field::remove<u64, AccoladeReward>(&mut arg0.id, arg1);
        0x2::object::delete(v0);
    }

    public(friend) fun dynamic_object_fields_exists(arg0: &AccoladeRewardRegistry, arg1: u64) : bool {
        0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1)
    }

    public(friend) fun get_accolade(arg0: &Accolade) : (&0x2::vec_map::VecMap<0x1::string::String, u128>, &0x2::vec_map::VecMap<0x1::string::String, vector<u128>>) {
        (&arg0.accolade, &arg0.claimed_accolade_rewards)
    }

    public(friend) fun get_accolade_reward(arg0: &AccoladeReward) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun get_accolade_rewards_list(arg0: &AccoladeThresholdMapRegistry, arg1: 0x1::string::String) : 0x1::option::Option<0x2::vec_map::VecMap<u128, u64>> {
        0x2::vec_map::try_get<0x1::string::String, 0x2::vec_map::VecMap<u128, u64>>(&arg0.rewards, &arg1)
    }

    public(friend) fun get_accolade_threshold_rewards(arg0: &mut AccoladeThresholdMapRegistry) : (&0x2::object::UID, &mut 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u128, u64>>) {
        (&arg0.id, &mut arg0.rewards)
    }

    public(friend) fun get_dof_accolade_reward(arg0: &AccoladeRewardRegistry, arg1: u64) : &AccoladeReward {
        0x2::dynamic_object_field::borrow<u64, AccoladeReward>(&arg0.id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccoladeRewardRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AccoladeRewardRegistry>(v0);
        let v1 = AccoladeThresholdMapRegistry{
            id      : 0x2::object::new(arg0),
            rewards : 0x2::vec_map::empty<0x1::string::String, 0x2::vec_map::VecMap<u128, u64>>(),
        };
        0x2::transfer::share_object<AccoladeThresholdMapRegistry>(v1);
    }

    public(friend) fun insert_accolade_claimed_rewards(arg0: &mut Accolade, arg1: 0x1::string::String, arg2: vector<u128>) {
        0x2::vec_map::insert<0x1::string::String, vector<u128>>(&mut arg0.claimed_accolade_rewards, arg1, arg2);
    }

    public(friend) fun insert_accolade_data(arg0: &mut Accolade, arg1: 0x1::string::String, arg2: u128) {
        0x2::vec_map::insert<0x1::string::String, u128>(&mut arg0.accolade, arg1, arg2);
    }

    public(friend) fun new_accolade() : Accolade {
        Accolade{
            accolade                 : 0x2::vec_map::empty<0x1::string::String, u128>(),
            claimed_accolade_rewards : 0x2::vec_map::empty<0x1::string::String, vector<u128>>(),
        }
    }

    public(friend) fun new_accolade_reward(arg0: &mut 0x2::tx_context::TxContext) : AccoladeReward {
        AccoladeReward{id: 0x2::object::new(arg0)}
    }

    public(friend) fun push_back_accolade_claimed_rewards(arg0: &mut Accolade, arg1: 0x1::string::String, arg2: u128) {
        0x1::vector::push_back<u128>(0x2::vec_map::get_mut<0x1::string::String, vector<u128>>(&mut arg0.claimed_accolade_rewards, &arg1), arg2);
    }

    public(friend) fun update_accolade_data(arg0: &mut Accolade, arg1: 0x1::string::String, arg2: u128) {
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, u128>(&mut arg0.accolade, &arg1);
        *v0 = *v0 + arg2;
    }

    // decompiled from Move bytecode v6
}

