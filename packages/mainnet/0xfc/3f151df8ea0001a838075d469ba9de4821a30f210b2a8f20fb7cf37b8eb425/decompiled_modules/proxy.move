module 0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::proxy {
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

    public fun new_display<T0: drop>(arg0: &Registry, arg1: &0x2::package::Publisher, arg2: &0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT> {
        0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::version::validate_version(arg2, 1);
        assert!(0x2::package::from_package<T0>(arg1), 1);
        0x2::display::new<0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT>(&arg0.publisher, arg3)
    }

    public fun publisher_mut(arg0: &0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::authority::OperatorCap, arg1: &mut Registry) : &mut 0x2::package::Publisher {
        &mut arg1.publisher
    }

    public fun setup_tp<T0: drop>(arg0: &Registry, arg1: &0x2::package::Publisher, arg2: &0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::version::validate_version(arg2, 1);
        assert!(0x2::package::from_package<T0>(arg1), 1);
        let (v0, v1) = 0x2::transfer_policy::new<0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT>(&arg0.publisher, arg3);
        let v2 = ProtectedTP<0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT>{
            id              : 0x2::object::new(arg3),
            policy_cap      : v1,
            transfer_policy : v0,
        };
        0x2::transfer::share_object<ProtectedTP<0xfc3f151df8ea0001a838075d469ba9de4821a30f210b2a8f20fb7cf37b8eb425::nft::TestNFT>>(v2);
    }

    // decompiled from Move bytecode v6
}

