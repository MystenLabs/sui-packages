module 0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::config {
    struct AuthorizedAuthorityCapKey<phantom T0, phantom T1> has copy, drop, store {
        cap_id: 0x2::object::ID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        extra_fields: 0x2::bag::Bag,
    }

    public(friend) fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339856676519939);
        Config{
            id           : 0x2::object::new(arg1),
            version      : 1,
            extra_fields : 0x2::bag::new(arg1),
        }
    }

    public fun create_package_assistant_cap(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        assert_package_version(arg0);
        let v0 = 0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::create_package_assistant_cap(&mut arg0.id, arg2);
        authorize_authority_cap(arg0, &v0);
        v0
    }

    public fun create_vendor_assistant_cap<T0>(arg0: &mut Config, arg1: &mut 0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::metadata::VendorMetadata<T0>, arg2: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg3: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        assert_package_version(arg0);
        let v0 = 0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::create_vendor_assistant_cap<T0>(&mut arg0.id, arg3);
        0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::metadata::authorize_vendor_assistant_cap<T0>(arg1, &v0);
        v0
    }

    public fun assert_has_active_package_authority<T0>(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, T0>) {
        assert!(has_package_authority<T0>(arg0, arg1), 13835622212121657349);
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835059223513268225);
    }

    fun authorize_authority_cap(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>) {
        let v0 = AuthorizedAuthorityCapKey<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>{cap_id: 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>>(arg1)};
        0x2::dynamic_field::add<AuthorizedAuthorityCapKey<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>, bool>(&mut arg0.id, v0, true);
    }

    public(friend) fun borrow_mut_id(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun current_version() : u64 {
        1
    }

    fun deauthorize_authority_cap(arg0: &mut Config, arg1: 0x2::object::ID) {
        assert!(is_authority_cap_authorized(arg0, arg1), 13835622371035447301);
        let v0 = AuthorizedAuthorityCapKey<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>{cap_id: arg1};
        0x2::dynamic_field::remove<AuthorizedAuthorityCapKey<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>, bool>(&mut arg0.id, v0);
    }

    public fun deauthorize_package_assistant_cap(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        deauthorize_authority_cap(arg0, arg2);
    }

    public fun deauthorize_vendor_assistant_cap<T0>(arg0: &mut Config, arg1: &mut 0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::metadata::VendorMetadata<T0>, arg2: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg3: 0x2::object::ID) {
        assert_package_version(arg0);
        0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::metadata::deauthorize_vendor_assistant_cap<T0>(arg1, arg3);
    }

    public(friend) fun has_package_authority<T0>(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>() || v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>() && is_authority_cap_authorized(arg0, 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, T0>>(arg1))
    }

    fun is_authority_cap_authorized(arg0: &Config, arg1: 0x2::object::ID) : bool {
        let v0 = AuthorizedAuthorityCapKey<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>{cap_id: arg1};
        0x2::dynamic_field::exists<AuthorizedAuthorityCapKey<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>>(&arg0.id, v0)
    }

    entry fun register_vendor<T0, T1>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, T1>, arg2: address, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String) {
        assert_package_version(arg0);
        assert_has_active_package_authority<T1>(arg0, arg1);
        0x2::transfer::public_transfer<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>>(0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::create_vendor_admin_cap<T0>(&mut arg0.id), arg2);
        0x2::transfer::public_share_object<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::metadata::VendorMetadata<T0>>(0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::metadata::new<T0>(&mut arg0.id, arg3, arg4));
    }

    public fun upgrade_version<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::PACKAGE, T0>) {
        assert!(arg0.version == 1 - 1, 13835058699527258113);
        assert_has_active_package_authority<T0>(arg0, arg1);
        arg0.version = 1;
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

