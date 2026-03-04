module 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts {
    struct Prompt has store {
        creator: address,
        blob: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob,
        fee_amount: u64,
        submission_time: u64,
        target_epoch: u64,
        boost_count: u64,
    }

    struct RankedPrompts has store {
        prompts: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, Prompt>,
        last_fees: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u64, u256>,
    }

    public(friend) fun length(arg0: &RankedPrompts) : u32 {
        (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::length<u256, Prompt>(&arg0.prompts) as u32)
    }

    public fun destroy_empty(arg0: RankedPrompts) {
        let RankedPrompts {
            prompts   : v0,
            last_fees : v1,
        } = arg0;
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::destroy_empty<u256, Prompt>(v0);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::destroy_empty<u64, u256>(v1);
    }

    public(friend) fun contains(arg0: &RankedPrompts, arg1: u256) : bool {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u256, Prompt>(&arg0.prompts, arg1)
    }

    public fun front(arg0: &RankedPrompts) : &0x1::option::Option<u256> {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<u256, Prompt>(&arg0.prompts)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : RankedPrompts {
        RankedPrompts{
            prompts   : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<u256, Prompt>(arg0),
            last_fees : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<u64, u256>(arg0),
        }
    }

    public fun next(arg0: &RankedPrompts, arg1: u256) : &0x1::option::Option<u256> {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<u256, Prompt>(&arg0.prompts, arg1)
    }

    public(friend) fun add(arg0: &mut RankedPrompts, arg1: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg2: u64, arg3: u64, arg4: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg2 >= 1000000000, 0);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::is_deletable(&arg1), 3);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::game_utils::validate_blob_lifetime(&arg1, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg4));
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg1);
        assert!(!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u256, Prompt>(&arg0.prompts, v0), 1);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<u256, Prompt>(&mut arg0.prompts, v0, create_prompt(arg1, arg2, 0x2::clock::timestamp_ms(arg5), arg3, arg6));
        update_fee_ranking(arg0, v0, 0, arg2);
    }

    public fun add_existing_prompt(arg0: &mut RankedPrompts, arg1: Prompt, arg2: &mut 0x2::tx_context::TxContext) : u256 {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg1.blob);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<u256, Prompt>(&mut arg0.prompts, v0, arg1);
        update_fee_ranking(arg0, v0, 0, arg1.fee_amount);
        v0
    }

    public(friend) fun cancel_prompt(arg0: &mut RankedPrompts, arg1: u256, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &0x2::tx_context::TxContext) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage {
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u256, Prompt>(&arg0.prompts, arg1), 1);
        let v0 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Prompt>(&arg0.prompts, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg3), 2);
        remove_from_fee_ranking(arg0, arg1, v0.fee_amount);
        let Prompt {
            creator         : _,
            blob            : v2,
            fee_amount      : _,
            submission_time : _,
            target_epoch    : _,
            boost_count     : _,
        } = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<u256, Prompt>(&mut arg0.prompts, arg1);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_blob(arg2, v2)
    }

    public(friend) fun create_prompt(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) : Prompt {
        Prompt{
            creator         : 0x2::tx_context::sender(arg4),
            blob            : arg0,
            fee_amount      : arg1,
            submission_time : arg2,
            target_epoch    : arg3,
            boost_count     : 0,
        }
    }

    public(friend) fun delete_blob_from_prompt_and_send_storage(arg0: Prompt, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: address) : u64 {
        let Prompt {
            creator         : _,
            blob            : v1,
            fee_amount      : _,
            submission_time : _,
            target_epoch    : _,
            boost_count     : _,
        } = arg0;
        let v6 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_blob(arg1, v1);
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(v6, arg2);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v6)
    }

    public(friend) fun extract_all_prompts(arg0: RankedPrompts) : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, Prompt> {
        let RankedPrompts {
            prompts   : v0,
            last_fees : v1,
        } = arg0;
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::drop<u64, u256>(v1);
        v0
    }

    public(friend) fun get_blob_from_prompt(arg0: &Prompt) : &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        &arg0.blob
    }

    public(friend) fun get_blob_obj_id_from_prompt(arg0: &Prompt) : 0x2::object::ID {
        0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blob)
    }

    public(friend) fun get_prompt(arg0: &RankedPrompts, arg1: u256) : &Prompt {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Prompt>(&arg0.prompts, arg1)
    }

    public(friend) fun get_prompt_blob(arg0: &RankedPrompts, arg1: u256) : &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Prompt>(&arg0.prompts, arg1).blob
    }

    public(friend) fun get_prompt_creator(arg0: &RankedPrompts, arg1: u256) : address {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Prompt>(&arg0.prompts, arg1).creator
    }

    public(friend) fun get_prompt_creator_from_prompt(arg0: &Prompt) : address {
        arg0.creator
    }

    public(friend) fun get_prompt_fee(arg0: &RankedPrompts, arg1: u256) : u64 {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Prompt>(&arg0.prompts, arg1).fee_amount
    }

    public(friend) fun get_prompt_fee_from_prompt(arg0: &Prompt) : u64 {
        arg0.fee_amount
    }

    public(friend) fun get_prompt_id(arg0: &Prompt) : u256 {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg0.blob)
    }

    public(friend) fun get_prompt_submission_time(arg0: &RankedPrompts, arg1: u256) : u64 {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Prompt>(&arg0.prompts, arg1).submission_time
    }

    public(friend) fun get_prompt_submission_time_from_prompt(arg0: &Prompt) : u64 {
        arg0.submission_time
    }

    public(friend) fun get_prompt_target_epoch(arg0: &RankedPrompts, arg1: u256) : u64 {
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Prompt>(&arg0.prompts, arg1).target_epoch
    }

    public(friend) fun get_prompt_target_epoch_from_prompt(arg0: &Prompt) : u64 {
        arg0.target_epoch
    }

    public fun prompt_to_summary(arg0: &Prompt) : (address, u256, u64, u64, u64) {
        (arg0.creator, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg0.blob), arg0.fee_amount, arg0.submission_time, arg0.target_epoch)
    }

    public(friend) fun raise_bid(arg0: &mut RankedPrompts, arg1: u256, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u256, Prompt>(&arg0.prompts, arg1), 1);
        let v0 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<u256, Prompt>(&mut arg0.prompts, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg3), 2);
        let v1 = v0.fee_amount;
        v0.fee_amount = v1 + arg2;
        v0.boost_count = v0.boost_count + 1;
        update_fee_ranking(arg0, arg1, v1, v1 + arg2);
    }

    fun remove_from_fee_ranking(arg0: &mut RankedPrompts, arg1: u256, arg2: u64) {
        if (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u64, u256>(&arg0.last_fees, arg2)) {
            return
        };
        let v0 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::prev<u256, Prompt>(&arg0.prompts, arg1);
        let v1 = if (0x1::option::is_some<u256>(v0) && 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Prompt>(&arg0.prompts, *0x1::option::borrow<u256>(v0)).fee_amount == arg2) {
            *v0
        } else {
            0x1::option::none<u256>()
        };
        let v2 = v1;
        if (0x1::option::is_some<u256>(&v2)) {
            *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<u64, u256>(&mut arg0.last_fees, arg2) = 0x1::option::extract<u256>(&mut v2);
        } else {
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<u64, u256>(&mut arg0.last_fees, arg2);
        };
    }

    public(friend) fun remove_winner(arg0: RankedPrompts, arg1: u256) : (Prompt, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, Prompt>, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u64, u256>) {
        let RankedPrompts {
            prompts   : v0,
            last_fees : v1,
        } = arg0;
        let v2 = v0;
        (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<u256, Prompt>(&mut v2, arg1), v2, v1)
    }

    public(friend) fun remove_winner_mut(arg0: &mut RankedPrompts, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : (Prompt, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, Prompt>) {
        let v0 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<u256, Prompt>(arg2);
        while (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<u256, Prompt>(&arg0.prompts)) {
            let (v1, v2) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::pop_front<u256, Prompt>(&mut arg0.prompts);
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<u256, Prompt>(&mut v0, v1, v2);
        };
        while (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<u64, u256>(&arg0.last_fees)) {
            let (_, _) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::pop_front<u64, u256>(&mut arg0.last_fees);
        };
        (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<u256, Prompt>(&mut arg0.prompts, arg1), v0)
    }

    public fun select_winner(arg0: &mut RankedPrompts, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<u256> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<u256, Prompt>(&arg0.prompts);
        while (0x1::option::is_some<u256>(v2)) {
            let v3 = *0x1::option::borrow<u256>(v2);
            let v4 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u256, Prompt>(&arg0.prompts, v3);
            if (v4.fee_amount > v0) {
                v0 = v4.fee_amount;
                v1 = 0x1::vector::empty<u256>();
                0x1::vector::push_back<u256>(&mut v1, v3);
            } else if (v4.fee_amount == v0) {
                0x1::vector::push_back<u256>(&mut v1, v3);
            };
            v2 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<u256, Prompt>(&arg0.prompts, v3);
        };
        if (0x1::vector::is_empty<u256>(&v1)) {
            return 0x1::option::none<u256>()
        };
        let v5 = if (0x1::vector::length<u256>(&v1) == 1) {
            *0x1::vector::borrow<u256>(&v1, 0)
        } else {
            let v6 = 0x2::random::new_generator(arg1, arg2);
            *0x1::vector::borrow<u256>(&v1, 0x2::random::generate_u64_in_range(&mut v6, 0, 0x1::vector::length<u256>(&v1) - 1))
        };
        0x1::option::some<u256>(v5)
    }

    public(friend) fun transfer_blob_from_prompt(arg0: Prompt, arg1: address) {
        let Prompt {
            creator         : _,
            blob            : v1,
            fee_amount      : _,
            submission_time : _,
            target_epoch    : _,
            boost_count     : _,
        } = arg0;
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v1, arg1);
    }

    fun update_fee_ranking(arg0: &mut RankedPrompts, arg1: u256, arg2: u64, arg3: u64) {
        if (arg2 > 0) {
            remove_from_fee_ranking(arg0, arg1, arg2);
        };
        if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u64, u256>(&arg0.last_fees, arg3)) {
            let v0 = *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<u64, u256>(&arg0.last_fees, arg3);
            if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<u256, Prompt>(&arg0.prompts, v0)) {
                0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::insert_after<u256, Prompt>(&mut arg0.prompts, v0, arg1, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<u256, Prompt>(&mut arg0.prompts, arg1));
                *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<u64, u256>(&mut arg0.last_fees, arg3) = arg1;
            } else {
                0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_front<u256, Prompt>(&mut arg0.prompts, arg1, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<u256, Prompt>(&mut arg0.prompts, arg1));
                *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<u64, u256>(&mut arg0.last_fees, arg3) = arg1;
            };
        } else {
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_front<u256, Prompt>(&mut arg0.prompts, arg1, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<u256, Prompt>(&mut arg0.prompts, arg1));
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_front<u64, u256>(&mut arg0.last_fees, arg3, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

