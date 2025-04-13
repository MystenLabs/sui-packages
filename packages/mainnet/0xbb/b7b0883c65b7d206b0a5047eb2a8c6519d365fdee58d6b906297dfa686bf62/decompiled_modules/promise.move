module 0xbbb7b0883c65b7d206b0a5047eb2a8c6519d365fdee58d6b906297dfa686bf62::promise {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    struct PROMISE has drop {
        dummy_field: bool,
    }

    struct Promise has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        url: 0x1::string::String,
        createTime: u64,
        expiration: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        completed: bool,
    }

    struct EventCreatePromise has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct EventCompletePromise has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct EventWithdrawPromiseBalance has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun claim_user_promise(arg0: &Admin, arg1: &mut Promise, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.expiration < 0x2::clock::timestamp_ms(arg2), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg3), 0x2::tx_context::sender(arg3));
        let v0 = EventWithdrawPromiseBalance{object_id: 0x2::object::uid_to_inner(&arg1.id)};
        0x2::event::emit<EventWithdrawPromiseBalance>(v0);
    }

    public fun complete_user_promise(arg0: &mut Promise, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.expiration >= 0x2::clock::timestamp_ms(arg1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2), 0x2::tx_context::sender(arg2));
        arg0.completed = true;
        let v0 = EventCompletePromise{object_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<EventCompletePromise>(v0);
    }

    public fun create_user_promise(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg2), 2);
        let v0 = Promise{
            id         : 0x2::object::new(arg5),
            creator    : 0x2::tx_context::sender(arg5),
            name       : arg0,
            url        : arg1,
            createTime : 0x2::clock::timestamp_ms(arg2),
            expiration : arg3,
            balance    : 0x2::coin::into_balance<0x2::sui::SUI>(arg4),
            completed  : false,
        };
        let v1 = EventCreatePromise{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v0.creator,
            name      : v0.name,
        };
        0x2::event::emit<EventCreatePromise>(v1);
        0x2::transfer::share_object<Promise>(v0);
    }

    public fun get_promise(arg0: &Promise) : (address, 0x1::string::String, 0x1::string::String, u64, u64, u64, bool) {
        (arg0.creator, arg0.name, arg0.url, arg0.createTime, arg0.expiration, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.completed)
    }

    fun init(arg0: PROMISE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PROMISE>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<Admin>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

