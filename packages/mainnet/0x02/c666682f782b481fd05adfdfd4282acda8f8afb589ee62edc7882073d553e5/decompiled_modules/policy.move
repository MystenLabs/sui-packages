module 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::policy {
    struct IdV1 has drop, store {
        tag: u8,
        version: u16,
        publication: address,
        nonce: u64,
    }

    public fun get_constants() : (u8, u16) {
        (0, 1)
    }

    public fun get_id_v1_fields(arg0: &IdV1) : (u8, u16, address, u64) {
        (arg0.tag, arg0.version, arg0.publication, arg0.nonce)
    }

    public fun parse_id_v1(arg0: &vector<u8>) : IdV1 {
        let v0 = 0x2::bcs::new(*arg0);
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        let v2 = 0x2::bcs::peel_u16(&mut v0);
        let v3 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v3) == 0, 602);
        assert!(v1 == 0, 603);
        assert!(v2 == 1, 604);
        IdV1{
            tag         : v1,
            version     : v2,
            publication : 0x2::bcs::peel_address(&mut v0),
            nonce       : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    entry fun seal_approve_free(arg0: vector<u8>, arg1: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg2: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg1);
        let v0 = parse_id_v1(&arg0);
        assert!(v0.publication == 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_publication_address(arg2), 601);
        assert!(!0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::requires_subscription(arg2), 605);
    }

    entry fun seal_approve_platform(arg0: vector<u8>, arg1: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg2: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::articles::PostArticleCap) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg1);
        parse_id_v1(&arg0);
    }

    entry fun seal_approve_publication_owner(arg0: vector<u8>, arg1: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg2: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::PublicationOwnerCap, arg3: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg1);
        let v0 = parse_id_v1(&arg0);
        assert!(v0.publication == 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_publication_address(arg3), 601);
        let v1 = 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_owner_cap_publication_id(arg2);
        assert!(0x2::object::id_to_address(&v1) == 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_publication_address(arg3), 605);
    }

    entry fun seal_approve_publication_subscription(arg0: vector<u8>, arg1: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg2: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication_subscription::PublicationSubscription, arg3: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg1);
        let v0 = parse_id_v1(&arg0);
        assert!(v0.publication == 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_publication_address(arg3), 601);
        assert!(0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication_subscription::validate_subscription_access(arg2, arg3, 0x2::tx_context::sender(arg5), arg4), 605);
    }

    entry fun seal_approve_roles(arg0: vector<u8>, arg1: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg2: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication, arg3: &0x2::tx_context::TxContext) {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg1);
        let v0 = parse_id_v1(&arg0);
        assert!(v0.publication == 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_publication_address(arg2), 601);
        assert!(0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::is_contributor(arg2, 0x2::tx_context::sender(arg3)), 605);
    }

    // decompiled from Move bytecode v7
}

