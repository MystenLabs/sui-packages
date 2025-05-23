module 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::profile {
    struct ProfileRegistry has store, key {
        id: 0x2::object::UID,
    }

    struct PrivasuiProfile has copy, drop, store {
        owner: address,
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        about: 0x1::option::Option<0x1::string::String>,
        created_at: u64,
        updated_at: u64,
    }

    public fun add_profile(arg0: &mut ProfileRegistry, arg1: address, arg2: PrivasuiProfile) {
        assert!(!profile_exists(arg0, arg1), 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::errors::EAddressAlreadyHasProfile());
        0x2::dynamic_field::add<address, PrivasuiProfile>(&mut arg0.id, arg1, arg2);
    }

    public fun create_profile(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<ProfileRegistry>(arg1);
        assert!(!profile_exists(v1, v0), 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::errors::EAddressAlreadyHasProfile());
        let v2 = PrivasuiProfile{
            owner      : v0,
            nft_id     : arg2,
            name       : arg3,
            about      : arg4,
            created_at : 0x2::clock::timestamp_ms(arg0),
            updated_at : 0,
        };
        add_profile(v1, v0, v2);
    }

    public fun get_about(arg0: &PrivasuiProfile) : 0x1::option::Option<0x1::string::String> {
        arg0.about
    }

    public fun get_created_at(arg0: &PrivasuiProfile) : u64 {
        arg0.created_at
    }

    public fun get_name(arg0: &PrivasuiProfile) : 0x1::string::String {
        arg0.name
    }

    public fun get_nft_id(arg0: &PrivasuiProfile) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun get_owner(arg0: &PrivasuiProfile) : address {
        arg0.owner
    }

    public fun get_profile_mut(arg0: &mut ProfileRegistry, arg1: address) : &mut PrivasuiProfile {
        assert!(profile_exists(arg0, arg1), 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::errors::EAddressHasNoProfile());
        0x2::dynamic_field::borrow_mut<address, PrivasuiProfile>(&mut arg0.id, arg1)
    }

    public fun get_updated_at(arg0: &PrivasuiProfile) : u64 {
        arg0.updated_at
    }

    public fun initialize(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfileRegistry{id: 0x2::object::new(arg1)};
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::add<ProfileRegistry>(arg0, v0);
    }

    public fun profile_exists(arg0: &ProfileRegistry, arg1: address) : bool {
        0x2::dynamic_field::exists_with_type<address, PrivasuiProfile>(&arg0.id, arg1)
    }

    public fun update_profile_name(arg0: &mut ProfileRegistry, arg1: &0x2::clock::Clock, arg2: address, arg3: 0x1::string::String) {
        let v0 = get_profile_mut(arg0, arg2);
        v0.name = arg3;
        v0.updated_at = 0x2::clock::timestamp_ms(arg1);
    }

    public fun update_profile_nft(arg0: &mut ProfileRegistry, arg1: &0x2::clock::Clock, arg2: address, arg3: 0x2::object::ID) {
        let v0 = get_profile_mut(arg0, arg2);
        v0.nft_id = arg3;
        v0.updated_at = 0x2::clock::timestamp_ms(arg1);
    }

    // decompiled from Move bytecode v6
}

