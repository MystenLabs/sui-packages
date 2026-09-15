module 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::agent_allowance {
    struct Allowance<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        principal: address,
        payee: address,
        delegate: 0x1::option::Option<address>,
        principal_public_key: vector<u8>,
        principal_signature_type: u8,
        escrow: 0x2::balance::Balance<T0>,
        rate_per_second: u64,
        spend_cap: u64,
        spent: u64,
        vested_floor: u64,
        anchor_ms: u64,
        authorized_total: u64,
        expiry_ms: u64,
        status: u8,
        created_at: u64,
    }

    struct AllowanceCreated has copy, drop {
        allowance_id: 0x2::object::ID,
        principal: address,
        payee: address,
        rate_per_second: u64,
        spend_cap: u64,
        expiry_ms: u64,
    }

    struct AllowanceClaimed has copy, drop {
        allowance_id: 0x2::object::ID,
        claimed_by: address,
        amount: u64,
        total_spent: u64,
    }

    struct AllowanceToppedUp has copy, drop {
        allowance_id: 0x2::object::ID,
        amount: u64,
        new_escrow: u64,
    }

    struct AllowanceVersionMigrated has copy, drop {
        allowance_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct AllowanceRateChanged has copy, drop {
        allowance_id: 0x2::object::ID,
        new_rate_per_second: u64,
        vested_floor: u64,
    }

    struct AllowanceCapIncreased has copy, drop {
        allowance_id: 0x2::object::ID,
        new_spend_cap: u64,
    }

    struct AllowancePaused has copy, drop {
        allowance_id: 0x2::object::ID,
        vested_floor: u64,
    }

    struct AllowanceResumed has copy, drop {
        allowance_id: 0x2::object::ID,
        rate_per_second: u64,
    }

    struct DelegateUpdated has copy, drop {
        allowance_id: 0x2::object::ID,
        delegate: 0x1::option::Option<address>,
    }

    struct SpendAuthorized has copy, drop {
        allowance_id: 0x2::object::ID,
        authorized_total: u64,
    }

    struct AllowanceRevoked has copy, drop {
        allowance_id: 0x2::object::ID,
        paid_to_payee: u64,
        refunded_to_principal: u64,
    }

    fun assert_admitted_version<T0>(arg0: &Allowance<T0>) {
        assert!(is_admitted_version<T0>(arg0), 13906837129281404937);
    }

    fun assert_claimer<T0>(arg0: &Allowance<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = if (v0 == arg0.payee) {
            true
        } else if (v0 == arg0.principal) {
            true
        } else {
            0x1::option::contains<address>(&arg0.delegate, &v0)
        };
        assert!(v1, 13906835875150430209);
    }

    public fun authorize_spend<T0>(arg0: &mut Allowance<T0>, arg1: u64, arg2: vector<u8>) {
        assert_admitted_version<T0>(arg0);
        assert!(arg0.status == 0, 13906836042654416901);
        assert!(arg1 > arg0.authorized_total, 13906836046950432789);
        assert!(arg1 <= arg0.spend_cap, 13906836051245137937);
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::is_valid_public_key_length(arg0.principal_signature_type, &arg0.principal_public_key), 13906836077014679565);
        let v0 = serialize_spend_authorization(0x2::object::id<Allowance<T0>>(arg0), arg1);
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::verify(arg0.principal_signature_type, &arg0.principal_public_key, &v0, &arg2), 13906836124259188747);
        arg0.authorized_total = arg1;
        let v1 = SpendAuthorized{
            allowance_id     : 0x2::object::id<Allowance<T0>>(arg0),
            authorized_total : arg1,
        };
        0x2::event::emit<SpendAuthorized>(v1);
    }

    public fun authorized_total<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.authorized_total
    }

    public fun available_to_claim<T0>(arg0: &Allowance<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.status != 0) {
            return 0
        };
        let v0 = entitled<T0>(arg0, 0x2::clock::timestamp_ms(arg1));
        let v1 = if (v0 > arg0.spent) {
            v0 - arg0.spent
        } else {
            0
        };
        0x1::u64::min(v1, 0x2::balance::value<T0>(&arg0.escrow))
    }

    public fun claim<T0>(arg0: &mut Allowance<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admitted_version<T0>(arg0);
        assert!(arg0.status == 0, 13906835930985267205);
        assert_claimer<T0>(arg0, arg3);
        assert!(arg1 > 0, 13906835943870038019);
        let v0 = entitled<T0>(arg0, 0x2::clock::timestamp_ms(arg2));
        let v1 = if (v0 > arg0.spent) {
            v0 - arg0.spent
        } else {
            0
        };
        assert!(arg1 <= arg0.spend_cap - arg0.spent, 13906835965345792017);
        assert!(arg1 <= v1, 13906835969640890387);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.escrow), 13906835973935595535);
        pull_internal<T0>(arg0, arg1, arg3);
    }

    public fun claim_with_voucher<T0>(arg0: &mut Allowance<T0>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        authorize_spend<T0>(arg0, arg1, arg2);
        claim<T0>(arg0, arg3, arg4, arg5);
    }

    public fun create_allowance<T0>(arg0: address, arg1: 0x1::option::Option<address>, arg2: vector<u8>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Allowance<T0> {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(v0 != arg0, 13906835291035271175);
        assert!(arg6 > 0, 13906835295329976323);
        assert!(0x2::coin::value<T0>(&arg4) > 0, 13906835299624943619);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg7 == 0 || arg7 > v1, 13906835316804812803);
        let v2 = &arg1;
        if (0x1::option::is_some<address>(v2)) {
            let v3 = 0x1::option::borrow<address>(v2);
            assert!(*v3 != v0 && *v3 != arg0, 13906835325395009543);
        };
        let v4 = 0x2::object::new(arg9);
        let v5 = AllowanceCreated{
            allowance_id    : 0x2::object::uid_to_inner(&v4),
            principal       : v0,
            payee           : arg0,
            rate_per_second : arg5,
            spend_cap       : arg6,
            expiry_ms       : arg7,
        };
        0x2::event::emit<AllowanceCreated>(v5);
        Allowance<T0>{
            id                       : v4,
            version                  : 1,
            principal                : v0,
            payee                    : arg0,
            delegate                 : arg1,
            principal_public_key     : arg2,
            principal_signature_type : arg3,
            escrow                   : 0x2::coin::into_balance<T0>(arg4),
            rate_per_second          : arg5,
            spend_cap                : arg6,
            spent                    : 0,
            vested_floor             : 0,
            anchor_ms                : v1,
            authorized_total         : 0,
            expiry_ms                : arg7,
            status                   : 0,
            created_at               : v1,
        }
    }

    public fun create_and_share_allowance<T0>(arg0: address, arg1: 0x1::option::Option<address>, arg2: vector<u8>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Allowance<T0>>(create_allowance<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public fun created_at<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.created_at
    }

    public fun current_version() : u64 {
        1
    }

    public fun delegate<T0>(arg0: &Allowance<T0>) : 0x1::option::Option<address> {
        arg0.delegate
    }

    fun entitled<T0>(arg0: &Allowance<T0>, arg1: u64) : u64 {
        0x1::u64::min(0x1::u64::max(rate_vested<T0>(arg0, arg1), arg0.authorized_total), arg0.spend_cap)
    }

    public fun entitled_at<T0>(arg0: &Allowance<T0>, arg1: u64) : u64 {
        entitled<T0>(arg0, arg1)
    }

    entry fun entry_claim<T0>(arg0: &mut Allowance<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        claim<T0>(arg0, arg1, arg2, arg3);
    }

    entry fun entry_claim_with_voucher<T0>(arg0: &mut Allowance<T0>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        claim_with_voucher<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun entry_create_and_share<T0>(arg0: address, arg1: 0x1::option::Option<address>, arg2: vector<u8>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        create_and_share_allowance<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    entry fun entry_revoke<T0>(arg0: &mut Allowance<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        revoke<T0>(arg0, arg1, arg2);
    }

    entry fun entry_top_up<T0>(arg0: &mut Allowance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        top_up<T0>(arg0, arg1, arg2);
    }

    public fun escrow_balance<T0>(arg0: &Allowance<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun expiry_ms<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.expiry_ms
    }

    public fun increase_cap<T0>(arg0: &mut Allowance<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_admitted_version<T0>(arg0);
        assert!(arg0.status != 2, 13906836437791408133);
        assert!(0x2::tx_context::sender(arg2) == arg0.principal, 13906836442086113281);
        assert!(arg1 > arg0.spend_cap, 13906836446381211651);
        arg0.spend_cap = arg1;
        let v0 = AllowanceCapIncreased{
            allowance_id  : 0x2::object::id<Allowance<T0>>(arg0),
            new_spend_cap : arg1,
        };
        0x2::event::emit<AllowanceCapIncreased>(v0);
    }

    public fun is_active<T0>(arg0: &Allowance<T0>) : bool {
        arg0.status == 0
    }

    public fun is_admitted_version<T0>(arg0: &Allowance<T0>) : bool {
        version_is_admitted(1, arg0.version)
    }

    public fun is_current_version<T0>(arg0: &Allowance<T0>) : bool {
        arg0.version == 1
    }

    public fun migrate_version<T0>(arg0: &mut Allowance<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.principal, 13906837167935586305);
        assert!(arg0.version + 1 == 1, 13906837172231077897);
        arg0.version = 1;
        let v0 = AllowanceVersionMigrated{
            allowance_id : 0x2::object::id<Allowance<T0>>(arg0),
            from_version : arg0.version,
            to_version   : 1,
        };
        0x2::event::emit<AllowanceVersionMigrated>(v0);
    }

    public fun pause<T0>(arg0: &mut Allowance<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_admitted_version<T0>(arg0);
        assert!(arg0.status == 0, 13906836506510884869);
        assert!(0x2::tx_context::sender(arg2) == arg0.principal, 13906836510805590017);
        reanchor<T0>(arg0, 0x2::clock::timestamp_ms(arg1));
        arg0.status = 1;
        let v0 = AllowancePaused{
            allowance_id : 0x2::object::id<Allowance<T0>>(arg0),
            vested_floor : arg0.vested_floor,
        };
        0x2::event::emit<AllowancePaused>(v0);
    }

    public fun payee<T0>(arg0: &Allowance<T0>) : address {
        arg0.payee
    }

    public fun principal<T0>(arg0: &Allowance<T0>) : address {
        arg0.principal
    }

    fun pull_internal<T0>(arg0: &mut Allowance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.spent = arg0.spent + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, arg1), arg2), arg0.payee);
        let v0 = AllowanceClaimed{
            allowance_id : 0x2::object::id<Allowance<T0>>(arg0),
            claimed_by   : 0x2::tx_context::sender(arg2),
            amount       : arg1,
            total_spent  : arg0.spent,
        };
        0x2::event::emit<AllowanceClaimed>(v0);
    }

    public fun rate_per_second<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.rate_per_second
    }

    fun rate_vested<T0>(arg0: &Allowance<T0>, arg1: u64) : u64 {
        if (arg0.status != 0) {
            return 0x1::u64::min(arg0.vested_floor, arg0.spend_cap)
        };
        let v0 = if (arg0.expiry_ms == 0) {
            arg1
        } else {
            0x1::u64::min(arg0.expiry_ms, arg1)
        };
        let v1 = if (v0 > arg0.anchor_ms) {
            (v0 - arg0.anchor_ms) / 1000
        } else {
            0
        };
        (0x1::u128::min((arg0.vested_floor as u128) + (arg0.rate_per_second as u128) * (v1 as u128), (arg0.spend_cap as u128)) as u64)
    }

    fun reanchor<T0>(arg0: &mut Allowance<T0>, arg1: u64) {
        arg0.vested_floor = rate_vested<T0>(arg0, arg1);
        arg0.anchor_ms = arg1;
    }

    public fun resume<T0>(arg0: &mut Allowance<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_admitted_version<T0>(arg0);
        assert!(arg0.status == 1, 13906836575230361605);
        assert!(0x2::tx_context::sender(arg2) == arg0.principal, 13906836579525066753);
        arg0.anchor_ms = 0x2::clock::timestamp_ms(arg1);
        arg0.status = 0;
        let v0 = AllowanceResumed{
            allowance_id    : 0x2::object::id<Allowance<T0>>(arg0),
            rate_per_second : arg0.rate_per_second,
        };
        0x2::event::emit<AllowanceResumed>(v0);
    }

    public fun revoke<T0>(arg0: &mut Allowance<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admitted_version<T0>(arg0);
        assert!(arg0.status != 2, 13906836738439118853);
        assert!(0x2::tx_context::sender(arg2) == arg0.principal, 13906836742733824001);
        let v0 = entitled<T0>(arg0, 0x2::clock::timestamp_ms(arg1));
        let v1 = if (v0 > arg0.spent) {
            v0 - arg0.spent
        } else {
            0
        };
        let v2 = 0x1::u64::min(v1, 0x2::balance::value<T0>(&arg0.escrow));
        if (v2 > 0) {
            arg0.spent = arg0.spent + v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v2), arg2), arg0.payee);
        };
        let v3 = 0x2::balance::value<T0>(&arg0.escrow);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v3), arg2), arg0.principal);
        };
        arg0.status = 2;
        let v4 = AllowanceRevoked{
            allowance_id          : 0x2::object::id<Allowance<T0>>(arg0),
            paid_to_payee         : v2,
            refunded_to_principal : v3,
        };
        0x2::event::emit<AllowanceRevoked>(v4);
    }

    public fun serialize_spend_authorization(arg0: 0x2::object::ID, arg1: u64) : vector<u8> {
        let v0 = b"sui_tunnel::spend_authorization";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg1));
        v0
    }

    public fun set_delegate<T0>(arg0: &mut Allowance<T0>, arg1: 0x1::option::Option<address>, arg2: &0x2::tx_context::TxContext) {
        assert_admitted_version<T0>(arg0);
        assert!(arg0.status != 2, 13906836656834740229);
        assert!(0x2::tx_context::sender(arg2) == arg0.principal, 13906836661129445377);
        let v0 = &arg1;
        if (0x1::option::is_some<address>(v0)) {
            let v1 = 0x1::option::borrow<address>(v0);
            assert!(*v1 != arg0.principal && *v1 != arg0.payee, 13906836669719773191);
        };
        arg0.delegate = arg1;
        let v2 = DelegateUpdated{
            allowance_id : 0x2::object::id<Allowance<T0>>(arg0),
            delegate     : arg1,
        };
        0x2::event::emit<DelegateUpdated>(v2);
    }

    public fun set_rate<T0>(arg0: &mut Allowance<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_admitted_version<T0>(arg0);
        assert!(arg0.status == 0, 13906836364776964101);
        assert!(0x2::tx_context::sender(arg3) == arg0.principal, 13906836369071669249);
        reanchor<T0>(arg0, 0x2::clock::timestamp_ms(arg2));
        arg0.rate_per_second = arg1;
        let v0 = AllowanceRateChanged{
            allowance_id        : 0x2::object::id<Allowance<T0>>(arg0),
            new_rate_per_second : arg1,
            vested_floor        : arg0.vested_floor,
        };
        0x2::event::emit<AllowanceRateChanged>(v0);
    }

    public fun spend_cap<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.spend_cap
    }

    public fun spent<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.spent
    }

    public fun status<T0>(arg0: &Allowance<T0>) : u8 {
        arg0.status
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_paused() : u8 {
        1
    }

    public fun status_revoked() : u8 {
        2
    }

    public fun top_up<T0>(arg0: &mut Allowance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_admitted_version<T0>(arg0);
        assert!(arg0.status != 2, 13906836265992716293);
        assert!(0x2::tx_context::sender(arg2) == arg0.principal, 13906836270287421441);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 13906836274582519811);
        0x2::balance::join<T0>(&mut arg0.escrow, 0x2::coin::into_balance<T0>(arg1));
        let v0 = AllowanceToppedUp{
            allowance_id : 0x2::object::id<Allowance<T0>>(arg0),
            amount       : 0x2::coin::value<T0>(&arg1),
            new_escrow   : 0x2::balance::value<T0>(&arg0.escrow),
        };
        0x2::event::emit<AllowanceToppedUp>(v0);
    }

    public fun version<T0>(arg0: &Allowance<T0>) : u64 {
        arg0.version
    }

    public fun version_is_admitted(arg0: u64, arg1: u64) : bool {
        arg1 == arg0 || arg0 > 1 && arg1 == arg0 - 1
    }

    // decompiled from Move bytecode v7
}

