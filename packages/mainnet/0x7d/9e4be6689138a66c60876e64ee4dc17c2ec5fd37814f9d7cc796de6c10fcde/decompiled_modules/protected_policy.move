module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::protected_policy {
    struct AresRPG_TransferPolicy<phantom T0> has store, key {
        id: 0x2::object::UID,
        transfer_policy: 0x2::transfer_policy::TransferPolicy<T0>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<T0>,
    }

    public(friend) fun extract_from_kiosk<T0: store + key>(arg0: &AresRPG_TransferPolicy<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        0x2::kiosk::set_owner(arg1, arg2, arg4);
        0x2::kiosk::list<T0>(arg1, arg2, arg3, 0);
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg1, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(&arg0.transfer_policy, v1);
        v0
    }

    public fun mint_and_share_aresrpg_policy<T0>(arg0: &0x2::package::Publisher, arg1: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg1);
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg2);
        let v2 = AresRPG_TransferPolicy<T0>{
            id              : 0x2::object::new(arg2),
            transfer_policy : v0,
            policy_cap      : v1,
        };
        0x2::transfer::share_object<AresRPG_TransferPolicy<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

