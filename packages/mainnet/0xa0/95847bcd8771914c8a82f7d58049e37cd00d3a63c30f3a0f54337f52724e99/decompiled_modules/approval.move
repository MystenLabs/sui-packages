module 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval {
    struct Attached has copy, drop, store {
        record: 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::ReservationRecord,
        budget_before: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        budget_after: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
    }

    struct Approval<phantom T0> {
        grant: address,
        amount: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money,
        request: address,
        agreement: 0x1::option::Option<address>,
        attached: 0x1::option::Option<Attached>,
    }

    public fun amount<T0>(arg0: &Approval<T0>) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money {
        &arg0.amount
    }

    public fun agreement<T0>(arg0: &Approval<T0>) : &0x1::option::Option<address> {
        &arg0.agreement
    }

    public fun grant<T0>(arg0: &Approval<T0>) : address {
        arg0.grant
    }

    public(friend) fun issue<T0: drop>(arg0: T0, arg1: address, arg2: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money, arg3: address, arg4: 0x1::option::Option<address>) : Approval<T0> {
        Approval<T0>{
            grant     : arg1,
            amount    : arg2,
            request   : arg3,
            agreement : arg4,
            attached  : 0x1::option::none<Attached>(),
        }
    }

    public fun request<T0>(arg0: &Approval<T0>) : address {
        arg0.request
    }

    public(friend) fun split(arg0: Attached) : (0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::ReservationRecord, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount) {
        let Attached {
            record        : v0,
            budget_before : v1,
            budget_after  : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public(friend) fun unpack<T0>(arg0: Approval<T0>) : (address, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money, address, 0x1::option::Option<address>, 0x1::option::Option<Attached>) {
        let Approval {
            grant     : v0,
            amount    : v1,
            request   : v2,
            agreement : v3,
            attached  : v4,
        } = arg0;
        (v0, v1, v2, v3, v4)
    }

    public(friend) fun with_record<T0>(arg0: Approval<T0>, arg1: 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::ReservationRecord, arg2: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount, arg3: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount) : Approval<T0> {
        let Approval {
            grant     : v0,
            amount    : v1,
            request   : v2,
            agreement : v3,
            attached  : _,
        } = arg0;
        let v5 = Attached{
            record        : arg1,
            budget_before : arg2,
            budget_after  : arg3,
        };
        Approval<T0>{
            grant     : v0,
            amount    : v1,
            request   : v2,
            agreement : v3,
            attached  : 0x1::option::some<Attached>(v5),
        }
    }

    // decompiled from Move bytecode v7
}

