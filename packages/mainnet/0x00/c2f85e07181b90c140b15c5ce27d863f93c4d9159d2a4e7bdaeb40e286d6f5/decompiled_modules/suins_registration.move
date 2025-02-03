module 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration {
    struct SuinsRegistration has store, key {
        id: 0x2::object::UID,
        domain: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain,
        domain_name: 0x1::string::String,
        expiration_timestamp_ms: u64,
        image_url: 0x1::string::String,
    }

    public(friend) fun new(arg0: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : SuinsRegistration {
        SuinsRegistration{
            id                      : 0x2::object::new(arg3),
            domain                  : arg0,
            domain_name             : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&arg0),
            expiration_timestamp_ms : 0x2::clock::timestamp_ms(arg2) + (arg1 as u64) * 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::year_ms(),
            image_url               : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::default_image(),
        }
    }

    public fun domain(arg0: &SuinsRegistration) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain {
        arg0.domain
    }

    public(friend) fun burn(arg0: SuinsRegistration) {
        let SuinsRegistration {
            id                      : v0,
            domain                  : _,
            domain_name             : _,
            expiration_timestamp_ms : _,
            image_url               : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun domain_name(arg0: &SuinsRegistration) : 0x1::string::String {
        arg0.domain_name
    }

    public fun expiration_timestamp_ms(arg0: &SuinsRegistration) : u64 {
        arg0.expiration_timestamp_ms
    }

    public fun has_expired(arg0: &SuinsRegistration, arg1: &0x2::clock::Clock) : bool {
        arg0.expiration_timestamp_ms < 0x2::clock::timestamp_ms(arg1)
    }

    public fun has_expired_past_grace_period(arg0: &SuinsRegistration, arg1: &0x2::clock::Clock) : bool {
        arg0.expiration_timestamp_ms + 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::grace_period_ms() < 0x2::clock::timestamp_ms(arg1)
    }

    public fun image_url(arg0: &SuinsRegistration) : 0x1::string::String {
        arg0.image_url
    }

    public(friend) fun set_expiration_timestamp_ms(arg0: &mut SuinsRegistration, arg1: u64) {
        arg0.expiration_timestamp_ms = arg1;
    }

    public fun uid(arg0: &SuinsRegistration) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut SuinsRegistration) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun update_image_url(arg0: &mut SuinsRegistration, arg1: 0x1::string::String) {
        arg0.image_url = arg1;
    }

    // decompiled from Move bytecode v6
}

