module 0x453550ea46b52b2c1c4897c30f7ff3d78e64117627af8145000c5026022be68d::issuer {
    struct CertificateAuthority has key {
        id: 0x2::object::UID,
        credentials: 0x2::table::Table<0x1::ascii::String, CertificateTemplate>,
        version: u8,
    }

    struct CertificateTemplate has store {
        owner: address,
        authority: address,
        status: u8,
        main_vault: address,
        escrow_vault: address,
        fee_rate: u8,
        credentials: 0x2::table::Table<0x2::object::ID, CredentialEntry>,
    }

    struct CredentialEntry has copy, drop, store {
        credential_type: 0x1::ascii::String,
        score: u64,
        sealed: bool,
    }

    struct TemplateCreated has copy, drop {
        template_id: 0x1::ascii::String,
        owner: address,
    }

    struct CredentialRegistered has copy, drop {
        template_id: 0x1::ascii::String,
        credential_id: 0x2::object::ID,
        credential_type: 0x1::ascii::String,
        score: u64,
    }

    struct IssuanceCompleted has copy, drop {
        template_id: 0x1::ascii::String,
        credential_id: 0x2::object::ID,
        result_score: u64,
    }

    public fun archive_sealed(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut CertificateAuthority, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CertificateTemplate>(&arg1.credentials, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CertificateTemplate>(&mut arg1.credentials, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.authority, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, CredentialEntry>(&v0.credentials, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, CredentialEntry>(&v0.credentials, arg3);
            !v3.sealed && v3.score > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, CredentialEntry>(&v0.credentials, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, CredentialEntry>(&mut v0.credentials, arg3).sealed = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.fee_rate as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.escrow_vault);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.main_vault);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.main_vault);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.escrow_vault);
        };
        let v7 = IssuanceCompleted{
            template_id   : arg2,
            credential_id : arg3,
            result_score  : v5,
        };
        0x2::event::emit<IssuanceCompleted>(v7);
    }

    public entry fun create_template(arg0: &mut CertificateAuthority, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = CertificateTemplate{
            owner        : 0x2::tx_context::sender(arg6),
            authority    : arg2,
            status       : 0,
            main_vault   : arg3,
            escrow_vault : arg4,
            fee_rate     : arg5,
            credentials  : 0x2::table::new<0x2::object::ID, CredentialEntry>(arg6),
        };
        0x2::table::add<0x1::ascii::String, CertificateTemplate>(&mut arg0.credentials, arg1, v0);
        let v1 = TemplateCreated{
            template_id : arg1,
            owner       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<TemplateCreated>(v1);
    }

    public fun get_credential_info(arg0: &CertificateAuthority, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, CertificateTemplate>(&arg0.credentials, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, CertificateTemplate>(&arg0.credentials, arg1);
        assert!(0x2::table::contains<0x2::object::ID, CredentialEntry>(&v0.credentials, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, CredentialEntry>(&v0.credentials, arg2);
        (v1.credential_type, v1.score, v1.sealed)
    }

    public fun get_credential_score(arg0: &CertificateAuthority, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, CertificateTemplate>(&arg0.credentials, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, CertificateTemplate>(&arg0.credentials, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, CredentialEntry>(&v0.credentials, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, CredentialEntry>(&v0.credentials, arg2);
        if (v1.sealed) {
            return 0
        };
        v1.score
    }

    public fun get_template_info(arg0: &CertificateAuthority, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, CertificateTemplate>(&arg0.credentials, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, CertificateTemplate>(&arg0.credentials, arg1);
        (v0.owner, v0.authority, v0.status & 1 != 0, v0.main_vault, v0.escrow_vault, v0.fee_rate)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CertificateAuthority{
            id          : 0x2::object::new(arg0),
            credentials : 0x2::table::new<0x1::ascii::String, CertificateTemplate>(arg0),
            version     : 1,
        };
        0x2::transfer::share_object<CertificateAuthority>(v0);
    }

    public fun issue_batch<T0>(arg0: &mut CertificateAuthority, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CertificateTemplate>(&arg0.credentials, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CertificateTemplate>(&mut arg0.credentials, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.authority, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v0.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, CredentialEntry>(&v0.credentials, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, CredentialEntry>(&mut v0.credentials, arg2).sealed = true;
        };
        let v3 = v2 * (v0.fee_rate as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.escrow_vault);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.main_vault);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.main_vault);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.escrow_vault);
        };
        let v4 = IssuanceCompleted{
            template_id   : arg1,
            credential_id : arg2,
            result_score  : v2,
        };
        0x2::event::emit<IssuanceCompleted>(v4);
    }

    public entry fun register_credential(arg0: &mut CertificateAuthority, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CertificateTemplate>(&arg0.credentials, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CertificateTemplate>(&mut arg0.credentials, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.authority, 100);
        let v2 = CredentialEntry{
            credential_type : arg3,
            score           : arg4,
            sealed          : false,
        };
        if (0x2::table::contains<0x2::object::ID, CredentialEntry>(&v0.credentials, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, CredentialEntry>(&mut v0.credentials, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, CredentialEntry>(&mut v0.credentials, arg2, v2);
        };
        let v3 = CredentialRegistered{
            template_id     : arg1,
            credential_id   : arg2,
            credential_type : arg3,
            score           : arg4,
        };
        0x2::event::emit<CredentialRegistered>(v3);
    }

    public entry fun seal_template(arg0: &mut CertificateAuthority, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CertificateTemplate>(&arg0.credentials, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CertificateTemplate>(&mut arg0.credentials, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public fun should_issue(arg0: &CertificateAuthority, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_credential_score(arg0, arg1, arg2) > 0
    }

    public fun stamp_credential<T0: store + key>(arg0: &mut CertificateAuthority, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CertificateTemplate>(&arg0.credentials, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CertificateTemplate>(&mut arg0.credentials, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.authority, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, CredentialEntry>(&v0.credentials, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, CredentialEntry>(&v0.credentials, arg2);
            !v3.sealed && v3.score > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, CredentialEntry>(&v0.credentials, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, CredentialEntry>(&mut v0.credentials, arg2).sealed = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.main_vault);
        let v4 = IssuanceCompleted{
            template_id   : arg1,
            credential_id : arg2,
            result_score  : 1,
        };
        0x2::event::emit<IssuanceCompleted>(v4);
    }

    public entry fun update_score(arg0: &mut CertificateAuthority, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, CertificateTemplate>(&arg0.credentials, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, CertificateTemplate>(&mut arg0.credentials, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.authority, 100);
        assert!(0x2::table::contains<0x2::object::ID, CredentialEntry>(&v0.credentials, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, CredentialEntry>(&mut v0.credentials, arg2).score = arg3;
    }

    // decompiled from Move bytecode v6
}

