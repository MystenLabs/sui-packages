module 0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::mint {
    struct ClaimEvent has copy, drop {
        kiosk: 0x2::object::ID,
        claimed_nfts: vector<0x2::object::ID>,
        user_address: address,
    }

    struct ClaimPolicy has drop {
        dummy_field: bool,
    }

    struct ClaimPolicyConfig has drop, store {
        dummy_field: bool,
    }

    struct ProtectedTP<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        transfer_policy: 0x2::transfer_policy::TransferPolicy<T0>,
        transfer_policy_cap: 0x2::transfer_policy::TransferPolicyCap<T0>,
    }

    fun claim_by_address(arg0: address, arg1: &mut 0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::custodian::Custodian, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::pandorian::Pandorian>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::custodian::get_nft_by_address(arg1, arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::pandorian::Pandorian>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::pandorian::Pandorian>(&mut v1);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::pandorian::Pandorian>(&v3));
            0x2::kiosk::lock<0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::pandorian::Pandorian>(arg2, arg3, arg4, v3);
            v2 = v2 + 1;
        };
        let v4 = ClaimEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            claimed_nfts : v0,
            user_address : arg0,
        };
        0x2::event::emit<ClaimEvent>(v4);
        0x1::vector::destroy_empty<0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::pandorian::Pandorian>(v1);
    }

    fun claim_by_nft(arg0: &mut 0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::custodian::Custodian, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::pandorian::Pandorian>, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::custodian::get_nft_by_id(arg0, arg4);
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::pandorian::Pandorian>(&v1));
        0x2::kiosk::lock<0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::pandorian::Pandorian>(arg1, arg2, arg3, v1);
        let v2 = ClaimEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            claimed_nfts : v0,
            user_address : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ClaimEvent>(v2);
    }

    public entry fun claim_to_kiosk_by_address(arg0: &0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::version::Version, arg1: &mut 0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::custodian::Custodian, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::transfer_policy::TransferPolicy<0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::pandorian::Pandorian>, arg5: &mut 0x2::tx_context::TxContext) {
        0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::version::assert_current_version(arg0);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg2), 100);
        claim_by_address(0x2::tx_context::sender(arg5), arg1, arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), arg4);
    }

    public entry fun claim_to_kiosk_by_nfts<T0: store + key>(arg0: &0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::version::Version, arg1: &mut 0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::custodian::Custodian, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: vector<0x2::object::ID>, arg5: &ProtectedTP<T0>, arg6: &0x2::transfer_policy::TransferPolicy<0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::pandorian::Pandorian>, arg7: &mut 0x2::tx_context::TxContext) {
        0x82275fe57cabaca6729ee6396f7784a17371480f551ddf605cba32558ff40eb0::version::assert_current_version(arg0);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg2), 100);
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg4)) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg4);
            let v3 = unlock_nft<T0>(arg2, v0, v2, &arg5.transfer_policy, arg7);
            0x2::transfer::public_transfer<T0>(v3, @0x5fe2415c93cfd6251e579dfbd4f609795a0c917f33c40e82aaba5aec698d8769);
            claim_by_nft(arg1, arg2, v0, arg6, v2, arg7);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg4);
    }

    public(friend) fun setup_policy<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = ClaimPolicy{dummy_field: false};
        let v5 = ClaimPolicyConfig{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, ClaimPolicy, ClaimPolicyConfig>(v4, &mut v3, &v2, v5);
        let v6 = ProtectedTP<T0>{
            id                  : 0x2::object::new(arg1),
            transfer_policy     : v3,
            transfer_policy_cap : v2,
        };
        0x2::transfer::public_share_object<ProtectedTP<T0>>(v6);
    }

    fun unlock_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let v2 = v1;
        let v3 = ClaimPolicy{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, ClaimPolicy>(v3, &mut v2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v2);
        v0
    }

    // decompiled from Move bytecode v6
}

