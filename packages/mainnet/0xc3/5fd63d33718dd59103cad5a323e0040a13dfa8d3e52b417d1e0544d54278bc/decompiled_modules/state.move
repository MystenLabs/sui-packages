module 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state {
    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        pending_admin: 0x1::option::Option<address>,
        vrf_authority: address,
        last_vault: u64,
    }

    public(friend) fun accept_admin_internal(arg0: &mut Config, arg1: address) : address {
        assert!(0x1::option::is_some<address>(&arg0.pending_admin) && *0x1::option::borrow<address>(&arg0.pending_admin) == arg1, 3);
        arg0.admin = arg1;
        arg0.pending_admin = 0x1::option::none<address>();
        arg0.admin
    }

    public fun admin(arg0: &Config) : address {
        arg0.admin
    }

    public(friend) fun assert_admin(arg0: &Config, arg1: address) {
        assert!(arg1 == arg0.admin, 1);
    }

    public(friend) fun assert_nonzero_address(arg0: address) {
        assert!(arg0 != @0x0, 4);
    }

    public(friend) fun assert_vrf_authority(arg0: &Config, arg1: address) {
        assert!(arg1 == arg0.vrf_authority, 2);
    }

    public(friend) fun bump_last_vault(arg0: &mut Config) : u64 {
        let v0 = arg0.last_vault;
        arg0.last_vault = v0 + 1;
        v0
    }

    public(friend) fun cancel_pending_admin_internal(arg0: &mut Config) {
        arg0.pending_admin = 0x1::option::none<address>();
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Config{
            id            : 0x2::object::new(arg0),
            admin         : v0,
            pending_admin : 0x1::option::none<address>(),
            vrf_authority : v0,
            last_vault    : 0,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun last_vault(arg0: &Config) : u64 {
        arg0.last_vault
    }

    public fun pending_admin(arg0: &Config) : 0x1::option::Option<address> {
        arg0.pending_admin
    }

    public(friend) fun propose_admin_internal(arg0: &mut Config, arg1: address) {
        arg0.pending_admin = 0x1::option::some<address>(arg1);
    }

    public(friend) fun set_vrf_authority_internal(arg0: &mut Config, arg1: address) {
        arg0.vrf_authority = arg1;
    }

    public fun vrf_authority(arg0: &Config) : address {
        arg0.vrf_authority
    }

    // decompiled from Move bytecode v7
}

