module 0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::proxy {
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

    public fun setup_tp<T0: drop>(arg0: &Registry, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<T0>(arg1), 1);
        let (v0, v1) = 0x2::transfer_policy::new<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>(&arg0.publisher, arg2);
        let v2 = ProtectedTP<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>{
            id              : 0x2::object::new(arg2),
            policy_cap      : v1,
            transfer_policy : v0,
        };
        0x2::transfer::share_object<ProtectedTP<0xcd11b2e2e0e079dcb15c3c777034081ce894e1a31110cab73a1c0c5361c6a7f::hello_world::NFT>>(v2);
    }

    // decompiled from Move bytecode v6
}

