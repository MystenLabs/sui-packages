module 0x1e84464c622c0ba9ace8ed520bb7fdc83d63f788c30f8a7464cb929744c0313f::stake {
    struct StakeExtension has drop {
        dummy_field: bool,
    }

    struct Staked<T0: store + key> has store {
        kiosk: 0x2::object::ID,
        asset: T0,
        start_timestamp: u64,
    }

    struct ProtectedTP<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        transfer_policy: 0x2::transfer_policy::TransferPolicy<T0>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<T0>,
    }

    struct StakeEvent has copy, drop {
        kiosk: 0x2::object::ID,
        nft: 0x2::object::ID,
        user_address: address,
        timestamp: u64,
    }

    struct UnstakeEvent has copy, drop {
        kiosk: 0x2::object::ID,
        nft: 0x2::object::ID,
        user_address: address,
        timestamp: u64,
    }

    public entry fun stake<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &ProtectedTP<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg0), 1);
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1);
        if (!0x2::kiosk_extension::is_installed<StakeExtension>(arg0)) {
            let v1 = StakeExtension{dummy_field: false};
            0x2::kiosk_extension::add<StakeExtension>(v1, arg0, v0, 11, arg5);
        };
        stake_with_kiosk_owner_cap<T0>(arg0, v0, arg2, arg3, arg4, arg5);
    }

    public fun get_staked_timestamp<T0: store + key>(arg0: &0x2::kiosk::Kiosk, arg1: 0x2::object::ID) : u64 {
        let v0 = StakeExtension{dummy_field: false};
        let v1 = 0x2::kiosk_extension::storage<StakeExtension>(v0, arg0);
        assert!(0x2::bag::contains<0x2::object::ID>(v1, arg1), 3);
        0x2::bag::borrow<0x2::object::ID, Staked<T0>>(v1, arg1).start_timestamp
    }

    fun place_in_bag<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: Staked<T0>) {
        let v0 = StakeExtension{dummy_field: false};
        0x2::bag::add<0x2::object::ID, Staked<T0>>(0x2::kiosk_extension::storage_mut<StakeExtension>(v0, arg0), arg1, arg2);
    }

    public entry fun setup_staking<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg1);
        let v2 = ProtectedTP<T0>{
            id              : 0x2::object::new(arg1),
            transfer_policy : v0,
            policy_cap      : v1,
        };
        0x2::transfer::public_share_object<ProtectedTP<T0>>(v2);
    }

    public entry fun stake_and_create_kiosk<T0: store + key>(arg0: T0, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let (v1, v2) = 0x2::kiosk::new(arg2);
        let v3 = v1;
        let v4 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg2);
        let v5 = StakeExtension{dummy_field: false};
        0x2::kiosk_extension::add<StakeExtension>(v5, &mut v3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(&v4), 11, arg2);
        let v6 = 0x2::object::id<T0>(&arg0);
        let v7 = Staked<T0>{
            kiosk           : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            asset           : arg0,
            start_timestamp : v0,
        };
        let v8 = &mut v3;
        place_in_bag<T0>(v8, v6, v7);
        let v9 = StakeEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            nft          : v6,
            user_address : 0x2::tx_context::sender(arg2),
            timestamp    : v0,
        };
        0x2::event::emit<StakeEvent>(v9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v4, arg2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public fun stake_with_kiosk_owner_cap<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &ProtectedTP<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let (v1, v2) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg3, 0, arg5), 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(&arg2.transfer_policy, v2);
        let v6 = Staked<T0>{
            kiosk           : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            asset           : v1,
            start_timestamp : v0,
        };
        place_in_bag<T0>(arg0, arg3, v6);
        let v7 = StakeEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            nft          : arg3,
            user_address : 0x2::tx_context::sender(arg5),
            timestamp    : v0,
        };
        0x2::event::emit<StakeEvent>(v7);
    }

    fun take_from_bag<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID) : Staked<T0> {
        let v0 = StakeExtension{dummy_field: false};
        let v1 = 0x2::kiosk_extension::storage_mut<StakeExtension>(v0, arg0);
        assert!(0x2::bag::contains<0x2::object::ID>(v1, arg1), 3);
        0x2::bag::remove<0x2::object::ID, Staked<T0>>(v1, arg1)
    }

    public entry fun unstake<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &ProtectedTP<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg0), 1);
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1);
        assert!(0x2::kiosk::has_access(arg0, v0), 2);
        unstake_with_kiosk_onwer_cap<T0>(arg0, v0, arg2, arg3, arg4, arg5);
    }

    public fun unstake_with_kiosk_onwer_cap<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &ProtectedTP<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = take_from_bag<T0>(arg0, arg3);
        let Staked {
            kiosk           : _,
            asset           : v2,
            start_timestamp : _,
        } = v0;
        0x2::kiosk::lock<T0>(arg0, arg1, &arg2.transfer_policy, v2);
        let v4 = UnstakeEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            nft          : arg3,
            user_address : 0x2::tx_context::sender(arg5),
            timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<UnstakeEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

