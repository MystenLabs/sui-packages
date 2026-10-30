module 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::roles {
    struct Roles has store {
        members: 0x2::bag::Bag,
        owner: 0x1::option::Option<address>,
        pending_owner: 0x1::option::Option<OwnerNomination>,
    }

    struct OwnerNomination has copy, drop, store {
        nominee: address,
        expires_at_ms: u64,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        pos0: address,
    }

    struct ProtocolAdminRole has drop {
        dummy_field: bool,
    }

    struct VaultCreatorRole has drop {
        dummy_field: bool,
    }

    struct OwnerRole has drop {
        dummy_field: bool,
    }

    struct OperatorRole has drop {
        dummy_field: bool,
    }

    struct PauserRole has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: 0x1::option::Option<address>, arg1: &mut 0x2::tx_context::TxContext) : Roles {
        let v0 = &arg0;
        if (0x1::option::is_some<address>(v0)) {
            assert!(*0x1::option::borrow<address>(v0) != @0x0, 13835058377404776450);
        };
        Roles{
            members       : 0x2::bag::new(arg1),
            owner         : arg0,
            pending_owner : 0x1::option::none<OwnerNomination>(),
        }
    }

    public(friend) fun accept_owner(arg0: &mut Roles, arg1: address, arg2: u64) {
        assert!(0x1::option::is_some<address>(&arg0.owner), 13835621679545778182);
        assert!(0x1::option::is_some<OwnerNomination>(&arg0.pending_owner), 13836184633794428938);
        let v0 = *0x1::option::borrow<OwnerNomination>(&arg0.pending_owner);
        assert!(arg1 == v0.nominee, 13836466117361205260);
        assert!(arg2 <= v0.expires_at_ms, 13836747596633014286);
        arg0.owner = 0x1::option::some<address>(arg1);
        arg0.pending_owner = 0x1::option::none<OwnerNomination>();
    }

    public(friend) fun can_pause<T0: drop>() : bool {
        is_owner_role<T0>() || 0x1::type_name::with_original_ids<T0>() == 0x1::type_name::with_original_ids<PauserRole>()
    }

    public(friend) fun cancel_owner_nomination(arg0: &mut Roles) : OwnerNomination {
        assert!(0x1::option::is_some<OwnerNomination>(&arg0.pending_owner), 13836184595139723274);
        0x1::option::extract<OwnerNomination>(&mut arg0.pending_owner)
    }

    public fun expires_at_ms(arg0: &OwnerNomination) : u64 {
        arg0.expires_at_ms
    }

    public(friend) fun grant<T0: drop>(arg0: &mut Roles, arg1: address) : bool {
        assert!(!is_owner_role<T0>(), 13835340002705473540);
        assert!(arg1 != @0x0, 13835058532023599106);
        let v0 = RoleKey<T0>{pos0: arg1};
        let v1 = !0x2::bag::contains<RoleKey<T0>>(&arg0.members, v0);
        if (v1) {
            0x2::bag::add<RoleKey<T0>, bool>(&mut arg0.members, v0, true);
        };
        v1
    }

    public fun has_role<T0: drop>(arg0: &Roles, arg1: address) : bool {
        if (is_owner_role<T0>()) {
            arg0.owner == 0x1::option::some<address>(arg1)
        } else {
            let v1 = RoleKey<T0>{pos0: arg1};
            0x2::bag::contains<RoleKey<T0>>(&arg0.members, v1)
        }
    }

    fun is_owner_role<T0: drop>() : bool {
        0x1::type_name::with_original_ids<T0>() == 0x1::type_name::with_original_ids<OwnerRole>()
    }

    public(friend) fun nominate_owner(arg0: &mut Roles, arg1: address, arg2: u64) {
        assert!(0x1::option::is_some<address>(&arg0.owner), 13835621589351464966);
        assert!(arg1 != @0x0, 13835058643692748802);
        assert!(arg0.owner != 0x1::option::some<address>(arg1), 13835903072918241288);
        assert!(arg2 <= 18446744073709551615 - 86400000, 13837028977120575504);
        let v0 = OwnerNomination{
            nominee       : arg1,
            expires_at_ms : arg2 + 86400000,
        };
        arg0.pending_owner = 0x1::option::some<OwnerNomination>(v0);
    }

    public fun nominee(arg0: &OwnerNomination) : address {
        arg0.nominee
    }

    public fun owner(arg0: &Roles) : 0x1::option::Option<address> {
        arg0.owner
    }

    public fun pending_owner(arg0: &Roles) : 0x1::option::Option<OwnerNomination> {
        arg0.pending_owner
    }

    public(friend) fun revoke<T0: drop>(arg0: &mut Roles, arg1: address) : bool {
        assert!(!is_owner_role<T0>(), 13835340062835015684);
        let v0 = RoleKey<T0>{pos0: arg1};
        let v1 = 0x2::bag::contains<RoleKey<T0>>(&arg0.members, v0);
        if (v1) {
            0x2::bag::remove<RoleKey<T0>, bool>(&mut arg0.members, v0);
        };
        v1
    }

    // decompiled from Move bytecode v7
}

