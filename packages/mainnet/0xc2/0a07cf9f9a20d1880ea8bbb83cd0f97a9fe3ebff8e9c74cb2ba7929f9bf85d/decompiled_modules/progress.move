module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::progress {
    struct NewProgressEvent has copy, drop {
        object: address,
        machine: address,
        task: 0x1::option::Option<address>,
    }

    struct Holder has copy, drop, store {
        who: 0x1::option::Option<address>,
        orders: vector<address>,
        msg: 0x1::string::String,
        accomplished: bool,
        time: u64,
    }

    struct Session has copy, drop, store {
        forwards: 0x2::vec_map::VecMap<0x1::string::String, Holder>,
        weights: u32,
        threshold: u32,
    }

    struct History has drop, store {
        time: u64,
        node: 0x1::string::String,
        next_node: 0x1::string::String,
        session: 0x2::vec_map::VecMap<0x1::string::String, Session>,
    }

    struct Parent has drop, store {
        session_index: u64,
        node: 0x1::string::String,
        next_node: 0x1::string::String,
        forward: 0x1::string::String,
        parent: address,
    }

    public fun DATA(arg0: bool) {
        assert!(arg0, 1907);
    }

    public fun FORWARD(arg0: bool) {
        assert!(arg0, 1906);
    }

    public fun HOLDER() {
        abort 1902
    }

    public fun History_new(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x2::vec_map::VecMap<0x1::string::String, Session>, arg3: &0x2::clock::Clock) : History {
        History{
            time      : 0x2::clock::timestamp_ms(arg3),
            node      : *arg0,
            next_node : *arg1,
            session   : *arg2,
        }
    }

    public fun History_node(arg0: &History) : &0x1::string::String {
        &arg0.node
    }

    public fun History_session(arg0: &History) : &0x2::vec_map::VecMap<0x1::string::String, Session> {
        &arg0.session
    }

    public fun History_session_holder(arg0: &History, arg1: &0x1::string::String, arg2: &0x1::string::String) : (0x1::option::Option<Holder>, 0x1::option::Option<0x1::string::String>) {
        (Session_holder(&arg0.session, arg1, arg2), 0x1::option::some<0x1::string::String>(arg0.node))
    }

    public fun History_time(arg0: &History) : &u64 {
        &arg0.time
    }

    public fun Holder_accomplished(arg0: &0x1::option::Option<Holder>) : bool {
        FORWARD(0x1::option::is_some<Holder>(arg0));
        0x1::option::borrow<Holder>(arg0).accomplished
    }

    public fun Holder_has_order(arg0: &0x1::option::Option<Holder>, arg1: &address) : bool {
        FORWARD(0x1::option::is_some<Holder>(arg0));
        let v0 = 0x1::option::borrow<Holder>(arg0).orders;
        0x1::vector::contains<address>(&v0, arg1)
    }

    public fun Holder_msg(arg0: &0x1::option::Option<Holder>) : 0x1::string::String {
        FORWARD(0x1::option::is_some<Holder>(arg0));
        0x1::option::borrow<Holder>(arg0).msg
    }

    public fun Holder_orders_count(arg0: &0x1::option::Option<Holder>) : u64 {
        FORWARD(0x1::option::is_some<Holder>(arg0));
        let v0 = 0x1::option::borrow<Holder>(arg0).orders;
        0x1::vector::length<address>(&v0)
    }

    public fun Holder_time(arg0: &0x1::option::Option<Holder>) : u64 {
        FORWARD(0x1::option::is_some<Holder>(arg0));
        0x1::option::borrow<Holder>(arg0).time
    }

    public fun Holder_who(arg0: &0x1::option::Option<Holder>) : &address {
        FORWARD(0x1::option::is_some<Holder>(arg0));
        DATA(0x1::option::is_some<address>(&0x1::option::borrow<Holder>(arg0).who));
        0x1::option::borrow<address>(&0x1::option::borrow<Holder>(arg0).who)
    }

    public fun INITIAL_NODE_NAME() : vector<u8> {
        b""
    }

    public fun MACHINE(arg0: bool) {
        assert!(arg0, 1904);
    }

    public fun Max_RecordLen(arg0: u64) : u64 {
        if (arg0 > 1000) {
            arg0 - 1000
        } else {
            0
        }
    }

    public fun Max_RecordLen2(arg0: u64) : u64 {
        if (arg0 > 1000) {
            1000
        } else {
            arg0
        }
    }

    public fun NOT_FOUND_IN_HISTORY(arg0: bool) {
        assert!(arg0, 1912);
    }

    public fun NOT_PAYER(arg0: &vector<u8>) {
        assert!(*arg0 != b"OrderPayer", 1909);
    }

    public fun NewProgressEvent_emit(arg0: &address, arg1: &address, arg2: &0x1::option::Option<address>) {
        let v0 = NewProgressEvent{
            object  : *arg0,
            machine : *arg1,
            task    : *arg2,
        };
        0x2::event::emit<NewProgressEvent>(v0);
    }

    public fun OPOR_COUNT(arg0: u64) {
        assert!(arg0 <= 40, 1903);
    }

    public fun ORDER_PAYER() : vector<u8> {
        b"OrderPayer"
    }

    public fun PARENT(arg0: bool) {
        assert!(arg0, 1908);
    }

    public fun PERM_NONE(arg0: bool) {
        assert!(arg0, 1900);
    }

    public fun PUSHED() {
        abort 1905
    }

    public fun Parent_forward(arg0: &0x1::option::Option<Parent>) : 0x1::string::String {
        assert!(0x1::option::is_some<Parent>(arg0), 1911);
        0x1::option::borrow<Parent>(arg0).forward
    }

    public fun Parent_new(arg0: &address, arg1: u64, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &0x1::string::String) : 0x1::option::Option<Parent> {
        let v0 = Parent{
            session_index : arg1,
            node          : *arg4,
            next_node     : *arg2,
            forward       : *arg3,
            parent        : *arg0,
        };
        0x1::option::some<Parent>(v0)
    }

    public fun Parent_next_node(arg0: &0x1::option::Option<Parent>) : 0x1::string::String {
        assert!(0x1::option::is_some<Parent>(arg0), 1911);
        0x1::option::borrow<Parent>(arg0).next_node
    }

    public fun Parent_node(arg0: &0x1::option::Option<Parent>) : 0x1::string::String {
        assert!(0x1::option::is_some<Parent>(arg0), 1911);
        0x1::option::borrow<Parent>(arg0).node
    }

    public fun Parent_parent(arg0: &0x1::option::Option<Parent>) : address {
        assert!(0x1::option::is_some<Parent>(arg0), 1911);
        0x1::option::borrow<Parent>(arg0).parent
    }

    public fun Parent_session_index(arg0: &0x1::option::Option<Parent>) : u64 {
        assert!(0x1::option::is_some<Parent>(arg0), 1911);
        0x1::option::borrow<Parent>(arg0).session_index
    }

    public fun Session_accomplish(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, Session>, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: u32, arg4: u16, arg5: &vector<address>, arg6: &0x1::string::String, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : bool {
        if (0x2::vec_map::contains<0x1::string::String, Session>(arg0, arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, Session>(arg0, arg1);
            let v1 = false;
            if (0x2::vec_map::contains<0x1::string::String, Holder>(&v0.forwards, arg2)) {
                let v2 = 0x2::vec_map::get_mut<0x1::string::String, Holder>(&mut v0.forwards, arg2);
                if (!v2.accomplished) {
                    if (0x1::option::is_some<address>(&v2.who)) {
                        if (*0x1::option::borrow<address>(&v2.who) == 0x2::tx_context::sender(arg8)) {
                            v1 = true;
                        } else {
                            HOLDER();
                        };
                    } else {
                        v2.who = 0x1::option::some<address>(0x2::tx_context::sender(arg8));
                        v1 = true;
                    };
                } else if (0x1::option::is_some<address>(&v2.who)) {
                    if (*0x1::option::borrow<address>(&v2.who) == 0x2::tx_context::sender(arg8)) {
                        v2.orders = *arg5;
                        v2.msg = *arg6;
                    } else {
                        HOLDER();
                    };
                };
                v2.time = 0x2::clock::timestamp_ms(arg7);
                if (v1) {
                    v2.accomplished = true;
                    v2.orders = *arg5;
                    v2.msg = *arg6;
                };
            } else {
                let v3 = Holder{
                    who          : 0x1::option::some<address>(0x2::tx_context::sender(arg8)),
                    orders       : *arg5,
                    msg          : *arg6,
                    accomplished : true,
                    time         : 0x2::clock::timestamp_ms(arg7),
                };
                0x2::vec_map::insert<0x1::string::String, Holder>(&mut v0.forwards, *arg2, v3);
                v1 = true;
            };
            if (v1) {
                v0.weights = v0.weights + (arg4 as u32);
                if (v0.weights >= arg3) {
                    return true
                };
            };
        } else {
            let v4 = 0x2::vec_map::empty<0x1::string::String, Holder>();
            let v5 = Holder{
                who          : 0x1::option::some<address>(0x2::tx_context::sender(arg8)),
                orders       : *arg5,
                msg          : *arg6,
                accomplished : true,
                time         : 0x2::clock::timestamp_ms(arg7),
            };
            0x2::vec_map::insert<0x1::string::String, Holder>(&mut v4, *arg2, v5);
            let v6 = Session{
                forwards  : v4,
                weights   : (arg4 as u32),
                threshold : arg3,
            };
            0x2::vec_map::insert<0x1::string::String, Session>(arg0, *arg1, v6);
            if ((arg4 as u32) >= arg3) {
                return true
            };
        };
        false
    }

    public fun Session_hold(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, Session>, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: u32, arg4: bool, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<address>();
        let v1 = 0x2::tx_context::sender(arg7);
        if (arg4) {
            v0 = 0x1::option::some<address>(v1);
        };
        if (0x2::vec_map::contains<0x1::string::String, Session>(arg0, arg1)) {
            let v2 = 0x2::vec_map::get_mut<0x1::string::String, Session>(arg0, arg1);
            if (!0x2::vec_map::contains<0x1::string::String, Holder>(&v2.forwards, arg2)) {
                let v3 = Holder{
                    who          : v0,
                    orders       : 0x1::vector::empty<address>(),
                    msg          : 0x1::string::utf8(b""),
                    accomplished : false,
                    time         : 0x2::clock::timestamp_ms(arg6),
                };
                0x2::vec_map::insert<0x1::string::String, Holder>(&mut v2.forwards, *arg2, v3);
            } else {
                let v4 = 0x2::vec_map::get_mut<0x1::string::String, Holder>(&mut v2.forwards, arg2);
                if (!v4.accomplished) {
                    if (arg5) {
                        if (!arg4) {
                            v4.who = 0x1::option::none<address>();
                        };
                    } else if (0x1::option::is_some<address>(&v4.who)) {
                        if (*0x1::option::borrow<address>(&v4.who) == v1 && !arg4) {
                            v4.who = 0x1::option::none<address>();
                        } else if (*0x1::option::borrow<address>(&v4.who) != v1) {
                            HOLDER();
                        };
                    } else if (arg4) {
                        v4.who = v0;
                    };
                } else {
                    PUSHED();
                };
                v4.time = 0x2::clock::timestamp_ms(arg6);
            };
        } else {
            let v5 = 0x2::vec_map::empty<0x1::string::String, Holder>();
            let v6 = Holder{
                who          : v0,
                orders       : 0x1::vector::empty<address>(),
                msg          : 0x1::string::utf8(b""),
                accomplished : false,
                time         : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::vec_map::insert<0x1::string::String, Holder>(&mut v5, *arg2, v6);
            let v7 = Session{
                forwards  : v5,
                weights   : 0,
                threshold : arg3,
            };
            0x2::vec_map::insert<0x1::string::String, Session>(arg0, *arg1, v7);
        };
    }

    public fun Session_holder(arg0: &0x2::vec_map::VecMap<0x1::string::String, Session>, arg1: &0x1::string::String, arg2: &0x1::string::String) : 0x1::option::Option<Holder> {
        if (0x2::vec_map::contains<0x1::string::String, Session>(arg0, arg1)) {
            return 0x2::vec_map::try_get<0x1::string::String, Holder>(&0x2::vec_map::get<0x1::string::String, Session>(arg0, arg1).forwards, arg2)
        };
        0x1::option::none<Holder>()
    }

    public fun TASK(arg0: bool) {
        assert!(arg0, 1901);
    }

    // decompiled from Move bytecode v6
}

