module 0xf13a55a3e4a8c23c6bd557a613bb3815e2b3b1b5fa909b6659bd8750293171f4::ruok {
    struct UserStatus has key {
        id: 0x2::object::UID,
        owner: address,
        last_check_in_ms: u64,
        timeout_threshold_ms: u64,
        encrypted_message: 0x1::string::String,
        transfer_recipient: address,
        stored_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        user_status_ids: vector<0x2::object::ID>,
    }

    public fun add_funds(arg0: &mut UserStatus, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.stored_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun check_in(arg0: &mut UserStatus, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.last_check_in_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun create_user_status(arg0: u64, arg1: 0x1::string::String, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut Registry, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 10000, 3);
        let v0 = UserStatus{
            id                   : 0x2::object::new(arg6),
            owner                : 0x2::tx_context::sender(arg6),
            last_check_in_ms     : 0x2::clock::timestamp_ms(arg4),
            timeout_threshold_ms : arg0,
            encrypted_message    : arg1,
            transfer_recipient   : arg2,
            stored_balance       : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg5.user_status_ids, 0x2::object::id<UserStatus>(&v0));
        0x2::transfer::share_object<UserStatus>(v0);
    }

    public fun get_all_user_status_ids(arg0: &Registry) : vector<0x2::object::ID> {
        arg0.user_status_ids
    }

    public fun get_user_status(arg0: &UserStatus) : (address, u64, u64, 0x1::string::String, address, u64) {
        (arg0.owner, arg0.last_check_in_ms, arg0.timeout_threshold_ms, arg0.encrypted_message, arg0.transfer_recipient, 0x2::balance::value<0x2::sui::SUI>(&arg0.stored_balance))
    }

    public fun get_user_status_count(arg0: &Registry) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.user_status_ids)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id              : 0x2::object::new(arg0),
            user_status_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun trigger(arg0: UserStatus, arg1: &mut Registry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) - arg0.last_check_in_ms >= arg0.timeout_threshold_ms, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.stored_balance);
        assert!(v0 > 0, 2);
        let v1 = v0 / 1000;
        let v2 = 0x2::object::id<UserStatus>(&arg0);
        let (v3, v4) = 0x1::vector::index_of<0x2::object::ID>(&arg1.user_status_ids, &v2);
        if (v3) {
            0x1::vector::remove<0x2::object::ID>(&mut arg1.user_status_ids, v4);
        };
        let UserStatus {
            id                   : v5,
            owner                : _,
            last_check_in_ms     : _,
            timeout_threshold_ms : _,
            encrypted_message    : _,
            transfer_recipient   : v10,
            stored_balance       : v11,
        } = arg0;
        let v12 = v11;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v12, v0 - v1 - v0 / 1000), arg3), v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v12, v1), arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v12), arg3), @0xd73a6dc9ff5222aed93d45049767837030c74cba9835d8796c7acd311c12e0e2);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v12);
        0x2::object::delete(v5);
    }

    public fun update_settings(arg0: &mut UserStatus, arg1: u64, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 0);
        arg0.timeout_threshold_ms = arg1;
        arg0.encrypted_message = arg2;
        arg0.transfer_recipient = arg3;
    }

    // decompiled from Move bytecode v6
}

