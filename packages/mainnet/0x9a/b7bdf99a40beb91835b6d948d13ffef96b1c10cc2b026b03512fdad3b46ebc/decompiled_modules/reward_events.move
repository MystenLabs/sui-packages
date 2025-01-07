module 0x9ab7bdf99a40beb91835b6d948d13ffef96b1c10cc2b026b03512fdad3b46ebc::reward_events {
    struct ChangedOwner has copy, drop {
        current_owner: address,
        new_owner: address,
    }

    struct TokenRecieved has copy, drop {
        received_token_amount: u64,
    }

    struct ChangedPercentage has copy, drop {
        category_name: vector<0x1::string::String>,
        updated_percentage: vector<u64>,
    }

    struct ReceiversContractObjectId has copy, drop {
        category_name: vector<0x1::string::String>,
        category_id: vector<address>,
    }

    struct CategoryNames has copy, drop {
        category_name: vector<0x1::string::String>,
        category_percentages: vector<u64>,
        category_id: vector<address>,
    }

    struct DistributeRewards has copy, drop {
        category_names: vector<0x1::string::String>,
        amount: vector<u64>,
    }

    struct SetTime has copy, drop {
        time_in_days: u64,
    }

    struct GetCategoryPercentage has copy, drop {
        category_name: 0x1::string::String,
        category_percentage: u64,
    }

    public(friend) fun category_names_and_percentage_event(arg0: vector<0x1::string::String>, arg1: vector<u64>, arg2: vector<address>) {
        let v0 = CategoryNames{
            category_name        : arg0,
            category_percentages : arg1,
            category_id          : arg2,
        };
        0x2::event::emit<CategoryNames>(v0);
    }

    public(friend) fun change_percentage_event(arg0: vector<0x1::string::String>, arg1: vector<u64>) {
        let v0 = ChangedPercentage{
            category_name      : arg0,
            updated_percentage : arg1,
        };
        0x2::event::emit<ChangedPercentage>(v0);
    }

    public(friend) fun changed_owner_event(arg0: address, arg1: address) {
        let v0 = ChangedOwner{
            current_owner : arg0,
            new_owner     : arg1,
        };
        0x2::event::emit<ChangedOwner>(v0);
    }

    public(friend) fun distribute_rewards_event(arg0: vector<0x1::string::String>, arg1: vector<u64>) {
        let v0 = DistributeRewards{
            category_names : arg0,
            amount         : arg1,
        };
        0x2::event::emit<DistributeRewards>(v0);
    }

    public(friend) fun get_category_name_and_percentage_event(arg0: 0x1::string::String, arg1: u64) {
        let v0 = GetCategoryPercentage{
            category_name       : arg0,
            category_percentage : arg1,
        };
        0x2::event::emit<GetCategoryPercentage>(v0);
    }

    public(friend) fun received_token_event(arg0: u64) {
        let v0 = TokenRecieved{received_token_amount: arg0};
        0x2::event::emit<TokenRecieved>(v0);
    }

    public(friend) fun receiver_contract_ids_event(arg0: vector<0x1::string::String>, arg1: vector<address>) {
        let v0 = ReceiversContractObjectId{
            category_name : arg0,
            category_id   : arg1,
        };
        0x2::event::emit<ReceiversContractObjectId>(v0);
    }

    public(friend) fun set_time_in_days_event(arg0: u64) {
        let v0 = SetTime{time_in_days: arg0};
        0x2::event::emit<SetTime>(v0);
    }

    // decompiled from Move bytecode v6
}

