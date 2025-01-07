module 0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::shared_cap {
    struct SharedCap<phantom T0: key> has key {
        id: 0x2::object::UID,
        target_id: 0x2::object::ID,
        pointer_table: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct EventHolderInfo has copy, drop {
        holder: address,
        pointer_id: 0x2::object::ID,
    }

    fun new<T0: key>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : SharedCap<T0> {
        let v0 = SharedCap<T0>{
            id            : 0x2::object::new(arg1),
            target_id     : 0x2::object::id<T0>(arg0),
            pointer_table : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        let v1 = 0x2::tx_context::sender(arg1);
        0x2::table::add<address, 0x2::object::ID>(&mut v0.pointer_table, v1, 0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::regulated_pointer::create<SharedCap<T0>>(&v0, v1, arg1));
        v0
    }

    public entry fun create<T0: key>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new<T0>(arg0, arg1);
        0x2::transfer::share_object<SharedCap<T0>>(v0);
        0x2::object::id<SharedCap<T0>>(&v0)
    }

    public fun add_pointer<T0: key>(arg0: &mut SharedCap<T0>, arg1: &0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::regulated_pointer::RegulatedPointer<SharedCap<T0>>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_cap<T0>(arg0, arg1);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.pointer_table, arg2, 0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::regulated_pointer::create<SharedCap<T0>>(arg0, arg2, arg3));
    }

    public fun check_cap<T0: key>(arg0: &SharedCap<T0>, arg1: &0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::regulated_pointer::RegulatedPointer<SharedCap<T0>>) {
        assert!(get_pointer_by_holder<T0>(arg0, 0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::regulated_pointer::holder<SharedCap<T0>>(arg1)) == 0x2::object::id<0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::regulated_pointer::RegulatedPointer<SharedCap<T0>>>(arg1), 257);
    }

    public fun get_pointer_by_holder<T0: key>(arg0: &SharedCap<T0>, arg1: address) : 0x2::object::ID {
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.pointer_table, arg1), 258);
        let v0 = *0x2::table::borrow<address, 0x2::object::ID>(&arg0.pointer_table, arg1);
        let v1 = EventHolderInfo{
            holder     : arg1,
            pointer_id : v0,
        };
        0x2::event::emit<EventHolderInfo>(v1);
        v0
    }

    public fun remove_pointer<T0: key>(arg0: &mut SharedCap<T0>, arg1: &0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::regulated_pointer::RegulatedPointer<SharedCap<T0>>, arg2: address) : 0x2::object::ID {
        check_cap<T0>(arg0, arg1);
        get_pointer_by_holder<T0>(arg0, arg2);
        0x2::table::remove<address, 0x2::object::ID>(&mut arg0.pointer_table, arg2)
    }

    // decompiled from Move bytecode v6
}

