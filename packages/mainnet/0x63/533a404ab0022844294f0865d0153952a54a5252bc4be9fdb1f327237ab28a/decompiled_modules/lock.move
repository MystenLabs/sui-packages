module 0x63533a404ab0022844294f0865d0153952a54a5252bc4be9fdb1f327237ab28a::lock {
    struct Lock has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        readers: 0x2::table::Table<address, bool>,
    }

    struct LockCreated has copy, drop {
        lock_id: 0x2::object::ID,
        owner: address,
    }

    entry fun add_reader(arg0: &mut Lock, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        assert!(!0x2::table::contains<address, bool>(&arg0.readers, arg1), 3);
        0x2::table::add<address, bool>(&mut arg0.readers, arg1, true);
    }

    fun check_policy(arg0: address, arg1: vector<u8>, arg2: &Lock) : bool {
        assert!(arg2.version == 1, 5);
        has_prefix(&arg1, 0x2::object::uid_to_bytes(&arg2.id)) && (arg0 == arg2.owner || 0x2::table::contains<address, bool>(&arg2.readers, arg0))
    }

    entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Lock{
            id      : 0x2::object::new(arg0),
            version : 1,
            owner   : 0x2::tx_context::sender(arg0),
            readers : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = LockCreated{
            lock_id : 0x2::object::id<Lock>(&v0),
            owner   : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<LockCreated>(v1);
        0x2::transfer::share_object<Lock>(v0);
    }

    fun has_prefix(arg0: &vector<u8>, arg1: vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg1) > 0x1::vector::length<u8>(arg0)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg1)) {
            if (*0x1::vector::borrow<u8>(&arg1, v0) != *0x1::vector::borrow<u8>(arg0, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun is_reader(arg0: &Lock, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.readers, arg1)
    }

    public fun owner(arg0: &Lock) : address {
        arg0.owner
    }

    entry fun remove_reader(arg0: &mut Lock, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        assert!(0x2::table::contains<address, bool>(&arg0.readers, arg1), 4);
        0x2::table::remove<address, bool>(&mut arg0.readers, arg1);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Lock, arg2: &0x2::tx_context::TxContext) {
        assert!(check_policy(0x2::tx_context::sender(arg2), arg0, arg1), 1);
    }

    entry fun transfer_ownership(arg0: &mut Lock, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        arg0.owner = arg1;
    }

    // decompiled from Move bytecode v7
}

