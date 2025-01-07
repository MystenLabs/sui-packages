module 0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::suifund {
    struct SUIFUND has drop {
        dummy_field: bool,
    }

    struct DeployRecord has key {
        id: 0x2::object::UID,
        version: u64,
        record: 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>,
        categorys: 0x2::table::Table<0x1::ascii::String, 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        base_fee: u64,
        ratio: u64,
    }

    struct ProjectRecord has key {
        id: 0x2::object::UID,
        version: u64,
        creator: address,
        name: 0x1::ascii::String,
        description: 0x1::string::String,
        category: 0x1::ascii::String,
        image_url: 0x2::url::Url,
        linktree: 0x2::url::Url,
        x: 0x2::url::Url,
        telegram: 0x2::url::Url,
        discord: 0x2::url::Url,
        website: 0x2::url::Url,
        github: 0x2::url::Url,
        cancel: bool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        ratio: u64,
        start_time_ms: u64,
        end_time_ms: u64,
        total_supply: u64,
        amount_per_sui: u64,
        remain: u64,
        current_supply: u64,
        total_transactions: u64,
        threshold_ratio: u64,
        begin: bool,
        min_value_sui: u64,
        max_value_sui: u64,
        participants: 0x2::table_vec::TableVec<address>,
        minted_per_user: 0x2::table::Table<address, u64>,
        thread: 0x2::table_vec::TableVec<0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::comment::Comment>,
    }

    struct ProjectAdminCap has store, key {
        id: 0x2::object::UID,
        to: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SupporterReward has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        project_id: 0x2::object::ID,
        image: 0x2::url::Url,
        amount: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        start: u64,
        end: u64,
        attach_df: u8,
    }

    struct DeployEvent has copy, drop {
        project_id: 0x2::object::ID,
        project_name: 0x1::ascii::String,
        deployer: address,
        deploy_fee: u64,
    }

    struct EditProject has copy, drop {
        project_name: 0x1::ascii::String,
        editor: address,
    }

    struct MintEvent has copy, drop {
        project_name: 0x1::ascii::String,
        project_id: 0x2::object::ID,
        sender: address,
        amount: u64,
    }

    struct BurnEvent has copy, drop {
        project_name: 0x1::ascii::String,
        project_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        withdraw_value: u64,
        inside_value: u64,
    }

    struct ReferenceReward has copy, drop {
        sender: address,
        recipient: address,
        value: u64,
        project: 0x2::object::ID,
    }

    struct ClaimStreamPayment has copy, drop {
        project_name: 0x1::ascii::String,
        sender: address,
        value: u64,
    }

    struct CancelProjectEvent has copy, drop {
        project_name: 0x1::ascii::String,
        project_id: 0x2::object::ID,
        sender: address,
    }

    public entry fun split(arg0: &mut SupporterReward, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = do_split(arg0, arg1, arg2);
        0x2::transfer::public_transfer<SupporterReward>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun claim(arg0: &mut ProjectRecord, arg1: &ProjectAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = do_claim(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun like_comment(arg0: &mut ProjectRecord, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::comment::like_comment(0x2::table_vec::borrow_mut<0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::comment::Comment>(&mut arg0.thread, arg1), arg2);
    }

    public entry fun unlike_comment(arg0: &mut ProjectRecord, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::comment::unlike_comment(0x2::table_vec::borrow_mut<0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::comment::Comment>(&mut arg0.thread, arg1), arg2);
    }

    public entry fun add_comment(arg0: &mut ProjectRecord, arg1: 0x1::option::Option<0x2::object::ID>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::table_vec::push_back<0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::comment::Comment>(&mut arg0.thread, 0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::comment::new_comment(arg1, arg2, arg3, arg4, arg5));
    }

    public(friend) fun add_df_in_project<T0: copy + drop + store, T1: store>(arg0: &mut ProjectRecord, arg1: T0, arg2: T1) {
        assert!(arg0.version == 1, 16);
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    fun add_df_with_attach<T0: store>(arg0: &mut SupporterReward, arg1: T0) {
        assert!(arg0.attach_df == 0, 9223376787088605183);
        arg0.attach_df = arg0.attach_df + 1;
        0x2::dynamic_field::add<0x1::ascii::String, T0>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()), arg1);
    }

    public(friend) fun borrow_in_project<T0: copy + drop + store, T1: store>(arg0: &ProjectRecord, arg1: T0) : &T1 {
        assert!(arg0.version == 1, 16);
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun borrow_mut_in_project<T0: copy + drop + store, T1: store>(arg0: &mut ProjectRecord, arg1: T0) : &mut T1 {
        assert!(arg0.version == 1, 16);
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public entry fun burn(arg0: &mut ProjectRecord, arg1: SupporterReward, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = do_burn(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun burn_project_admin_cap(arg0: &mut ProjectRecord, arg1: ProjectAdminCap) {
        check_project_cap(arg0, &arg1);
        assert!(arg0.cancel, 23);
        let ProjectAdminCap {
            id : v0,
            to : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun cancel_project(arg0: &mut DeployRecord, arg1: &mut ProjectRecord, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg1.begin, 22);
        arg1.cancel = true;
        if (0x1::ascii::length(&arg1.category) > 0) {
            let v0 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>>(&mut arg0.categorys, arg1.category);
            0x2::table::remove<0x1::ascii::String, 0x2::object::ID>(v0, arg1.name);
            if (0x2::table::is_empty<0x1::ascii::String, 0x2::object::ID>(v0)) {
                0x2::table::destroy_empty<0x1::ascii::String, 0x2::object::ID>(0x2::table::remove<0x1::ascii::String, 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>>(&mut arg0.categorys, arg1.category));
            };
        };
        let v1 = CancelProjectEvent{
            project_name : arg1.name,
            project_id   : 0x2::table::remove<0x1::ascii::String, 0x2::object::ID>(&mut arg0.record, arg1.name),
            sender       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CancelProjectEvent>(v1);
    }

    public fun cancel_project_by_admin(arg0: &AdminCap, arg1: &mut DeployRecord, arg2: &mut ProjectRecord, arg3: &0x2::tx_context::TxContext) {
        cancel_project(arg1, arg2, arg3);
    }

    public fun cancel_project_by_team(arg0: &ProjectAdminCap, arg1: &mut DeployRecord, arg2: &mut ProjectRecord, arg3: &0x2::tx_context::TxContext) {
        check_project_cap(arg2, arg0);
        cancel_project(arg1, arg2, arg3);
    }

    public fun check_project_cap(arg0: &ProjectRecord, arg1: &ProjectAdminCap) {
        assert!(0x2::object::id<ProjectRecord>(arg0) == arg1.to, 8);
    }

    public entry fun deploy(arg0: &mut DeployRecord, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        let v0 = deploy_non_entry(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21);
        0x2::transfer::public_transfer<ProjectAdminCap>(v0, 0x2::tx_context::sender(arg21));
    }

    public fun deploy_non_entry(arg0: &mut DeployRecord, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : ProjectAdminCap {
        assert!(arg0.version == 1, 16);
        let v0 = 0x2::tx_context::sender(arg21);
        assert!(arg11 >= 0x2::clock::timestamp_ms(arg20), 1);
        assert!(arg12 >= 259200000, 2);
        assert!(arg14 <= 100, 3);
        assert!(arg16 <= 100, 20);
        assert!(arg17 >= 1000000000, 5);
        assert!(arg15 >= 1, 5);
        if (arg18 != 0) {
            assert!(arg17 <= arg18, 4);
        };
        let v1 = get_deploy_fee(arg13, arg0.base_fee, arg14, arg0.ratio);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg19, v1, arg21)));
        let v2 = 0x1::ascii::string(arg3);
        let v3 = arg13 / 1000000000 * arg15;
        let v4 = 0x1::ascii::string(arg1);
        let v5 = ProjectRecord{
            id                 : 0x2::object::new(arg21),
            version            : 1,
            creator            : v0,
            name               : v4,
            description        : 0x1::string::utf8(arg2),
            category           : v2,
            image_url          : 0x2::url::new_unsafe_from_bytes(arg4),
            linktree           : 0x2::url::new_unsafe_from_bytes(arg5),
            x                  : 0x2::url::new_unsafe_from_bytes(arg6),
            telegram           : 0x2::url::new_unsafe_from_bytes(arg7),
            discord            : 0x2::url::new_unsafe_from_bytes(arg8),
            website            : 0x2::url::new_unsafe_from_bytes(arg9),
            github             : 0x2::url::new_unsafe_from_bytes(arg10),
            cancel             : false,
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            ratio              : arg14,
            start_time_ms      : arg11,
            end_time_ms        : arg11 + arg12,
            total_supply       : v3,
            amount_per_sui     : arg15,
            remain             : v3,
            current_supply     : 0,
            total_transactions : 0,
            threshold_ratio    : arg16,
            begin              : false,
            min_value_sui      : arg17,
            max_value_sui      : arg18,
            participants       : 0x2::table_vec::empty<address>(arg21),
            minted_per_user    : 0x2::table::new<address, u64>(arg21),
            thread             : 0x2::table_vec::empty<0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::comment::Comment>(arg21),
        };
        let v6 = 0x2::object::id<ProjectRecord>(&v5);
        let v7 = ProjectAdminCap{
            id : 0x2::object::new(arg21),
            to : v6,
        };
        0x2::table::add<0x1::ascii::String, 0x2::object::ID>(&mut arg0.record, v4, v6);
        if (0x1::ascii::length(&v2) > 0) {
            if (0x2::table::contains<0x1::ascii::String, 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>>(&arg0.categorys, v2)) {
                0x2::table::add<0x1::ascii::String, 0x2::object::ID>(0x2::table::borrow_mut<0x1::ascii::String, 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>>(&mut arg0.categorys, v2), v4, v6);
            } else {
                let v8 = 0x2::table::new<0x1::ascii::String, 0x2::object::ID>(arg21);
                0x2::table::add<0x1::ascii::String, 0x2::object::ID>(&mut v8, v4, v6);
                0x2::table::add<0x1::ascii::String, 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>>(&mut arg0.categorys, v2, v8);
            };
        };
        0x2::transfer::share_object<ProjectRecord>(v5);
        let v9 = DeployEvent{
            project_id   : v6,
            project_name : v4,
            deployer     : v0,
            deploy_fee   : v1,
        };
        0x2::event::emit<DeployEvent>(v9);
        v7
    }

    public fun do_burn(arg0: &mut ProjectRecord, arg1: SupporterReward, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::object::id<ProjectRecord>(arg0) == arg1.project_id, 10);
        assert!(arg0.version == 1, 16);
        assert!(arg1.attach_df == 0, 15);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (arg0.cancel || !arg0.begin) {
            0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
        } else {
            0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::utils::get_remain_value(0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::utils::mul_div(arg0.current_supply, 1000000000, arg0.amount_per_sui), arg0.start_time_ms, arg0.end_time_ms, 0x2::clock::timestamp_ms(arg2)) * arg0.ratio / 100
        };
        let v2 = 0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::utils::mul_div(v1, arg1.amount, arg0.current_supply);
        arg0.current_supply = arg0.current_supply - arg1.amount;
        arg0.remain = arg0.remain + arg1.amount;
        let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.minted_per_user, v0);
        if (*v3 >= arg1.amount) {
            *v3 = *v3 - arg1.amount;
        };
        let SupporterReward {
            id         : v4,
            name       : v5,
            project_id : v6,
            image      : _,
            amount     : v8,
            balance    : v9,
            start      : _,
            end        : _,
            attach_df  : _,
        } = arg1;
        let v13 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v2), arg3);
        0x2::coin::join<0x2::sui::SUI>(&mut v13, 0x2::coin::from_balance<0x2::sui::SUI>(v9, arg3));
        0x2::object::delete(v4);
        let v14 = BurnEvent{
            project_name   : v5,
            project_id     : v6,
            sender         : v0,
            amount         : v8,
            withdraw_value : v2,
            inside_value   : 0x2::balance::value<0x2::sui::SUI>(&arg1.balance),
        };
        0x2::event::emit<BurnEvent>(v14);
        v13
    }

    public fun do_claim(arg0: &mut ProjectRecord, arg1: &ProjectAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.version == 1, 16);
        assert!(arg0.begin, 21);
        check_project_cap(arg0, arg1);
        assert!(!arg0.cancel, 14);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) - 0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::utils::get_remain_value(0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::utils::mul_div(arg0.current_supply, 1000000000, arg0.amount_per_sui) * arg0.ratio / 100, arg0.start_time_ms, arg0.end_time_ms, 0x2::clock::timestamp_ms(arg2));
        let v1 = ClaimStreamPayment{
            project_name : arg0.name,
            sender       : 0x2::tx_context::sender(arg3),
            value        : v0,
        };
        0x2::event::emit<ClaimStreamPayment>(v1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg3)
    }

    public fun do_merge(arg0: &mut SupporterReward, arg1: SupporterReward) {
        assert!(arg0.name == arg1.name, 10);
        assert!(arg1.attach_df == 0, 11);
        let SupporterReward {
            id         : v0,
            name       : _,
            project_id : _,
            image      : _,
            amount     : v4,
            balance    : v5,
            start      : _,
            end        : _,
            attach_df  : _,
        } = arg1;
        arg0.amount = arg0.amount + v4;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, v5);
        0x2::object::delete(v0);
    }

    public fun do_mint(arg0: &mut ProjectRecord, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : SupporterReward {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.start_time_ms, 6);
        assert!(arg0.version == 1, 16);
        assert!(!arg0.cancel, 14);
        assert!(arg0.remain > 0, 24);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(arg1);
        let v2 = v1;
        assert!(v1 >= arg0.min_value_sui, 5);
        if (0x2::table::contains<address, u64>(&arg0.minted_per_user, v0)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.minted_per_user, v0);
            if (arg0.max_value_sui > 0 && v1 + *v3 > arg0.max_value_sui) {
                v2 = arg0.max_value_sui - *v3;
            };
            assert!(v2 > 0, 9);
            *v3 = *v3 + v2;
        } else {
            if (arg0.max_value_sui > 0 && v1 > arg0.max_value_sui) {
                v2 = arg0.max_value_sui;
            };
            0x2::table::add<address, u64>(&mut arg0.minted_per_user, v0, v2);
            0x2::table_vec::push_back<address>(&mut arg0.participants, v0);
        };
        let v4 = 0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::utils::mul_div(v2, arg0.amount_per_sui, 1000000000);
        let v5 = v4;
        if (v4 >= arg0.remain) {
            let v6 = arg0.remain;
            v5 = v6;
            v2 = 0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::utils::mul_div(v6, 1000000000, arg0.amount_per_sui);
        };
        arg0.remain = arg0.remain - v5;
        arg0.current_supply = arg0.current_supply + v5;
        arg0.total_transactions = arg0.total_transactions + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, v2 * arg0.ratio / 100, arg3)));
        if (!arg0.begin && arg0.current_supply >= 0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::utils::mul_div(arg0.total_supply, arg0.threshold_ratio, 100)) {
            arg0.begin = true;
        };
        let v7 = 0x2::object::id<ProjectRecord>(arg0);
        let v8 = MintEvent{
            project_name : arg0.name,
            project_id   : v7,
            sender       : v0,
            amount       : v5,
        };
        0x2::event::emit<MintEvent>(v8);
        let v9 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, v2 * (100 - arg0.ratio) / 100, arg3));
        new_supporter_reward(arg0.name, v7, arg0.image_url, v5, v9, arg0.start_time_ms, arg0.end_time_ms, arg3)
    }

    public fun do_split(arg0: &mut SupporterReward, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SupporterReward {
        assert!(0 < arg1 && arg1 < arg0.amount, 12);
        assert!(is_splitable(arg0), 13);
        let v0 = 0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::utils::mul_div(0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg1, arg0.amount);
        let v1 = v0;
        if (v0 == 0) {
            v1 = 1;
        };
        arg0.amount = arg0.amount - arg1;
        new_supporter_reward(arg0.name, arg0.project_id, arg0.image, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v1), arg0.start, arg0.end, arg2)
    }

    public entry fun edit_description(arg0: &mut ProjectRecord, arg1: &ProjectAdminCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        check_project_cap(arg0, arg1);
        arg0.description = 0x1::string::utf8(arg2);
        let v0 = EditProject{
            project_name : arg0.name,
            editor       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EditProject>(v0);
    }

    public entry fun edit_discord_url(arg0: &mut ProjectRecord, arg1: &ProjectAdminCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        check_project_cap(arg0, arg1);
        arg0.discord = 0x2::url::new_unsafe_from_bytes(arg2);
        let v0 = EditProject{
            project_name : arg0.name,
            editor       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EditProject>(v0);
    }

    public entry fun edit_github_url(arg0: &mut ProjectRecord, arg1: &ProjectAdminCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        check_project_cap(arg0, arg1);
        arg0.github = 0x2::url::new_unsafe_from_bytes(arg2);
        let v0 = EditProject{
            project_name : arg0.name,
            editor       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EditProject>(v0);
    }

    public entry fun edit_image_url(arg0: &mut ProjectRecord, arg1: &ProjectAdminCap, arg2: vector<u8>, arg3: &mut DeployRecord, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        check_project_cap(arg0, arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg4, 1000000000 / 10, arg5)));
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(arg2);
        let v0 = EditProject{
            project_name : arg0.name,
            editor       : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<EditProject>(v0);
    }

    public entry fun edit_linktree_url(arg0: &mut ProjectRecord, arg1: &ProjectAdminCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        check_project_cap(arg0, arg1);
        arg0.linktree = 0x2::url::new_unsafe_from_bytes(arg2);
        let v0 = EditProject{
            project_name : arg0.name,
            editor       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EditProject>(v0);
    }

    public entry fun edit_telegram_url(arg0: &mut ProjectRecord, arg1: &ProjectAdminCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        check_project_cap(arg0, arg1);
        arg0.telegram = 0x2::url::new_unsafe_from_bytes(arg2);
        let v0 = EditProject{
            project_name : arg0.name,
            editor       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EditProject>(v0);
    }

    public entry fun edit_website_url(arg0: &mut ProjectRecord, arg1: &ProjectAdminCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        check_project_cap(arg0, arg1);
        arg0.website = 0x2::url::new_unsafe_from_bytes(arg2);
        let v0 = EditProject{
            project_name : arg0.name,
            editor       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EditProject>(v0);
    }

    public entry fun edit_x_url(arg0: &mut ProjectRecord, arg1: &ProjectAdminCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        check_project_cap(arg0, arg1);
        arg0.x = 0x2::url::new_unsafe_from_bytes(arg2);
        let v0 = EditProject{
            project_name : arg0.name,
            editor       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EditProject>(v0);
    }

    fun exists_df<T0: store>(arg0: &SupporterReward) : bool {
        0x2::dynamic_field::exists_with_type<0x1::ascii::String, T0>(&arg0.id, 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()))
    }

    public(friend) fun exists_in_project<T0: copy + drop + store>(arg0: &ProjectRecord, arg1: T0) : bool {
        assert!(arg0.version == 1, 16);
        0x2::dynamic_field::exists_<T0>(&arg0.id, arg1)
    }

    public fun get_deploy_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg3 <= 5, 17);
        let v0 = 0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::utils::mul_div(0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::utils::mul_div(arg0, arg2, 100), arg3, 100);
        if (v0 > arg1) {
            v0
        } else {
            arg1
        }
    }

    fun init(arg0: SUIFUND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = DeployRecord{
            id        : 0x2::object::new(arg1),
            version   : 1,
            record    : 0x2::table::new<0x1::ascii::String, 0x2::object::ID>(arg1),
            categorys : 0x2::table::new<0x1::ascii::String, 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>>(arg1),
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            base_fee  : 20000000000,
            ratio     : 1,
        };
        0x2::transfer::share_object<DeployRecord>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, v0);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"market_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"coinswap_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"start"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"end"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"alert"));
        let v5 = b"https://pumpsuiapi.com/objectId/";
        0x1::vector::append<u8>(&mut v5, b"{id}");
        let v6 = b"https://pumpsui.com/project/";
        0x1::vector::append<u8>(&mut v6, b"{project_id}");
        let v7 = b"https://pumpsui.com/market/";
        0x1::vector::append<u8>(&mut v7, b"{project_id}");
        let v8 = b"https://pumpsui.com/coinswap/";
        0x1::vector::append<u8>(&mut v8, b"{project_id}");
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Supporter Ticket"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(v5));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(v6));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(v7));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(v8));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{start}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{end}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"!!!Do not visit any links in the pictures, as they may be SCAMs."));
        let v11 = 0x2::package::claim<SUIFUND>(arg0, arg1);
        let v12 = 0x2::display::new_with_fields<SupporterReward>(&v11, v3, v9, arg1);
        0x2::display::update_version<SupporterReward>(&mut v12);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v11, v0);
        0x2::transfer::public_transfer<0x2::display::Display<SupporterReward>>(v12, v0);
    }

    public fun is_splitable(arg0: &SupporterReward) : bool {
        arg0.amount > 1 && arg0.attach_df == 0
    }

    public entry fun merge(arg0: &mut SupporterReward, arg1: SupporterReward) {
        do_merge(arg0, arg1);
    }

    public entry fun mint(arg0: &mut ProjectRecord, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = do_mint(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<SupporterReward>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun native_stake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: address, arg2: &mut SupporterReward, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3::sui_system::request_add_stake_non_entry(arg0, 0x2::coin::take<0x2::sui::SUI>(&mut arg2.balance, 0x2::balance::value<0x2::sui::SUI>(&arg2.balance), arg3), arg1, arg3);
        add_df_with_attach<0x3::staking_pool::StakedSui>(arg2, v0);
    }

    public entry fun native_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut SupporterReward, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = remove_df_with_attach<0x3::staking_pool::StakedSui>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x3::sui_system::request_withdraw_stake_non_entry(arg0, v0, arg2));
    }

    fun new_supporter_reward(arg0: 0x1::ascii::String, arg1: 0x2::object::ID, arg2: 0x2::url::Url, arg3: u64, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : SupporterReward {
        SupporterReward{
            id         : 0x2::object::new(arg7),
            name       : arg0,
            project_id : arg1,
            image      : arg2,
            amount     : arg3,
            balance    : arg4,
            start      : arg5,
            end        : arg6,
            attach_df  : 0,
        }
    }

    public fun project_admin_cap_to(arg0: &ProjectAdminCap) : 0x2::object::ID {
        arg0.to
    }

    public fun project_amount_per_sui(arg0: &ProjectRecord) : u64 {
        arg0.amount_per_sui
    }

    public fun project_balance_value(arg0: &ProjectRecord) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun project_begin_status(arg0: &ProjectRecord) : bool {
        arg0.begin
    }

    public fun project_current_supply(arg0: &ProjectRecord) : u64 {
        arg0.current_supply
    }

    public fun project_description(arg0: &ProjectRecord) : 0x1::string::String {
        arg0.description
    }

    public fun project_discord_url(arg0: &ProjectRecord) : 0x2::url::Url {
        arg0.discord
    }

    public fun project_end_time_ms(arg0: &ProjectRecord) : u64 {
        arg0.end_time_ms
    }

    public fun project_github_url(arg0: &ProjectRecord) : 0x2::url::Url {
        arg0.github
    }

    public fun project_image_url(arg0: &ProjectRecord) : 0x2::url::Url {
        arg0.image_url
    }

    public fun project_linktree_url(arg0: &ProjectRecord) : 0x2::url::Url {
        arg0.linktree
    }

    public fun project_max_value_sui(arg0: &ProjectRecord) : u64 {
        arg0.max_value_sui
    }

    public fun project_min_value_sui(arg0: &ProjectRecord) : u64 {
        arg0.min_value_sui
    }

    public fun project_minted_per_user(arg0: &ProjectRecord) : &0x2::table::Table<address, u64> {
        &arg0.minted_per_user
    }

    public fun project_name(arg0: &ProjectRecord) : 0x1::ascii::String {
        arg0.name
    }

    public fun project_participants(arg0: &ProjectRecord) : &0x2::table_vec::TableVec<address> {
        &arg0.participants
    }

    public fun project_participants_number(arg0: &ProjectRecord) : u64 {
        0x2::table_vec::length<address>(&arg0.participants)
    }

    public fun project_ratio(arg0: &ProjectRecord) : u64 {
        arg0.ratio
    }

    public fun project_remain(arg0: &ProjectRecord) : u64 {
        arg0.remain
    }

    public fun project_start_time_ms(arg0: &ProjectRecord) : u64 {
        arg0.start_time_ms
    }

    public fun project_telegram_url(arg0: &ProjectRecord) : 0x2::url::Url {
        arg0.telegram
    }

    public fun project_thread(arg0: &ProjectRecord) : &0x2::table_vec::TableVec<0x6523f167f7af39a785e1e859c79bc90ac5bcd9ebf5158556cb652454052d421f::comment::Comment> {
        &arg0.thread
    }

    public fun project_threshold_ratio(arg0: &ProjectRecord) : u64 {
        arg0.threshold_ratio
    }

    public fun project_total_supply(arg0: &ProjectRecord) : u64 {
        arg0.total_supply
    }

    public fun project_total_transactions(arg0: &ProjectRecord) : u64 {
        arg0.total_transactions
    }

    public fun project_website_url(arg0: &ProjectRecord) : 0x2::url::Url {
        arg0.website
    }

    public fun project_x_url(arg0: &ProjectRecord) : 0x2::url::Url {
        arg0.x
    }

    public fun reference_reward(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: address, arg3: &ProjectRecord) {
        let v0 = ReferenceReward{
            sender    : arg1,
            recipient : arg2,
            value     : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            project   : 0x2::object::id<ProjectRecord>(arg3),
        };
        0x2::event::emit<ReferenceReward>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg2);
    }

    public(friend) fun remove_df_in_project<T0: copy + drop + store, T1: store>(arg0: &mut ProjectRecord, arg1: T0) : T1 {
        assert!(arg0.version == 1, 16);
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    fun remove_df_with_attach<T0: store>(arg0: &mut SupporterReward) : T0 {
        arg0.attach_df = arg0.attach_df - 1;
        0x2::dynamic_field::remove<0x1::ascii::String, T0>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()))
    }

    public fun set_base_fee(arg0: &AdminCap, arg1: &mut DeployRecord, arg2: u64) {
        arg1.base_fee = arg2;
    }

    public fun set_ratio(arg0: &AdminCap, arg1: &mut DeployRecord, arg2: u64) {
        assert!(arg2 <= 5, 17);
        arg1.ratio = arg2;
    }

    public fun sr_amount(arg0: &SupporterReward) : u64 {
        arg0.amount
    }

    public fun sr_attach_df_num(arg0: &SupporterReward) : u8 {
        arg0.attach_df
    }

    public fun sr_balance_value(arg0: &SupporterReward) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun sr_end_time_ms(arg0: &SupporterReward) : u64 {
        arg0.end
    }

    public fun sr_image(arg0: &SupporterReward) : 0x2::url::Url {
        arg0.image
    }

    public fun sr_name(arg0: &SupporterReward) : 0x1::ascii::String {
        arg0.name
    }

    public fun sr_project_id(arg0: &SupporterReward) : 0x2::object::ID {
        arg0.project_id
    }

    public fun sr_start_time_ms(arg0: &SupporterReward) : u64 {
        arg0.start
    }

    public fun take_remain(arg0: &AdminCap, arg1: &mut ProjectRecord, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.cancel, 18);
        assert!(arg1.current_supply == 0, 19);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun update_image(arg0: &ProjectRecord, arg1: &mut SupporterReward) {
        assert!(arg0.name == arg1.name, 10);
        arg1.image = arg0.image_url;
    }

    public fun withdraw_balance(arg0: &AdminCap, arg1: &mut DeployRecord, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

