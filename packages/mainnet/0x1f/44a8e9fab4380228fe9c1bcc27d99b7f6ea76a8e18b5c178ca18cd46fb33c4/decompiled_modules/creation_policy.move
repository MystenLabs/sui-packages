module 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::creation_policy {
    struct CreationPolicy has key {
        id: 0x2::object::UID,
        allowed_quotes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        venues: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::DelayedSet<VenueKey, 0x1::type_name::TypeName>,
        partners: 0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::partner_list::PartnerList,
    }

    struct VenueKey has copy, drop, store {
        dummy_field: bool,
    }

    fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : CreationPolicy {
        let v0 = 0x2::object::new(arg1);
        let v1 = VenueKey{dummy_field: false};
        CreationPolicy{
            id             : v0,
            allowed_quotes : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            venues         : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::new<VenueKey, 0x1::type_name::TypeName>(v1, &v0, arg0),
            partners       : 0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::partner_list::new(&v0, arg1),
        }
    }

    public fun add_partner(arg0: &mut CreationPolicy, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::FeeAdmin>, arg3: &0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::blast_partners::Partner) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::partner_list::add(&mut arg0.partners, arg3);
    }

    public fun apply_venue<T0: drop>(arg0: &mut CreationPolicy, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::apply_add<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, 0x1::type_name::with_original_ids<T0>(), arg2);
    }

    public fun apply_venue_delay(arg0: &mut CreationPolicy, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::apply_delay<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, arg2);
    }

    public(friend) fun assert_allowed<T0>(arg0: &CreationPolicy, arg1: 0x1::type_name::TypeName) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &v0), 2);
        assert!(0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::contains<VenueKey, 0x1::type_name::TypeName>(&arg0.venues, &arg1), 3);
    }

    public(friend) fun assert_partner(arg0: &CreationPolicy, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::partner_list::assert_accepted(&arg0.partners, arg1, arg2);
    }

    public fun cancel_venue<T0: drop>(arg0: &mut CreationPolicy, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::CancelAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::cancel_add<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, 0x1::type_name::with_original_ids<T0>());
    }

    public fun cancel_venue_delay(arg0: &mut CreationPolicy, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::CancelAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::cancel_delay<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<CreationPolicy>(new(0, arg0));
    }

    public(friend) fun is_guarded(arg0: &CreationPolicy) : bool {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::is_guarded<VenueKey, 0x1::type_name::TypeName>(&arg0.venues)
    }

    public fun remove_partner(arg0: &mut CreationPolicy, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::FeeAdmin>, arg3: &0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::blast_partners::Partner, arg4: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::partner_list::remove(&mut arg0.partners, 0x2::object::id<0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::blast_partners::Partner>(arg3), arg4);
    }

    public fun remove_venue<T0: drop>(arg0: &mut CreationPolicy, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::VenueAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::remove<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, 0x1::type_name::with_original_ids<T0>());
    }

    public fun schedule_venue<T0: drop>(arg0: &mut CreationPolicy, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::VenueAdmin>, arg3: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 4);
        let v1 = 0x1::type_name::original_id<T0>();
        assert!(v1 != @0x1 && v1 != @0x2, 4);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::schedule_add<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, v0, arg3);
    }

    public fun schedule_venue_delay(arg0: &mut CreationPolicy, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::VenueAdmin>, arg3: u64, arg4: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::schedule_delay<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, arg3, arg4);
    }

    public fun set_quote_allowed<T0>(arg0: &mut CreationPolicy, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::ListingAdmin>, arg3: bool) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &v0) != arg3, 1);
        if (arg3) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_quotes, v0);
        } else {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_quotes, &v0);
        };
        0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::events::quote_allowed<T0>(arg3);
    }

    public fun unpause(arg0: &CreationPolicy, arg1: &mut 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_admin::UnpauseAdmin<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>>, arg3: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_admin::PackageAdmin<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg4: &0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::fee_policy::FeePolicy, arg5: &0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_treasury::Treasury, arg6: u8) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        let v0 = if (is_guarded(arg0)) {
            if (0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::fee_policy::is_guarded(arg4)) {
                0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_treasury::is_guarded(arg5)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_admin::clear_pause_bits<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE, 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::PackageWitness>(arg3, arg2, 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::package_witness(), arg1, arg6);
    }

    public fun venue_admission<T0: drop>(arg0: &CreationPolicy) : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::VenueAdmission {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::contains<VenueKey, 0x1::type_name::TypeName>(&arg0.venues, &v0), 3);
        0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::venue_admission<T0, 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::PackageWitness>(0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::package_witness())
    }

    // decompiled from Move bytecode v7
}

