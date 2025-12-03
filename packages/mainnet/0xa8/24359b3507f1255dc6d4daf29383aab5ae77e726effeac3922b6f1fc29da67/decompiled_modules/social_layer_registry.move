module 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_registry {
    struct Registry has store, key {
        id: 0x2::object::UID,
        display_name_registry: 0x2::table::Table<0x1::string::String, bool>,
        address_registry: 0x2::table::Table<address, bool>,
    }

    struct SOCIAL_LAYER_REGISTRY has drop {
        dummy_field: bool,
    }

    public(friend) fun add_entries(arg0: &mut Registry, arg1: 0x1::string::String, arg2: address) {
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg0.display_name_registry, arg1), 1);
        assert!(!0x2::table::contains<address, bool>(&arg0.address_registry, arg2), 1);
        0x2::table::add<0x1::string::String, bool>(&mut arg0.display_name_registry, arg1, true);
        0x2::table::add<address, bool>(&mut arg0.address_registry, arg2, true);
    }

    public(friend) fun add_entry_address_registry(arg0: &mut Registry, arg1: address) {
        assert!(!0x2::table::contains<address, bool>(&arg0.address_registry, arg1), 1);
        0x2::table::add<address, bool>(&mut arg0.address_registry, arg1, true);
    }

    public(friend) fun add_entry_display_name_registry(arg0: &mut Registry, arg1: 0x1::string::String) {
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg0.display_name_registry, arg1), 1);
        0x2::table::add<0x1::string::String, bool>(&mut arg0.display_name_registry, arg1, true);
    }

    public fun create_registry(arg0: &SOCIAL_LAYER_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) : Registry {
        assert!(0x2::types::is_one_time_witness<SOCIAL_LAYER_REGISTRY>(arg0), 3);
        Registry{
            id                    : 0x2::object::new(arg1),
            display_name_registry : 0x2::table::new<0x1::string::String, bool>(arg1),
            address_registry      : 0x2::table::new<address, bool>(arg1),
        }
    }

    public fun get_entry_address_registry(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.address_registry, arg1)
    }

    public fun get_entry_display_name_registry(arg0: &Registry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(&arg0.display_name_registry, arg1)
    }

    fun init(arg0: SOCIAL_LAYER_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Registry>(create_registry(&arg0, arg1));
    }

    public(friend) fun remove_entries(arg0: &mut Registry, arg1: 0x1::string::String, arg2: address) {
        assert!(0x2::table::contains<0x1::string::String, bool>(&arg0.display_name_registry, arg1), 2);
        assert!(0x2::table::contains<address, bool>(&arg0.address_registry, arg2), 2);
        0x2::table::remove<0x1::string::String, bool>(&mut arg0.display_name_registry, arg1);
        0x2::table::remove<address, bool>(&mut arg0.address_registry, arg2);
    }

    public(friend) fun remove_entry_address_registry(arg0: &mut Registry, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.address_registry, arg1), 2);
        0x2::table::remove<address, bool>(&mut arg0.address_registry, arg1);
    }

    public(friend) fun remove_entry_display_name_registry(arg0: &mut Registry, arg1: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, bool>(&arg0.display_name_registry, arg1), 2);
        0x2::table::remove<0x1::string::String, bool>(&mut arg0.display_name_registry, arg1);
    }

    // decompiled from Move bytecode v6
}

