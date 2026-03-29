module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata {
    struct DappMetadata has copy, drop, store {
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        website_url: 0x1::ascii::String,
        cover_url: vector<0x1::ascii::String>,
        partners: vector<0x1::ascii::String>,
        package_ids: vector<address>,
        created_at: u64,
        admin: address,
        pending_admin: address,
        version: u32,
        pausable: bool,
    }

    public fun new(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: u64, arg7: address, arg8: address, arg9: u32, arg10: bool) : DappMetadata {
        DappMetadata{
            name          : arg0,
            description   : arg1,
            website_url   : arg2,
            cover_url     : arg3,
            partners      : arg4,
            package_ids   : arg5,
            created_at    : arg6,
            admin         : arg7,
            pending_admin : arg8,
            version       : arg9,
            pausable      : arg10,
        }
    }

    public fun admin(arg0: &DappMetadata) : address {
        arg0.admin
    }

    public fun cover_url(arg0: &DappMetadata) : vector<0x1::ascii::String> {
        arg0.cover_url
    }

    public fun created_at(arg0: &DappMetadata) : u64 {
        arg0.created_at
    }

    public fun decode(arg0: vector<u8>) : DappMetadata {
        let v0 = 0x2::bcs::new(arg0);
        DappMetadata{
            name          : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            description   : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            website_url   : 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)),
            cover_url     : 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_vec_string(&mut v0),
            partners      : 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_vec_string(&mut v0),
            package_ids   : 0x2::bcs::peel_vec_address(&mut v0),
            created_at    : 0x2::bcs::peel_u64(&mut v0),
            admin         : 0x2::bcs::peel_address(&mut v0),
            pending_admin : 0x2::bcs::peel_address(&mut v0),
            version       : 0x2::bcs::peel_u32(&mut v0),
            pausable      : 0x2::bcs::peel_bool(&mut v0),
        }
    }

    public(friend) fun delete(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::delete_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, arg1);
    }

    public fun description(arg0: &DappMetadata) : 0x1::ascii::String {
        arg0.description
    }

    public fun encode(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: u64, arg7: address, arg8: address, arg9: u32, arg10: bool) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0x1::ascii::into_bytes(arg0);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&v1));
        let v2 = 0x1::ascii::into_bytes(arg1);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&v2));
        let v3 = 0x1::ascii::into_bytes(arg2);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&v3));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<vector<0x1::ascii::String>>(&arg3));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<vector<0x1::ascii::String>>(&arg4));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<vector<address>>(&arg5));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<address>(&arg7));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<address>(&arg8));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg9));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<bool>(&arg10));
        v0
    }

    public fun encode_struct(arg0: DappMetadata) : vector<vector<u8>> {
        encode(arg0.name, arg0.description, arg0.website_url, arg0.cover_url, arg0.partners, arg0.package_ids, arg0.created_at, arg0.admin, arg0.pending_admin, arg0.version, arg0.pausable)
    }

    public fun ensure_has(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::ensure_has_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0);
    }

    public fun ensure_has_not(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::ensure_has_not_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0);
    }

    public fun get(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : (0x1::ascii::String, 0x1::ascii::String, 0x1::ascii::String, vector<0x1::ascii::String>, vector<0x1::ascii::String>, vector<address>, u64, address, address, u32, bool) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0));
        (0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_string(&mut v1), 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_string(&mut v1), 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_string(&mut v1), 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_vec_string(&mut v1), 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_vec_string(&mut v1), 0x2::bcs::peel_vec_address(&mut v1), 0x2::bcs::peel_u64(&mut v1), 0x2::bcs::peel_address(&mut v1), 0x2::bcs::peel_address(&mut v1), 0x2::bcs::peel_u32(&mut v1), 0x2::bcs::peel_bool(&mut v1))
    }

    public fun get_admin(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : address {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 7));
        0x2::bcs::peel_address(&mut v1)
    }

    public fun get_cover_url(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : vector<0x1::ascii::String> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 3));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_vec_string(&mut v1)
    }

    public fun get_created_at(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : u64 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 6));
        0x2::bcs::peel_u64(&mut v1)
    }

    public fun get_description(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 1));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_string(&mut v1)
    }

    public fun get_name(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 0));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_string(&mut v1)
    }

    public fun get_package_ids(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : vector<address> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 5));
        0x2::bcs::peel_vec_address(&mut v1)
    }

    public fun get_partners(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : vector<0x1::ascii::String> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 4));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_vec_string(&mut v1)
    }

    public fun get_pausable(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : bool {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 10));
        0x2::bcs::peel_bool(&mut v1)
    }

    public fun get_pending_admin(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : address {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 8));
        0x2::bcs::peel_address(&mut v1)
    }

    public fun get_struct(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : DappMetadata {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        decode(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0))
    }

    public fun get_version(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : u32 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 9));
        0x2::bcs::peel_u32(&mut v1)
    }

    public fun get_website_url(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 2));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::bcs::peel_string(&mut v1)
    }

    public fun has(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : bool {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::has_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0)
    }

    public fun name(arg0: &DappMetadata) : 0x1::ascii::String {
        arg0.name
    }

    public fun package_ids(arg0: &DappMetadata) : vector<address> {
        arg0.package_ids
    }

    public fun partners(arg0: &DappMetadata) : vector<0x1::ascii::String> {
        arg0.partners
    }

    public fun pausable(arg0: &DappMetadata) : bool {
        arg0.pausable
    }

    public fun pending_admin(arg0: &DappMetadata) : address {
        arg0.pending_admin
    }

    public(friend) fun set(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: vector<address>, arg8: u64, arg9: address, arg10: address, arg11: u32, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, encode(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12), arg1, false, arg13);
    }

    public(friend) fun set_admin(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 7, 0x2::bcs::to_bytes<address>(&arg2), arg3);
    }

    public(friend) fun set_cover_url(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: vector<0x1::ascii::String>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 3, 0x2::bcs::to_bytes<vector<0x1::ascii::String>>(&arg2), arg3);
    }

    public(friend) fun set_created_at(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 6, 0x2::bcs::to_bytes<u64>(&arg2), arg3);
    }

    public(friend) fun set_description(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x1::ascii::into_bytes(arg2);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 1, 0x2::bcs::to_bytes<vector<u8>>(&v1), arg3);
    }

    public(friend) fun set_name(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x1::ascii::into_bytes(arg2);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 0, 0x2::bcs::to_bytes<vector<u8>>(&v1), arg3);
    }

    public(friend) fun set_package_ids(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 5, 0x2::bcs::to_bytes<vector<address>>(&arg2), arg3);
    }

    public(friend) fun set_partners(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: vector<0x1::ascii::String>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 4, 0x2::bcs::to_bytes<vector<0x1::ascii::String>>(&arg2), arg3);
    }

    public(friend) fun set_pausable(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 10, 0x2::bcs::to_bytes<bool>(&arg2), arg3);
    }

    public(friend) fun set_pending_admin(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 8, 0x2::bcs::to_bytes<address>(&arg2), arg3);
    }

    public(friend) fun set_struct(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: DappMetadata, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, encode_struct(arg2), arg1, false, arg3);
    }

    public(friend) fun set_version(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 9, 0x2::bcs::to_bytes<u32>(&arg2), arg3);
    }

    public(friend) fun set_website_url(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_metadata");
        let v1 = 0x1::ascii::into_bytes(arg2);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 2, 0x2::bcs::to_bytes<vector<u8>>(&v1), arg3);
    }

    public fun update_admin(arg0: &mut DappMetadata, arg1: address) {
        arg0.admin = arg1;
    }

    public fun update_cover_url(arg0: &mut DappMetadata, arg1: vector<0x1::ascii::String>) {
        arg0.cover_url = arg1;
    }

    public fun update_created_at(arg0: &mut DappMetadata, arg1: u64) {
        arg0.created_at = arg1;
    }

    public fun update_description(arg0: &mut DappMetadata, arg1: 0x1::ascii::String) {
        arg0.description = arg1;
    }

    public fun update_name(arg0: &mut DappMetadata, arg1: 0x1::ascii::String) {
        arg0.name = arg1;
    }

    public fun update_package_ids(arg0: &mut DappMetadata, arg1: vector<address>) {
        arg0.package_ids = arg1;
    }

    public fun update_partners(arg0: &mut DappMetadata, arg1: vector<0x1::ascii::String>) {
        arg0.partners = arg1;
    }

    public fun update_pausable(arg0: &mut DappMetadata, arg1: bool) {
        arg0.pausable = arg1;
    }

    public fun update_pending_admin(arg0: &mut DappMetadata, arg1: address) {
        arg0.pending_admin = arg1;
    }

    public fun update_version(arg0: &mut DappMetadata, arg1: u32) {
        arg0.version = arg1;
    }

    public fun update_website_url(arg0: &mut DappMetadata, arg1: 0x1::ascii::String) {
        arg0.website_url = arg1;
    }

    public fun version(arg0: &DappMetadata) : u32 {
        arg0.version
    }

    public fun website_url(arg0: &DappMetadata) : 0x1::ascii::String {
        arg0.website_url
    }

    // decompiled from Move bytecode v6
}

