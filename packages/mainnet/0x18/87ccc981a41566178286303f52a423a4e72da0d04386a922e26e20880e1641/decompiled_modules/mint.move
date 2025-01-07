module 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::mint {
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

    public entry fun claim_and_create_kiosk_by_address(arg0: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg1: &mut 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::Custodian, arg2: &0x2::transfer_policy::TransferPolicy<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::Pandorian>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::assert_current_version(arg0);
        let (v0, v1) = 0x2::kiosk::new(arg4);
        let v2 = v0;
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg4);
        let v4 = 0x2::tx_context::sender(arg4);
        let v5 = &mut v2;
        claim_by_address(v4, arg3, arg1, v5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(&v3), arg2, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v3, arg4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    fun claim_by_address(arg0: address, arg1: u64, arg2: &mut 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::Custodian, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::Pandorian>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::get_metadata_by_address(arg2, arg0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::MintMetadata>(&v1)) {
            let v3 = 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::mint_nft_by_metadata(0x1::vector::pop_back<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::MintMetadata>(&mut v1), arg6);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::Pandorian>(&v3));
            0x2::kiosk::lock<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::Pandorian>(arg3, arg4, arg5, v3);
            v2 = v2 + 1;
        };
        let v4 = ClaimEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            claimed_nfts : v0,
            user_address : arg0,
        };
        0x2::event::emit<ClaimEvent>(v4);
        0x1::vector::destroy_empty<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::MintMetadata>(v1);
    }

    fun claim_by_nft(arg0: &mut 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::Custodian, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::Pandorian>, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::mint_nft_by_metadata(0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::get_metadata_by_id(arg0, arg4), arg5);
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::Pandorian>(&v1));
        0x2::kiosk::lock<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::Pandorian>(arg1, arg2, arg3, v1);
        let v2 = ClaimEvent{
            kiosk        : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            claimed_nfts : v0,
            user_address : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ClaimEvent>(v2);
    }

    public entry fun claim_to_kiosk_by_address(arg0: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg1: &mut 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::Custodian, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::transfer_policy::TransferPolicy<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::Pandorian>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::assert_current_version(arg0);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg2), 100);
        let v0 = 0x2::tx_context::sender(arg6);
        claim_by_address(v0, arg5, arg1, arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), arg4, arg6);
    }

    public entry fun claim_to_kiosk_by_nft<T0: store + key>(arg0: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg1: &mut 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::Custodian, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: 0x2::object::ID, arg5: &ProtectedTP<T0>, arg6: &0x2::transfer_policy::TransferPolicy<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::Pandorian>, arg7: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::assert_current_version(arg0);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg2), 100);
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3);
        let v1 = unlock_nft<T0>(arg2, v0, arg4, &arg5.transfer_policy, arg7);
        0x2::transfer::public_transfer<T0>(v1, @0x9bced8cb1de78bf4ac82694ea5c417da2c0745717ac0144c2d9561deeb2be13d);
        claim_by_nft(arg1, arg2, v0, arg6, arg4, arg7);
    }

    public entry fun claim_to_kiosk_by_nfts<T0: store + key>(arg0: &0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::Version, arg1: &mut 0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::custodian::Custodian, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: vector<0x2::object::ID>, arg5: &ProtectedTP<T0>, arg6: &0x2::transfer_policy::TransferPolicy<0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::pandorian::Pandorian>, arg7: &mut 0x2::tx_context::TxContext) {
        0x1887ccc981a41566178286303f52a423a4e72da0d04386a922e26e20880e1641::version::assert_current_version(arg0);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg2), 100);
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg4)) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg4);
            let v3 = unlock_nft<T0>(arg2, v0, v2, &arg5.transfer_policy, arg7);
            0x2::transfer::public_transfer<T0>(v3, @0x9bced8cb1de78bf4ac82694ea5c417da2c0745717ac0144c2d9561deeb2be13d);
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

