module 0x23d8d3b24faf32539dab874b4240cd6ac9b4ae1a30234872863ab275738480b9::locker {
    struct LOCKER has drop {
        dummy_field: bool,
    }

    struct Lock<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        logo_url: 0x2::url::Url,
        owner: address,
        token_address: 0x1::string::String,
        decimals: u64,
        amount: u64,
        balance: 0x2::balance::Balance<T0>,
        unlock_time: u64,
        is_claim: bool,
    }

    struct LockItem has store, key {
        id: 0x2::object::UID,
        lock_id: 0x2::object::ID,
    }

    struct Locks has store, key {
        id: 0x2::object::UID,
        lock_tab: 0x2::object_table::ObjectTable<0x2::object::ID, LockItem>,
    }

    struct CreateLockerEvent has copy, drop {
        creator: address,
        amount: u64,
        create_time: u64,
        coin_type_info: 0x1::string::String,
    }

    struct ClaimEvent has copy, drop {
        recipient: address,
        amount: u64,
        claimed_time: u64,
    }

    public entry fun add_coins_toLocker<T0>(arg0: &mut Lock<T0>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        assert!(0x2::coin::value<T0>(&v0) >= arg2, 5);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg2, arg3)));
        arg0.amount = arg0.amount + arg2;
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    public entry fun claim<T0>(arg0: &mut Lock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_claim, 3);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_time, 2);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v0, arg2), arg0.owner);
        arg0.is_claim = true;
        let v1 = ClaimEvent{
            recipient    : arg0.owner,
            amount       : v0,
            claimed_time : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ClaimEvent>(v1);
    }

    public entry fun create_locked_coins<T0>(arg0: &mut Locks, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<0x2::coin::Coin<T0>>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0x2::clock::timestamp_ms(arg1), 4);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg7);
        0x2::pay::join_vec<T0>(&mut v0, arg7);
        assert!(0x2::coin::value<T0>(&v0) >= arg8, 5);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = 0x2::object::new(arg9);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = Lock<T0>{
            id            : v2,
            name          : 0x1::string::utf8(arg2),
            logo_url      : 0x2::url::new_unsafe_from_bytes(arg3),
            owner         : v1,
            token_address : 0x1::string::utf8(arg4),
            decimals      : arg5,
            amount        : arg8,
            balance       : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg8, arg9)),
            unlock_time   : arg6,
            is_claim      : false,
        };
        0x2::transfer::transfer<Lock<T0>>(v4, v1);
        let v5 = LockItem{
            id      : 0x2::object::new(arg9),
            lock_id : v3,
        };
        0x2::object_table::add<0x2::object::ID, LockItem>(&mut arg0.lock_tab, v3, v5);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        let v6 = CreateLockerEvent{
            creator        : v1,
            amount         : arg8,
            create_time    : 0x2::clock::timestamp_ms(arg1),
            coin_type_info : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<CreateLockerEvent>(v6);
    }

    fun init(arg0: LOCKER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LOCKER>(arg0, arg1);
        let v0 = Locks{
            id       : 0x2::object::new(arg1),
            lock_tab : 0x2::object_table::new<0x2::object::ID, LockItem>(arg1),
        };
        0x2::transfer::share_object<Locks>(v0);
    }

    public entry fun update_name<T0>(arg0: &mut Lock<T0>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.name = arg1;
    }

    public entry fun update_time<T0>(arg0: &mut Lock<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > arg0.unlock_time, 4);
        arg0.unlock_time = arg1;
    }

    // decompiled from Move bytecode v6
}

