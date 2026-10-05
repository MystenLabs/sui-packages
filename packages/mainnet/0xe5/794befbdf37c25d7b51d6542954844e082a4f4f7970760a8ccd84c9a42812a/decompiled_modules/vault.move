module 0xe5794befbdf37c25d7b51d6542954844e082a4f4f7970760a8ccd84c9a42812a::vault {
    struct Vault<T0: store + key> has key {
        id: 0x2::object::UID,
        owner: address,
        pool_id: 0x2::object::ID,
        generation: u64,
        item: 0x1::option::Option<T0>,
    }

    struct Deposited has copy, drop {
        vault: 0x2::object::ID,
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        generation: u64,
    }

    struct Taken has copy, drop {
        vault: 0x2::object::ID,
        position: 0x2::object::ID,
        generation: u64,
    }

    fun new<T0: store + key>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        Vault<T0>{
            id         : 0x2::object::new(arg1),
            owner      : 0x2::tx_context::sender(arg1),
            pool_id    : arg0,
            generation : 0,
            item       : 0x1::option::none<T0>(),
        }
    }

    fun assert_owner<T0: store + key>(arg0: &Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
    }

    public fun create<T0: store + key>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Vault<T0>>(new<T0>(arg0, arg1));
    }

    public fun deposit<T0: store + key>(arg0: &mut Vault<T0>, arg1: T0, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg3);
        assert!(0x1::option::is_none<T0>(&arg0.item), 2);
        assert!(arg2 == arg0.generation + 1, 3);
        arg0.generation = arg2;
        let v0 = Deposited{
            vault      : 0x2::object::id<Vault<T0>>(arg0),
            pool       : arg0.pool_id,
            position   : 0x2::object::id<T0>(&arg1),
            generation : arg2,
        };
        0x2::event::emit<Deposited>(v0);
        0x1::option::fill<T0>(&mut arg0.item, arg1);
    }

    public fun take<T0: store + key>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) : T0 {
        assert_owner<T0>(arg0, arg2);
        assert!(arg0.generation == arg1, 3);
        assert!(0x1::option::is_some<T0>(&arg0.item), 1);
        let v0 = 0x1::option::extract<T0>(&mut arg0.item);
        let v1 = Taken{
            vault      : 0x2::object::id<Vault<T0>>(arg0),
            position   : 0x2::object::id<T0>(&v0),
            generation : arg1,
        };
        0x2::event::emit<Taken>(v1);
        v0
    }

    public fun take_by_id<T0: store + key>(arg0: &mut Vault<T0>, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : T0 {
        let v0 = take<T0>(arg0, arg1, arg3);
        assert!(0x2::object::id<T0>(&v0) == arg2, 4);
        v0
    }

    public fun withdraw<T0: store + key>(arg0: &mut Vault<T0>, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = take_by_id<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<T0>(v0, arg0.owner);
    }

    // decompiled from Move bytecode v7
}

