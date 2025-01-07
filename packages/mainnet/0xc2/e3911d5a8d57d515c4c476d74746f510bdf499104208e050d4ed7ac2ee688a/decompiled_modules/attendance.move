module 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::attendance {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        event_id: address,
    }

    struct Config has key {
        id: 0x2::object::UID,
        attendance: 0x2::table::Table<address, bool>,
    }

    struct SetAttended has copy, drop {
        cnt_id: address,
    }

    struct ConfirmAttended has copy, drop {
        cnt_id: address,
    }

    public entry fun confirm_attended(arg0: &mut 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::CNT, arg1: &mut Config) {
        let v0 = 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::get_cnt_id(arg0);
        assert!(has_attended(v0, arg1), 1);
        0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::set_attended(arg0);
        let v1 = ConfirmAttended{cnt_id: v0};
        0x2::event::emit<ConfirmAttended>(v1);
    }

    public(friend) fun create_op_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : OperatorCap {
        OperatorCap{
            id       : 0x2::object::new(arg1),
            event_id : arg0,
        }
    }

    public fun has_attended(arg0: address, arg1: &Config) : bool {
        if (!0x2::table::contains<address, bool>(&arg1.attendance, arg0)) {
            return false
        };
        *0x2::table::borrow<address, bool>(&arg1.attendance, arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id         : 0x2::object::new(arg0),
            attendance : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun set_attended(arg0: &0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::CNT, arg1: &mut Config, arg2: &OperatorCap) {
        assert!(0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::get_cnt_event_id(arg0) == arg2.event_id, 0);
        let v0 = 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::get_cnt_id(arg0);
        0x2::table::add<address, bool>(&mut arg1.attendance, v0, true);
        let v1 = SetAttended{cnt_id: v0};
        0x2::event::emit<SetAttended>(v1);
    }

    // decompiled from Move bytecode v6
}

