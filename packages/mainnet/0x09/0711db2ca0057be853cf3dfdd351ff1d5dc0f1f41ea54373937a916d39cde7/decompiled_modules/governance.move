module 0x90711db2ca0057be853cf3dfdd351ff1d5dc0f1f41ea54373937a916d39cde7::governance {
    struct GOVERNANCE has drop {
        dummy_field: bool,
    }

    struct Application<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct NSGovernance has key {
        id: 0x2::object::UID,
        version: u16,
        ns_total_supply: u64,
        quorum_threshold: u64,
    }

    struct NSGovernanceCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : NSGovernance {
        NSGovernance{
            id               : 0x2::object::new(arg0),
            version          : 1,
            ns_total_supply  : 500000000000000,
            quorum_threshold : 1500000000000,
        }
    }

    public(friend) fun add_app<T0: store>(arg0: &mut NSGovernance, arg1: T0) {
        assert_is_valid_version(arg0);
        let v0 = Application<T0>{dummy_field: false};
        0x2::dynamic_field::add<Application<T0>, T0>(&mut arg0.id, v0, arg1);
    }

    public(friend) fun app<T0: store>(arg0: &NSGovernance) : &T0 {
        assert_is_valid_version(arg0);
        let v0 = Application<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<Application<T0>, T0>(&arg0.id, v0)
    }

    public(friend) fun app_mut<T0: store>(arg0: &mut NSGovernance) : &mut T0 {
        assert_is_valid_version(arg0);
        let v0 = Application<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Application<T0>, T0>(&mut arg0.id, v0)
    }

    fun assert_is_valid_version(arg0: &NSGovernance) {
        assert!(is_valid_version(arg0), 1);
    }

    public(friend) fun has_app<T0: store>(arg0: &NSGovernance) : bool {
        assert_is_valid_version(arg0);
        let v0 = Application<T0>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<Application<T0>, T0>(&arg0.id, v0)
    }

    fun init(arg0: GOVERNANCE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<GOVERNANCE>(arg0, arg1);
        let v0 = new(arg1);
        0x2::transfer::share_object<NSGovernance>(v0);
        let v1 = NSGovernanceCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<NSGovernanceCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_valid_version(arg0: &NSGovernance) : bool {
        arg0.version == 1
    }

    public fun ns_total_supply(arg0: &NSGovernance) : u64 {
        arg0.ns_total_supply
    }

    public fun quorum_threshold(arg0: &NSGovernance) : u64 {
        arg0.quorum_threshold
    }

    public(friend) fun remove_app<T0: store>(arg0: &mut NSGovernance) : T0 {
        assert_is_valid_version(arg0);
        let v0 = Application<T0>{dummy_field: false};
        0x2::dynamic_field::remove<Application<T0>, T0>(&mut arg0.id, v0)
    }

    public fun set_quorum_threshold(arg0: &NSGovernanceCap, arg1: &mut NSGovernance, arg2: u64) {
        arg1.quorum_threshold = arg2;
    }

    // decompiled from Move bytecode v6
}

