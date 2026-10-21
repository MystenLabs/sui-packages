module 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        restricted_keys: 0x2::vec_set::VecSet<0x1::ascii::String>,
        extra_fields: 0x2::bag::Bag,
    }

    public(friend) fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 1);
        Config{
            id              : 0x2::object::new(arg1),
            version         : 1,
            restricted_keys : 0x2::vec_set::empty<0x1::ascii::String>(),
            extra_fields    : 0x2::bag::new(arg1),
        }
    }

    public fun create_package_assistant_cap(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT> {
        assert_package_version(arg0);
        let v0 = 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::create_package_assistant_cap(&mut arg0.id, arg2);
        authorize_authority_cap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(arg0, &v0);
        v0
    }

    public fun create_package_revoke_vendor_guardian_cap(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::REVOKE_VENDOR_GUARDIAN> {
        assert_package_version(arg0);
        let v0 = 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::create_package_revoke_vendor_guardian_cap(&mut arg0.id, arg2);
        authorize_authority_cap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::REVOKE_VENDOR_GUARDIAN>(arg0, &v0);
        0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::events::emit_create_package_revoke_vendor_guardian_cap_event(0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::REVOKE_VENDOR_GUARDIAN>>(&v0));
        v0
    }

    public fun create_vendor_assistant_cap<T0>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT> {
        assert_package_version(arg0);
        assert_has_active_vendor_authority<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, arg1);
        let v0 = 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::create_vendor_assistant_cap<T0>(&mut arg0.id, arg2);
        authorize_authority_cap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(arg0, &v0);
        v0
    }

    public fun add_restricted_key<T0>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, T0>, arg2: 0x1::ascii::String) {
        assert_package_version(arg0);
        assert_has_active_package_authority<T0>(arg0, arg1);
        assert!(!0x2::vec_set::contains<0x1::ascii::String>(&arg0.restricted_keys, &arg2), 5);
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.restricted_keys, arg2);
    }

    public fun assert_has_active_package_authority<T0>(arg0: &Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, T0>) {
        assert!(has_package_authority<T0>(arg0, arg1), 2);
    }

    public fun assert_has_active_vendor_authority<T0, T1>(arg0: &Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, T1>) {
        assert!(has_vendor_authority<T0, T1>(arg0, arg1), 2);
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    fun authorize_authority_cap<T0, T1>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<T0, T1>) {
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::authorize_cap<T0, T1>(&mut arg0.id, arg1);
    }

    public(friend) fun borrow_mut_id(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun deauthorize_authority_cap<T0>(arg0: &mut Config, arg1: 0x2::object::ID) {
        assert!(is_authority_cap_authorized<T0>(arg0, arg1), 2);
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::deauthorize_cap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, T0>(&mut arg0.id, arg1);
    }

    public fun deauthorize_package_assistant_cap(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        deauthorize_authority_cap<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(arg0, arg2);
    }

    public fun deauthorize_package_revoke_vendor_guardian_cap(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        deauthorize_authority_cap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::REVOKE_VENDOR_GUARDIAN>(arg0, arg2);
        0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::events::emit_deauthorize_package_revoke_vendor_guardian_cap_event(arg2);
    }

    public fun deauthorize_vendor_assistant_cap<T0>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        assert_has_active_vendor_authority<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, arg1);
        deauthorize_vendor_authority_cap<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(arg0, arg2);
    }

    fun deauthorize_vendor_authority_cap<T0, T1>(arg0: &mut Config, arg1: 0x2::object::ID) {
        assert!(is_vendor_authority_cap_authorized<T0, T1>(arg0, arg1), 2);
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::deauthorize_cap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, T1>(&mut arg0.id, arg1);
    }

    public fun guardian_deauthorize_vendor_authority_cap<T0, T1>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::REVOKE_VENDOR_GUARDIAN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        assert!(is_authority_cap_authorized<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::REVOKE_VENDOR_GUARDIAN>(arg0, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::REVOKE_VENDOR_GUARDIAN>>(arg1)), 2);
        deauthorize_vendor_authority_cap<T0, T1>(arg0, arg2);
        0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::events::emit_guardian_revoke_vendor_authority_cap_event(0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg2);
    }

    public(friend) fun has_package_authority<T0>(arg0: &Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>() || v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>() && is_authority_cap_authorized<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(arg0, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, T0>>(arg1))
    }

    public(friend) fun has_vendor_authority<T0, T1>(arg0: &Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, T1>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>() && is_vendor_authority_cap_authorized<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, T1>>(arg1)) || v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>() && is_vendor_authority_cap_authorized<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(arg0, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, T1>>(arg1))
    }

    public fun is_authority_cap_active<T0, T1>(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<T0, T1>(&arg0.id, arg1)
    }

    fun is_authority_cap_authorized<T0>(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, T0>(&arg0.id, arg1)
    }

    public fun is_restricted_key(arg0: &Config, arg1: &0x1::ascii::String) : bool {
        0x2::vec_set::contains<0x1::ascii::String>(&arg0.restricted_keys, arg1)
    }

    public(friend) fun is_vendor_authority_cap_authorized<T0, T1>(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, T1>(&arg0.id, arg1)
    }

    public fun reauthorize_vendor_admin_cap<T0>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>) {
        assert_package_version(arg0);
        assert!(0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::exists<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(&arg0.id), 3);
        let v0 = 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::derived_cap_id<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(&arg0.id);
        assert!(!is_vendor_authority_cap_authorized<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, v0), 4);
        0x2::dynamic_field::add<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorizedAuthorityCapKey<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, bool>(&mut arg0.id, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::authorized_authority_cap_key<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(v0), true);
        0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::events::emit_reauthorize_vendor_admin_cap_event(0x1::type_name::with_defining_ids<T0>(), v0);
    }

    entry fun register_vendor<T0, T1>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, T1>, arg2: address) {
        assert_package_version(arg0);
        assert_has_active_package_authority<T1>(arg0, arg1);
        let v0 = 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::create_vendor_admin_cap<T0>(&mut arg0.id);
        authorize_authority_cap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, &v0);
        0x2::transfer::public_transfer<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>>(v0, arg2);
    }

    public fun remove_restricted_key<T0>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, T0>, arg2: 0x1::ascii::String) {
        assert_package_version(arg0);
        assert_has_active_package_authority<T0>(arg0, arg1);
        assert!(0x2::vec_set::contains<0x1::ascii::String>(&arg0.restricted_keys, &arg2), 6);
        0x2::vec_set::remove<0x1::ascii::String>(&mut arg0.restricted_keys, &arg2);
    }

    public fun upgrade_version<T0>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::PACKAGE, T0>) {
        assert!(arg0.version == 1 - 1, 0);
        assert_has_active_package_authority<T0>(arg0, arg1);
        arg0.version = 1;
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

