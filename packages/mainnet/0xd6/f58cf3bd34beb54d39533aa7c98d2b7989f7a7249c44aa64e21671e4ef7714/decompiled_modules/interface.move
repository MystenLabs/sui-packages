module 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::interface {
    public fun add_nft_type<T0: store + key>(arg0: &mut 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::DaoConfig, arg1: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::acl::AdminWitness<0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::dao::DAO>, arg2: &mut 0x2::tx_context::TxContext) {
        0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::add_nft_type<T0>(arg0);
    }

    public fun remove_nft_type<T0: store + key>(arg0: &mut 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::DaoConfig, arg1: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::acl::AdminWitness<0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::dao::DAO>, arg2: &mut 0x2::tx_context::TxContext) {
        0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::remove_nft_type<T0>(arg0);
    }

    public fun set_maximum_amount_of_participants(arg0: &mut 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::DaoConfig, arg1: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::acl::AdminWitness<0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::dao::DAO>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::set_maximum_amount_of_participants(arg0, arg2);
    }

    public fun set_min_yes_votes(arg0: &mut 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::DaoConfig, arg1: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::acl::AdminWitness<0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::dao::DAO>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::set_min_yes_votes(arg0, arg2);
    }

    public fun set_quorum(arg0: &mut 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::DaoConfig, arg1: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::acl::AdminWitness<0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::dao::DAO>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::set_quorum(arg0, arg2);
    }

    public fun execute(arg0: &mut 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::proposal::Proposal, arg1: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::DaoConfig, arg2: &0x2::clock::Clock, arg3: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) {
        0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::proposal::execute(arg0, arg1, arg2, arg3, arg4);
    }

    public fun propose(arg0: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::acl::AdminWitness<0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::dao::DAO>, arg1: &mut 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::DaoConfig, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: vector<0x1::string::String>, arg7: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) : 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::proposal::Proposal {
        0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::proposal::new(arg2, arg3, arg4, arg5, arg1, arg6, arg7, arg8)
    }

    public fun share_proposal(arg0: 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::proposal::Proposal, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::proposal::Proposal>(arg0);
    }

    public fun vote<T0: store + key>(arg0: &mut 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::proposal::Proposal, arg1: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::DaoConfig, arg2: &T0, arg3: u64, arg4: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::proposal::vote<T0>(arg0, arg1, 0x2::object::id<T0>(arg2), arg3, arg4, arg5);
    }

    public fun vote_from_kiosk<T0: store + key>(arg0: &mut 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::proposal::Proposal, arg1: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::DaoConfig, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::KioskOwnerCap, arg4: vector<0x2::object::ID>, arg5: u64, arg6: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<0x2::object::ID>(&mut arg4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg4)) {
            0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::proposal::vote<T0>(arg0, arg1, 0x2::object::id<T0>(0x2::kiosk::borrow_mut<T0>(arg2, arg3, 0x1::vector::pop_back<0x2::object::ID>(&mut arg4))), arg5, arg6, arg7);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg4);
    }

    public fun vote_from_personal_kiosk<T0: store + key>(arg0: &mut 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::proposal::Proposal, arg1: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::config::DaoConfig, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: vector<0x2::object::ID>, arg5: u64, arg6: &0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<0x2::object::ID>(&mut arg4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg4)) {
            0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::proposal::vote<T0>(arg0, arg1, 0x2::object::id<T0>(0x2::kiosk::borrow_mut<T0>(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), 0x1::vector::pop_back<0x2::object::ID>(&mut arg4))), arg5, arg6, arg7);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg4);
    }

    // decompiled from Move bytecode v6
}

