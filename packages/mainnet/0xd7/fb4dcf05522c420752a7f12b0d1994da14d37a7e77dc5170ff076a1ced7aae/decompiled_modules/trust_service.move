module 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service {
    struct TrustServiceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Auth<phantom T0> has key {
        id: 0x2::object::UID,
        roles: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u32>,
        roles_abilities: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
        roles_owners: 0x2::bag::Bag,
    }

    struct AddressKey has copy, drop, store {
        owner: address,
    }

    struct Master has drop {
        dummy_field: bool,
    }

    struct Issuer has drop {
        dummy_field: bool,
    }

    struct TransferAgent has drop {
        dummy_field: bool,
    }

    struct Exchange has drop {
        dummy_field: bool,
    }

    struct None has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : Auth<T0> {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u32>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u32>(&mut v0, 0x1::type_name::with_defining_ids<Master>(), 0);
        0x2::vec_map::insert<0x1::type_name::TypeName, u32>(&mut v0, 0x1::type_name::with_defining_ids<Issuer>(), 0);
        0x2::vec_map::insert<0x1::type_name::TypeName, u32>(&mut v0, 0x1::type_name::with_defining_ids<TransferAgent>(), 0);
        0x2::vec_map::insert<0x1::type_name::TypeName, u32>(&mut v0, 0x1::type_name::with_defining_ids<Exchange>(), 0);
        let v1 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>();
        let v2 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v2, 0x1::type_name::with_defining_ids<0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetAbilities>());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v2, 0x1::type_name::with_defining_ids<0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetRoleTypes>());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v2, 0x1::type_name::with_defining_ids<0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetServiceOwner>());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v2, 0x1::type_name::with_defining_ids<0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetIssuer>());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v2, 0x1::type_name::with_defining_ids<0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetTransferAgent>());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v2, 0x1::type_name::with_defining_ids<0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetExchange>());
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v1, 0x1::type_name::with_defining_ids<Master>(), v2);
        let v3 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v3, 0x1::type_name::with_defining_ids<0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetTransferAgent>());
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v1, 0x1::type_name::with_defining_ids<TransferAgent>(), v3);
        let v4 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v4, 0x1::type_name::with_defining_ids<0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetIssuer>());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v4, 0x1::type_name::with_defining_ids<0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetExchange>());
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v1, 0x1::type_name::with_defining_ids<Issuer>(), v4);
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v1, 0x1::type_name::with_defining_ids<Exchange>(), 0x2::vec_set::empty<0x1::type_name::TypeName>());
        let v5 = TrustServiceKey<T0>{dummy_field: false};
        let v6 = Auth<T0>{
            id              : 0x2::derived_object::claim<TrustServiceKey<T0>>(arg0, v5),
            roles           : v0,
            roles_abilities : v1,
            roles_owners    : 0x2::bag::new(arg1),
        };
        let v7 = &mut v6;
        internal_assign_role<T0, Master>(v7, 0x2::tx_context::sender(arg1), arg1);
        v6
    }

    public fun add_role_ability<T0, T1: drop, T2: drop>(arg0: &mut Auth<T0>, arg1: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg1);
        assert!(owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetAbilities>(arg0, 0x2::tx_context::sender(arg2)), 13835622409690152965);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x1::type_name::with_defining_ids<T2>();
        if (v1 == 0x1::type_name::with_defining_ids<0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetServiceOwner>()) {
            assert!(v0 == 0x1::type_name::with_defining_ids<Master>(), 13838437189523341337);
        };
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u32>(&arg0.roles, &v0), 13836466877570351115);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.roles_abilities, &v0), 13837029831819001871);
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.roles_abilities, &v0);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(v2, &v1), 13837311323975712785);
        0x2::vec_set::insert<0x1::type_name::TypeName>(v2, v1);
    }

    public fun add_role_type<T0, T1, T2>(arg0: &mut Auth<T0>, arg1: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg1);
        assert!(owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetRoleTypes>(arg0, 0x2::tx_context::sender(arg2)), 13835622783352307717);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, u32>(&arg0.roles, &v0), 13837874604641878037);
        0x2::vec_map::insert<0x1::type_name::TypeName, u32>(&mut arg0.roles, v0, 0);
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.roles_abilities, v0, 0x2::vec_set::empty<0x1::type_name::TypeName>());
        let v1 = 0x1::type_name::with_defining_ids<Master>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.roles_abilities, &v1), 0x1::type_name::with_defining_ids<T2>());
    }

    public fun get_role<T0>(arg0: &Auth<T0>, arg1: address) : 0x1::type_name::TypeName {
        let v0 = AddressKey{owner: arg1};
        if (0x2::bag::contains<AddressKey>(&arg0.roles_owners, v0)) {
            *0x2::bag::borrow<AddressKey, 0x1::type_name::TypeName>(&arg0.roles_owners, v0)
        } else {
            0x1::type_name::with_defining_ids<None>()
        }
    }

    public(friend) fun internal_assign_role<T0, T1: drop>(arg0: &mut Auth<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u32>(&arg0.roles, &v0), 13836466611282378763);
        let v1 = AddressKey{owner: arg1};
        assert!(!0x2::bag::contains<AddressKey>(&arg0.roles_owners, v1), 13835059253578039297);
        0x2::bag::add<AddressKey, 0x1::type_name::TypeName>(&mut arg0.roles_owners, v1, v0);
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u32>(&mut arg0.roles, &v0) = *0x2::vec_map::get_mut<0x1::type_name::TypeName, u32>(&mut arg0.roles, &v0) + 1;
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_role_added_event<T0>(arg1, v0, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun internal_remove_role<T0, T1: drop>(arg0: &mut Auth<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = AddressKey{owner: arg1};
        assert!(0x2::bag::contains<AddressKey>(&arg0.roles_owners, v1), 13836185239384752137);
        assert!(0x2::bag::remove<AddressKey, 0x1::type_name::TypeName>(&mut arg0.roles_owners, v1) == v0, 13836748206518304781);
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u32>(&mut arg0.roles, &v0) = *0x2::vec_map::get_mut<0x1::type_name::TypeName, u32>(&mut arg0.roles, &v0) - 1;
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_role_removed_event<T0>(arg1, v0, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun owner_has_ability<T0, T1: drop>(arg0: &Auth<T0>, arg1: address) : bool {
        let v0 = AddressKey{owner: arg1};
        if (!0x2::bag::contains<AddressKey>(&arg0.roles_owners, v0)) {
            return false
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.roles_abilities, 0x2::bag::borrow<AddressKey, 0x1::type_name::TypeName>(&arg0.roles_owners, v0)), &v1)
    }

    public fun remove_exchange<T0>(arg0: &mut Auth<T0>, arg1: address, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetExchange>(arg0, 0x2::tx_context::sender(arg3)), 13835621786919895045);
        internal_remove_role<T0, Exchange>(arg0, arg1, arg3);
    }

    public fun remove_issuer<T0>(arg0: &mut Auth<T0>, arg1: address, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetIssuer>(arg0, 0x2::tx_context::sender(arg3)), 13835622053207867397);
        internal_remove_role<T0, Issuer>(arg0, arg1, arg3);
    }

    public fun remove_role_ability<T0, T1: drop, T2: drop>(arg0: &mut Auth<T0>, arg1: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg1);
        assert!(owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetAbilities>(arg0, 0x2::tx_context::sender(arg2)), 13835622555719041029);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x1::type_name::with_defining_ids<T2>();
        let v2 = v0 == 0x1::type_name::with_defining_ids<Master>() && v1 == 0x1::type_name::with_defining_ids<0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetAbilities>();
        assert!(!v2, 13835341123691872259);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u32>(&arg0.roles, &v0), 13836467032189173771);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.roles_abilities, &v0), 13837029986437824527);
        let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.roles_abilities, &v0);
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(v3, &v1), 13837592953571377171);
        0x2::vec_set::remove<0x1::type_name::TypeName>(v3, &v1);
    }

    public fun remove_role_type<T0, T1>(arg0: &mut Auth<T0>, arg1: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg1);
        assert!(owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetRoleTypes>(arg0, 0x2::tx_context::sender(arg2)), 13835622916496293893);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v0 != 0x1::type_name::with_defining_ids<Master>(), 13835341462994288643);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u32>(&arg0.roles, &v0), 13836467371491590155);
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, u32>(&mut arg0.roles, &v0);
        assert!(v2 == 0, 13838156238532509719);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.roles_abilities, &v0), 13837030351510044687);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.roles_abilities, &v0);
    }

    public fun remove_transfer_agent<T0>(arg0: &mut Auth<T0>, arg1: address, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetTransferAgent>(arg0, 0x2::tx_context::sender(arg3)), 13835621920063881221);
        internal_remove_role<T0, TransferAgent>(arg0, arg1, arg3);
    }

    public(friend) fun role_has_ability<T0, T1: drop, T2: drop>(arg0: &Auth<T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x1::type_name::with_defining_ids<T2>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.roles_abilities, &v0)) {
            return false
        };
        0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.roles_abilities, &v0), &v1)
    }

    public fun set_exchange<T0>(arg0: &mut Auth<T0>, arg1: address, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetExchange>(arg0, 0x2::tx_context::sender(arg3)), 13835621722495385605);
        internal_assign_role<T0, Exchange>(arg0, arg1, arg3);
    }

    public fun set_issuer<T0>(arg0: &mut Auth<T0>, arg1: address, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetIssuer>(arg0, 0x2::tx_context::sender(arg3)), 13835621988783357957);
        internal_assign_role<T0, Issuer>(arg0, arg1, arg3);
    }

    public fun set_service_owner<T0>(arg0: &mut Auth<T0>, arg1: address, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(arg1 != @0x0, 13838718346672603163);
        assert!(0x2::tx_context::sender(arg3) != arg1, 13835903601199153159);
        assert!(owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetServiceOwner>(arg0, 0x2::tx_context::sender(arg3)), 13835622130517278725);
        internal_remove_role<T0, Master>(arg0, 0x2::tx_context::sender(arg3), arg3);
        internal_assign_role<T0, Master>(arg0, arg1, arg3);
    }

    public fun set_transfer_agent<T0>(arg0: &mut Auth<T0>, arg1: address, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::SetTransferAgent>(arg0, 0x2::tx_context::sender(arg3)), 13835621855639371781);
        internal_assign_role<T0, TransferAgent>(arg0, arg1, arg3);
    }

    public(friend) fun share<T0>(arg0: Auth<T0>) {
        0x2::transfer::share_object<Auth<T0>>(arg0);
    }

    // decompiled from Move bytecode v7
}

