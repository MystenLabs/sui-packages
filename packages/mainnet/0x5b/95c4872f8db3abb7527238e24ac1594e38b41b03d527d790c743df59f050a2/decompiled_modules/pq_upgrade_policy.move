module 0x5b95c4872f8db3abb7527238e24ac1594e38b41b03d527d790c743df59f050a2::pq_upgrade_policy {
    struct PqUpgradePolicy has key {
        id: 0x2::object::UID,
        version: u8,
        cap: 0x2::package::UpgradeCap,
        classical_pk: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::SuiPublicKey,
        pq_pk: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::PqPublicKey,
        nonce: u64,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        package_id: 0x2::object::ID,
        creator: address,
        classical_pk: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::SuiPublicKey,
        pq_pk: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::PqPublicKey,
    }

    struct PolicyOperationPerformed has copy, drop {
        policy_id: 0x2::object::ID,
        op: u8,
        nonce: u64,
    }

    struct UpgradeAuthorized has copy, drop {
        policy_id: 0x2::object::ID,
        package_id: 0x2::object::ID,
        new_policy: u8,
        digest: vector<u8>,
        nonce: u64,
    }

    struct UpgradeCommitted has copy, drop {
        policy_id: 0x2::object::ID,
        old_package_id: 0x2::object::ID,
        new_package_id: 0x2::object::ID,
        cap_version: u64,
    }

    struct KeysRotated has copy, drop {
        policy_id: 0x2::object::ID,
        old_classical_pk: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::SuiPublicKey,
        new_classical_pk: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::SuiPublicKey,
        old_pq_pk: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::PqPublicKey,
        new_pq_pk: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::PqPublicKey,
        nonce: u64,
    }

    public fun authorize_upgrade(arg0: &mut PqUpgradePolicy, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) : 0x2::package::UpgradeTicket {
        assert!(is_policy_version_valid(arg0), 13835058901390721025);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13836747785611509773);
        let v0 = if (arg1 == 0x2::package::compatible_policy()) {
            true
        } else if (arg1 == 0x2::package::additive_policy()) {
            true
        } else {
            arg1 == 0x2::package::dep_only_policy()
        };
        assert!(v0, 13836466336404471819);
        let v1 = 0x2::package::upgrade_package(&arg0.cap);
        let v2 = msg_authorize_upgrade(0x2::object::id_address<PqUpgradePolicy>(arg0), arg0.nonce, 0x2::object::id_to_address(&v1), arg1, &arg2);
        authorize(arg0, &v2, &arg3, &arg4);
        let v3 = 0x2::package::authorize_upgrade(&mut arg0.cap, arg1, arg2);
        let v4 = UpgradeAuthorized{
            policy_id  : 0x2::object::id<PqUpgradePolicy>(arg0),
            package_id : 0x2::package::ticket_package(&v3),
            new_policy : arg1,
            digest     : *0x2::package::ticket_digest(&v3),
            nonce      : arg0.nonce,
        };
        0x2::event::emit<UpgradeAuthorized>(v4);
        advance_nonce(arg0, 1);
        v3
    }

    public fun commit_upgrade(arg0: &mut PqUpgradePolicy, arg1: 0x2::package::UpgradeReceipt) {
        assert!(is_policy_version_valid(arg0), 13835059094664249345);
        0x2::package::commit_upgrade(&mut arg0.cap, arg1);
        let v0 = UpgradeCommitted{
            policy_id      : 0x2::object::id<PqUpgradePolicy>(arg0),
            old_package_id : 0x2::package::upgrade_package(&arg0.cap),
            new_package_id : 0x2::package::receipt_package(&arg1),
            cap_version    : 0x2::package::version(&arg0.cap),
        };
        0x2::event::emit<UpgradeCommitted>(v0);
    }

    public fun make_immutable(arg0: PqUpgradePolicy, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(is_policy_version_valid(&arg0), 13835059313707581441);
        let v0 = 0x2::object::id<PqUpgradePolicy>(&arg0);
        let v1 = 0x2::package::upgrade_package(&arg0.cap);
        let v2 = arg0.nonce;
        let v3 = msg_make_immutable(0x2::object::id_to_address(&v0), v2, 0x2::object::id_to_address(&v1));
        authorize(&arg0, &v3, &arg1, &arg2);
        let PqUpgradePolicy {
            id           : v4,
            version      : _,
            cap          : v6,
            classical_pk : _,
            pq_pk        : _,
            nonce        : _,
        } = arg0;
        0x2::package::make_immutable(v6);
        0x2::object::delete(v4);
        let v10 = PolicyOperationPerformed{
            policy_id : v0,
            op        : 3,
            nonce     : v2,
        };
        0x2::event::emit<PolicyOperationPerformed>(v10);
    }

    public fun upgrade_policy(arg0: &PqUpgradePolicy) : u8 {
        0x2::package::upgrade_policy(&arg0.cap)
    }

    fun addr_text(arg0: address) : vector<u8> {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x2::address::to_string(arg0)));
        v0
    }

    fun advance_nonce(arg0: &mut PqUpgradePolicy, arg1: u8) {
        let v0 = arg0.nonce;
        arg0.nonce = v0 + 1;
        let v1 = PolicyOperationPerformed{
            policy_id : 0x2::object::id<PqUpgradePolicy>(arg0),
            op        : arg1,
            nonce     : v0,
        };
        0x2::event::emit<PolicyOperationPerformed>(v1);
    }

    fun append_field(arg0: &mut vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        0x1::vector::append<u8>(arg0, arg1);
        0x1::vector::append<u8>(arg0, b": ");
        0x1::vector::append<u8>(arg0, arg2);
        0x1::vector::append<u8>(arg0, x"0a");
    }

    fun append_field_no_lf(arg0: &mut vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        0x1::vector::append<u8>(arg0, arg1);
        0x1::vector::append<u8>(arg0, b": ");
        0x1::vector::append<u8>(arg0, arg2);
    }

    fun authorize(arg0: &PqUpgradePolicy, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>) {
        verify_dual_sig(&arg0.classical_pk, &arg0.pq_pk, arg1, arg2, arg3);
    }

    fun bytes_text(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(*arg0));
        v0
    }

    public fun cap_version(arg0: &PqUpgradePolicy) : u64 {
        0x2::package::version(&arg0.cap)
    }

    public fun classical_pk(arg0: &PqUpgradePolicy) : &0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::SuiPublicKey {
        &arg0.classical_pk
    }

    public fun is_policy_version_valid(arg0: &PqUpgradePolicy) : bool {
        arg0.version == 0
    }

    public fun message_for_authorize_upgrade(arg0: &PqUpgradePolicy, arg1: u8, arg2: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13836749366159474701);
        let v0 = if (arg1 == 0x2::package::compatible_policy()) {
            true
        } else if (arg1 == 0x2::package::additive_policy()) {
            true
        } else {
            arg1 == 0x2::package::dep_only_policy()
        };
        assert!(v0, 13836467916952436747);
        let v1 = 0x2::package::upgrade_package(&arg0.cap);
        msg_authorize_upgrade(0x2::object::id_address<PqUpgradePolicy>(arg0), arg0.nonce, 0x2::object::id_to_address(&v1), arg1, &arg2)
    }

    public fun message_for_make_immutable(arg0: &PqUpgradePolicy) : vector<u8> {
        let v0 = 0x2::package::upgrade_package(&arg0.cap);
        msg_make_immutable(0x2::object::id_address<PqUpgradePolicy>(arg0), arg0.nonce, 0x2::object::id_to_address(&v0))
    }

    public fun message_for_restrict_policy(arg0: &PqUpgradePolicy, arg1: u8) : vector<u8> {
        assert!(arg1 == 0x2::package::additive_policy() || arg1 == 0x2::package::dep_only_policy(), 13836467977081978891);
        let v0 = 0x2::package::upgrade_package(&arg0.cap);
        msg_restrict_policy(0x2::object::id_address<PqUpgradePolicy>(arg0), arg0.nonce, 0x2::object::id_to_address(&v0), arg1)
    }

    public fun message_for_rotate_keys(arg0: &PqUpgradePolicy, arg1: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::SuiPublicKey, arg2: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::PqPublicKey) : vector<u8> {
        assert!(0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::classical_pk_is_well_formed(&arg1), 13835342171663892483);
        assert!(0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::pq_pk_is_well_formed(&arg2), 13835623650935701509);
        msg_rotate_keys(0x2::object::id_address<PqUpgradePolicy>(arg0), arg0.nonce, &arg1, &arg2)
    }

    public fun msg_authorize_upgrade(arg0: address, arg1: u64, arg2: address, arg3: u8, arg4: &vector<u8>) : vector<u8> {
        let v0 = msg_header(b"authorize_upgrade");
        let v1 = &mut v0;
        append_field(v1, b"policy", addr_text(arg0));
        let v2 = &mut v0;
        append_field(v2, b"nonce", 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
        let v3 = &mut v0;
        append_field(v3, b"package", addr_text(arg2));
        let v4 = &mut v0;
        append_field(v4, b"new_policy", 0x1::string::into_bytes(0x1::u64::to_string((arg3 as u64))));
        let v5 = &mut v0;
        append_field_no_lf(v5, b"digest", bytes_text(arg4));
        v0
    }

    fun msg_header(arg0: vector<u8>) : vector<u8> {
        let v0 = b"pq_upgrade_policy::v0";
        0x1::vector::append<u8>(&mut v0, b" ");
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, x"0a");
        v0
    }

    public fun msg_make_immutable(arg0: address, arg1: u64, arg2: address) : vector<u8> {
        let v0 = msg_header(b"make_immutable");
        let v1 = &mut v0;
        append_field(v1, b"policy", addr_text(arg0));
        let v2 = &mut v0;
        append_field(v2, b"nonce", 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
        let v3 = &mut v0;
        append_field_no_lf(v3, b"package", addr_text(arg2));
        v0
    }

    public fun msg_restrict_policy(arg0: address, arg1: u64, arg2: address, arg3: u8) : vector<u8> {
        let v0 = msg_header(b"restrict_policy");
        let v1 = &mut v0;
        append_field(v1, b"policy", addr_text(arg0));
        let v2 = &mut v0;
        append_field(v2, b"nonce", 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
        let v3 = &mut v0;
        append_field(v3, b"package", addr_text(arg2));
        let v4 = &mut v0;
        append_field_no_lf(v4, b"new_policy", 0x1::string::into_bytes(0x1::u64::to_string((arg3 as u64))));
        v0
    }

    public fun msg_rotate_keys(arg0: address, arg1: u64, arg2: &0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::SuiPublicKey, arg3: &0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::PqPublicKey) : vector<u8> {
        let v0 = msg_header(b"rotate_keys");
        let v1 = &mut v0;
        append_field(v1, b"policy", addr_text(arg0));
        let v2 = &mut v0;
        append_field(v2, b"nonce", 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
        let v3 = &mut v0;
        append_field(v3, b"new_classical_pk", 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::classical_pk_text(arg2));
        let v4 = &mut v0;
        append_field_no_lf(v4, b"new_pq_pk", 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::pq_pk_text(arg3));
        v0
    }

    public fun msg_wrap(arg0: address, arg1: &0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::SuiPublicKey, arg2: &0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::PqPublicKey) : vector<u8> {
        let v0 = msg_header(b"wrap");
        let v1 = &mut v0;
        append_field(v1, b"package", addr_text(arg0));
        let v2 = &mut v0;
        append_field(v2, b"classical_pk", 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::classical_pk_text(arg1));
        let v3 = &mut v0;
        append_field_no_lf(v3, b"pq_pk", 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::pq_pk_text(arg2));
        v0
    }

    public fun nonce(arg0: &PqUpgradePolicy) : u64 {
        arg0.nonce
    }

    public fun package_id(arg0: &PqUpgradePolicy) : 0x2::object::ID {
        0x2::package::upgrade_package(&arg0.cap)
    }

    public fun pq_pk(arg0: &PqUpgradePolicy) : &0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::PqPublicKey {
        &arg0.pq_pk
    }

    public fun restrict_policy(arg0: &mut PqUpgradePolicy, arg1: u8, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(is_policy_version_valid(arg0), 13835059202038431745);
        let v0 = 0x2::package::additive_policy();
        assert!(arg1 == v0 || arg1 == 0x2::package::dep_only_policy(), 13836466589807542283);
        let v1 = 0x2::package::upgrade_package(&arg0.cap);
        let v2 = msg_restrict_policy(0x2::object::id_address<PqUpgradePolicy>(arg0), arg0.nonce, 0x2::object::id_to_address(&v1), arg1);
        authorize(arg0, &v2, &arg2, &arg3);
        if (arg1 == v0) {
            0x2::package::only_additive_upgrades(&mut arg0.cap);
        } else {
            0x2::package::only_dep_upgrades(&mut arg0.cap);
        };
        advance_nonce(arg0, 2);
    }

    public fun rotate_keys(arg0: &mut PqUpgradePolicy, arg1: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::SuiPublicKey, arg2: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::PqPublicKey, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) {
        assert!(is_policy_version_valid(arg0), 13835059511276077057);
        assert!(0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::classical_pk_is_well_formed(&arg1), 13835340990547886083);
        assert!(0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::pq_pk_is_well_formed(&arg2), 13835622469819695109);
        let v0 = msg_rotate_keys(0x2::object::id_address<PqUpgradePolicy>(arg0), arg0.nonce, &arg1, &arg2);
        assert!(0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::verify_classical(&arg0.classical_pk, &v0, &arg3), 13835903983451242503);
        assert!(0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::verify_classical(&arg1, &v0, &arg5), 13835903996336144391);
        assert!(0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::verify_pq(&arg0.pq_pk, &v0, &arg4), 13836185479902920713);
        assert!(0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::verify_pq(&arg2, &v0, &arg6), 13836185484197888009);
        arg0.classical_pk = arg1;
        arg0.pq_pk = arg2;
        let v1 = KeysRotated{
            policy_id        : 0x2::object::id<PqUpgradePolicy>(arg0),
            old_classical_pk : arg0.classical_pk,
            new_classical_pk : arg0.classical_pk,
            old_pq_pk        : arg0.pq_pk,
            new_pq_pk        : arg0.pq_pk,
            nonce            : arg0.nonce,
        };
        0x2::event::emit<KeysRotated>(v1);
        advance_nonce(arg0, 4);
    }

    fun verify_dual_sig(arg0: &0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::SuiPublicKey, arg1: &0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::PqPublicKey, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>) {
        assert!(0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::verify_classical(arg0, arg2, arg3), 13835904206789541895);
        assert!(0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::verify_pq(arg1, arg2, arg4), 13836185686061350921);
    }

    public fun wrap(arg0: 0x2::package::UpgradeCap, arg1: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::SuiPublicKey, arg2: 0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::PqPublicKey, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::classical_pk_is_well_formed(&arg1), 13835340174504099843);
        assert!(0x4f3980b23ecb9f61fd687d325a4fd89d3c3061fb9b4ff34cfe06f5744d46aa12::pq_keys::pq_pk_is_well_formed(&arg2), 13835621653775908869);
        let v0 = 0x2::package::upgrade_package(&arg0);
        let v1 = msg_wrap(0x2::object::id_to_address(&v0), &arg1, &arg2);
        verify_dual_sig(&arg1, &arg2, &v1, &arg3, &arg4);
        let v2 = PqUpgradePolicy{
            id           : 0x2::object::new(arg5),
            version      : 0,
            cap          : arg0,
            classical_pk : arg1,
            pq_pk        : arg2,
            nonce        : 0,
        };
        let v3 = PolicyCreated{
            policy_id    : 0x2::object::id<PqUpgradePolicy>(&v2),
            package_id   : v0,
            creator      : 0x2::tx_context::sender(arg5),
            classical_pk : v2.classical_pk,
            pq_pk        : v2.pq_pk,
        };
        0x2::event::emit<PolicyCreated>(v3);
        0x2::transfer::share_object<PqUpgradePolicy>(v2);
    }

    // decompiled from Move bytecode v7
}

