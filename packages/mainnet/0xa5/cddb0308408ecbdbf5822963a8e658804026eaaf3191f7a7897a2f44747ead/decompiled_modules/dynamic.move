module 0xa5cddb0308408ecbdbf5822963a8e658804026eaaf3191f7a7897a2f44747ead::dynamic {
    struct Profile has key {
        id: 0x2::object::UID,
        handle: 0x1::string::String,
        points: u64,
        last_time: u64,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        admin: address,
        balance: 0x2::bag::Bag,
    }

    entry fun add<T0>(arg0: &mut Profile, arg1: 0x2::coin::Coin<T0>, arg2: &mut Vault, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 > arg0.last_time + 60000, 0);
        let v1 = false;
        let v2 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg2.balance, v2)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.balance, v2, 0x2::balance::zero<T0>());
            v1 = true;
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.balance, v2), 0x2::coin::into_balance<T0>(arg1));
        let v3 = if (v1) {
            arg0.points + 2 * 0x2::coin::value<T0>(&arg1)
        } else {
            arg0.points + 0x2::coin::value<T0>(&arg1)
        };
        arg0.points = v3;
        arg0.last_time = v0;
    }

    entry fun burn(arg0: Profile) {
        let Profile {
            id        : v0,
            handle    : _,
            points    : _,
            last_time : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun collect<T0>(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, 0x1::type_name::get<T0>()), 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balance, 0x1::type_name::get<T0>())), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            balance : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<Vault>(v0);
    }

    public fun last_time(arg0: &Profile) : u64 {
        arg0.last_time
    }

    entry fun mint(arg0: 0x1::string::String, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Profile{
            id        : 0x2::object::new(arg2),
            handle    : arg0,
            points    : 10000,
            last_time : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::transfer::transfer<Profile>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun points(arg0: &Profile) : u64 {
        arg0.points
    }

    // decompiled from Move bytecode v6
}

