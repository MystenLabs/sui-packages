module 0xe4233631538681b8cfac312cf381aa1adc7554ca7b3e5055c33dc23ed552b13::regulated_pointer {
    struct RegulatedPointer<phantom T0> has key {
        id: 0x2::object::UID,
        refer_to: 0x2::object::ID,
        holder: address,
    }

    struct PointerReceipt {
        pointer_id: 0x2::object::ID,
        return_to: address,
    }

    public fun delete<T0: key>(arg0: RegulatedPointer<T0>) {
        let RegulatedPointer {
            id       : v0,
            refer_to : _,
            holder   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun create<T0: key>(arg0: &T0, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = RegulatedPointer<T0>{
            id       : 0x2::object::new(arg2),
            refer_to : 0x2::object::id<T0>(arg0),
            holder   : arg1,
        };
        0x2::transfer::transfer<RegulatedPointer<T0>>(v0, arg1);
        0x2::object::id<RegulatedPointer<T0>>(&v0)
    }

    public fun holder<T0: key>(arg0: &RegulatedPointer<T0>) : address {
        arg0.holder
    }

    public fun refer_to<T0: key>(arg0: &RegulatedPointer<T0>) : 0x2::object::ID {
        arg0.refer_to
    }

    public fun return_pointer<T0: key>(arg0: RegulatedPointer<T0>, arg1: PointerReceipt) {
        let PointerReceipt {
            pointer_id : v0,
            return_to  : v1,
        } = arg1;
        assert!(0x2::object::id<RegulatedPointer<T0>>(&arg0) == v0, 258);
        0x2::transfer::transfer<RegulatedPointer<T0>>(arg0, v1);
    }

    public fun take_pointer<T0: key>(arg0: &mut 0x2::object::UID, arg1: 0x2::transfer::Receiving<RegulatedPointer<T0>>) : (RegulatedPointer<T0>, PointerReceipt) {
        let v0 = 0x2::transfer::receive<RegulatedPointer<T0>>(arg0, arg1);
        let v1 = PointerReceipt{
            pointer_id : 0x2::object::id<RegulatedPointer<T0>>(&v0),
            return_to  : 0x2::object::uid_to_address(arg0),
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

