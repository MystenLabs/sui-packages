module 0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::proxy {
    struct PROXY has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct ProtectedTP<phantom T0> has store, key {
        id: 0x2::object::UID,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<T0>,
        transfer_policy: 0x2::transfer_policy::TransferPolicy<T0>,
    }

    public(friend) fun transfer_policy<T0>(arg0: &ProtectedTP<T0>) : &0x2::transfer_policy::TransferPolicy<T0> {
        &arg0.transfer_policy
    }

    fun init(arg0: PROXY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<PROXY>(arg0, arg1),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun new_display<T0: drop>(arg0: &Registry, arg1: &0x2::package::Publisher, arg2: &0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::Version, arg3: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::GoldenKey> {
        0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::checkVersion(arg2, 1);
        assert!(0x2::package::from_package<T0>(arg1), 1);
        0x2::display::new<0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::GoldenKey>(&arg0.publisher, arg3)
    }

    public fun publisher_mut(arg0: &0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::AdminCap, arg1: &mut Registry) : &mut 0x2::package::Publisher {
        &mut arg1.publisher
    }

    public fun setup_tp<T0: drop>(arg0: &Registry, arg1: &0x2::package::Publisher, arg2: &0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::checkVersion(arg2, 1);
        assert!(0x2::package::from_package<T0>(arg1), 1);
        let (v0, v1) = 0x2::transfer_policy::new<0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::GoldenKey>(&arg0.publisher, arg3);
        let v2 = ProtectedTP<0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::GoldenKey>{
            id              : 0x2::object::new(arg3),
            policy_cap      : v1,
            transfer_policy : v0,
        };
        0x2::transfer::share_object<ProtectedTP<0xf160afce86ab7cb8844426819b9c46121115b872a2d28d5261eb93751e023b1a::golden_key::GoldenKey>>(v2);
    }

    // decompiled from Move bytecode v6
}

