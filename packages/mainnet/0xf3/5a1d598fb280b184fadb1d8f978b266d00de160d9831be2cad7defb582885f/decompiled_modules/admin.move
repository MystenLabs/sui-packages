module 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin {
    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        config_id: 0x1::option::Option<0x2::object::ID>,
        status_id: 0x1::option::Option<0x2::object::ID>,
    }

    public fun new<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : AdminCap<T0> {
        if (!0x2::types::is_one_time_witness<T0>(&arg0)) {
            err_not_one_time_witness();
        };
        AdminCap<T0>{
            id        : 0x2::object::new(arg1),
            config_id : 0x1::option::none<0x2::object::ID>(),
            status_id : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun config_id<T0>(arg0: &AdminCap<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.config_id
    }

    fun err_config_already_created() {
        abort 1
    }

    fun err_not_one_time_witness() {
        abort 0
    }

    fun err_status_already_created() {
        abort 2
    }

    public(friend) fun set_config_id<T0>(arg0: &mut AdminCap<T0>, arg1: 0x2::object::ID) {
        if (0x1::option::is_some<0x2::object::ID>(config_id<T0>(arg0))) {
            err_config_already_created();
        };
        0x1::option::fill<0x2::object::ID>(&mut arg0.config_id, arg1);
    }

    public(friend) fun set_status_id<T0>(arg0: &mut AdminCap<T0>, arg1: 0x2::object::ID) {
        if (0x1::option::is_some<0x2::object::ID>(status_id<T0>(arg0))) {
            err_status_already_created();
        };
        0x1::option::fill<0x2::object::ID>(&mut arg0.status_id, arg1);
    }

    public fun status_id<T0>(arg0: &AdminCap<T0>) : &0x1::option::Option<0x2::object::ID> {
        &arg0.status_id
    }

    // decompiled from Move bytecode v6
}

