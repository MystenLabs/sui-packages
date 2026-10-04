module 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::creation_policy {
    struct CreationPolicy has key {
        id: 0x2::object::UID,
        allowed_quotes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        allowed_migration_witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct QuoteSet has copy, drop {
        quote: 0x1::type_name::TypeName,
        allowed: bool,
    }

    struct MigrationWitnessSet has copy, drop {
        migration_witness: 0x1::type_name::TypeName,
        allowed: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : CreationPolicy {
        CreationPolicy{
            id                          : 0x2::object::new(arg0),
            allowed_quotes              : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            allowed_migration_witnesses : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun assert_allowed<T0, T1>(arg0: &CreationPolicy) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &v0), 13835339835201683459);
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_migration_witnesses, &v1), 13835621335948328965);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<CreationPolicy>(new(arg0));
    }

    public fun set_migration_witness_allowed<T0: drop>(arg0: &mut CreationPolicy, arg1: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale_admin::AdminRegistry, arg2: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale_admin::AdminCap, arg3: bool) {
        0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale_admin::assert_admin_cap(arg1, arg2);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_migration_witnesses, &v0) != arg3, 13835058295800332289);
        if (arg3) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_migration_witnesses, v0);
        } else {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_migration_witnesses, &v0);
        };
        let v1 = MigrationWitnessSet{
            migration_witness : v0,
            allowed           : arg3,
        };
        0x2::event::emit<MigrationWitnessSet>(v1);
    }

    public fun set_quote_allowed<T0>(arg0: &mut CreationPolicy, arg1: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale_admin::AdminRegistry, arg2: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale_admin::AdminCap, arg3: bool) {
        0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale_admin::assert_admin_cap(arg1, arg2);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &v0) != arg3, 13835058214195953665);
        if (arg3) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_quotes, v0);
        } else {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_quotes, &v0);
        };
        let v1 = QuoteSet{
            quote   : v0,
            allowed : arg3,
        };
        0x2::event::emit<QuoteSet>(v1);
    }

    // decompiled from Move bytecode v7
}

