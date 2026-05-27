module 0xbf3f31ec0d1f23c73e924450b9e47099954f7e825187525a79238be15188a01c::registry {
    struct Association has copy, drop, store {
        association_id: 0x1::string::String,
        association_timestamp_ms: u64,
    }

    struct AddressState has store {
        active: Association,
        history: 0x2::table_vec::TableVec<Association>,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        addresses: 0x2::table::Table<address, AddressState>,
        merchants: 0x2::vec_set::VecSet<0x1::string::String>,
        merchant_managers: 0x2::vec_set::VecSet<address>,
        cooldown_period_ms: u64,
    }

    struct RegistryCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun active_association(arg0: &Registry, arg1: address) : &Association {
        &0x2::table::borrow<address, AddressState>(&arg0.addresses, arg1).active
    }

    public fun add_merchant(arg0: &mut Registry, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(is_merchant_manager(arg0, 0x2::tx_context::sender(arg2)), 13835340088604753923);
        0x2::vec_set::insert<0x1::string::String>(&mut arg0.merchants, arg1);
    }

    public fun add_merchant_manager(arg0: &mut Registry, arg1: &RegistryCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.merchant_managers, arg2);
    }

    public(friend) fun association_history(arg0: &Registry, arg1: address) : &0x2::table_vec::TableVec<Association> {
        &0x2::table::borrow<address, AddressState>(&arg0.addresses, arg1).history
    }

    public(friend) fun association_id(arg0: &Association) : 0x1::string::String {
        arg0.association_id
    }

    public(friend) fun association_timestamp_ms(arg0: &Association) : u64 {
        arg0.association_timestamp_ms
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                 : 0x2::object::new(arg0),
            addresses          : 0x2::table::new<address, AddressState>(arg0),
            merchants          : 0x2::vec_set::empty<0x1::string::String>(),
            merchant_managers  : 0x2::vec_set::empty<address>(),
            cooldown_period_ms : 86400000,
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = RegistryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_available_merchant(arg0: &Registry, arg1: &0x1::string::String) : bool {
        0x2::vec_set::contains<0x1::string::String>(&arg0.merchants, arg1)
    }

    public fun is_merchant_manager(arg0: &Registry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.merchant_managers, &arg1)
    }

    public fun register(arg0: &mut Registry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_available_merchant(arg0, &arg1), 13835621310178525189);
        let v0 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, AddressState>(&arg0.addresses, v0)) {
            let v1 = Association{
                association_id           : arg1,
                association_timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            };
            let v2 = AddressState{
                active  : v1,
                history : 0x2::table_vec::empty<Association>(arg3),
            };
            0x2::table::add<address, AddressState>(&mut arg0.addresses, v0, v2);
            return
        };
        let v3 = 0x2::table::borrow_mut<address, AddressState>(&mut arg0.addresses, v0);
        if (v3.active.association_id == arg1) {
            return
        };
        assert!(0x2::clock::timestamp_ms(arg2) - v3.active.association_timestamp_ms > arg0.cooldown_period_ms, 13835058497663795201);
        0x2::table_vec::push_back<Association>(&mut v3.history, v3.active);
        let v4 = Association{
            association_id           : arg1,
            association_timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        v3.active = v4;
    }

    public fun remove_merchant_manager(arg0: &mut Registry, arg1: &RegistryCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.merchant_managers, &arg2);
    }

    public fun set_cooldown_period_ms(arg0: &mut Registry, arg1: &RegistryCap, arg2: u64) {
        arg0.cooldown_period_ms = arg2;
    }

    // decompiled from Move bytecode v7
}

