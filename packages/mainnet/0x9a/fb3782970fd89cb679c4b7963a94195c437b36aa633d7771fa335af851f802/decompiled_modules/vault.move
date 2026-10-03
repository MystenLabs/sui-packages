module 0x9afb3782970fd89cb679c4b7963a94195c437b36aa633d7771fa335af851f802::vault {
    struct Vault<T0: store + key> has key {
        id: 0x2::object::UID,
        owner: address,
        items: vector<T0>,
    }

    public fun length<T0: store + key>(arg0: &Vault<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.items)
    }

    fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : Vault<T0> {
        Vault<T0>{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            items : 0x1::vector::empty<T0>(),
        }
    }

    fun assert_owner<T0: store + key>(arg0: &Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
    }

    public fun contains<T0: store + key>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = &arg0.items;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<T0>(v0)) {
            if (0x2::object::id<T0>(0x1::vector::borrow<T0>(v0, v1)) == arg1) {
                v2 = true;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = false;
        v2
    }

    public fun create<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Vault<T0>>(new<T0>(arg0));
    }

    public fun deposit<T0: store + key>(arg0: &mut Vault<T0>, arg1: T0, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg2);
        0x1::vector::push_back<T0>(&mut arg0.items, arg1);
    }

    public fun ids<T0: store + key>(arg0: &Vault<T0>) : vector<0x2::object::ID> {
        let v0 = &arg0.items;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<T0>(v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<T0>(0x1::vector::borrow<T0>(v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    fun index_of<T0: store + key>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(&arg0.items)) {
            if (0x2::object::id<T0>(0x1::vector::borrow<T0>(&arg0.items, v0)) == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 2
    }

    public fun owner<T0: store + key>(arg0: &Vault<T0>) : address {
        arg0.owner
    }

    public fun take<T0: store + key>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : T0 {
        assert_owner<T0>(arg0, arg2);
        0x1::vector::remove<T0>(&mut arg0.items, index_of<T0>(arg0, arg1))
    }

    public fun take_latest<T0: store + key>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) : T0 {
        assert_owner<T0>(arg0, arg1);
        assert!(!0x1::vector::is_empty<T0>(&arg0.items), 1);
        0x1::vector::pop_back<T0>(&mut arg0.items)
    }

    public fun withdraw<T0: store + key>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let v0 = arg0.owner;
        0x2::transfer::public_transfer<T0>(take<T0>(arg0, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v7
}

