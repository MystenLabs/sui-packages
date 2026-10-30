module 0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        epoch: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        recipient: address,
        paused: bool,
        op_epoch: u64,
        feeds: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        max_price_age_secs: u64,
    }

    public fun assert_can_strike(arg0: &Config, arg1: &OperatorCap) {
        assert!(!arg0.paused, 1);
        assert!(arg1.config == 0x2::object::id<Config>(arg0) && arg1.epoch == arg0.op_epoch, 2);
    }

    public fun destroy_operator(arg0: OperatorCap) {
        let OperatorCap {
            id     : v0,
            config : _,
            epoch  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun has_feed<T0>(arg0: &Config) : bool {
        0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.feeds, 0x1::type_name::with_defining_ids<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                 : 0x2::object::new(arg0),
            recipient          : @0xca6b293d0d02190dde8f31f9668f52a624416826fbf215ac63a7ae0337978a49,
            paused             : false,
            op_epoch           : 0,
            feeds              : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
            max_price_age_secs : 60,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, @0xca6b293d0d02190dde8f31f9668f52a624416826fbf215ac63a7ae0337978a49);
        0x2::transfer::share_object<Config>(v0);
    }

    public fun max_price_age_secs(arg0: &Config) : u64 {
        assert!(arg0.max_price_age_secs > 0, 123);
        arg0.max_price_age_secs
    }

    public fun mint_operator(arg0: &AdminCap, arg1: &Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{
            id     : 0x2::object::new(arg3),
            config : 0x2::object::id<Config>(arg1),
            epoch  : arg1.op_epoch,
        };
        0x2::transfer::transfer<OperatorCap>(v0, arg2);
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun recipient(arg0: &Config) : address {
        arg0.recipient
    }

    public fun require_feed<T0>(arg0: &Config) : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.feeds, v0), 122);
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.feeds, v0)
    }

    public fun revoke_all_operators(arg0: &AdminCap, arg1: &mut Config) {
        arg1.op_epoch = arg1.op_epoch + 1;
    }

    public fun set_feed<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: 0x2::object::ID) {
        assert!(arg2 != 0x2::object::id_from_address(@0x0), 124);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg1.feeds, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.feeds, v0) = arg2;
        } else {
            0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.feeds, v0, arg2);
        };
    }

    public fun set_max_price_age_secs(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.max_price_age_secs = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_recipient(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert!(arg2 != @0x0, 3);
        arg1.recipient = arg2;
    }

    // decompiled from Move bytecode v7
}

