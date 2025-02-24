module 0xbd73f4a4dd8348947e8fe942866d8d1e8b3cae25b2099743e69ddb5391acbe19::public_names {
    struct SuinsNftKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PublicName has key {
        id: 0x2::object::UID,
        capability_id: 0x2::object::ID,
    }

    struct PublicNameCap has store, key {
        id: 0x2::object::UID,
        valid_for: 0x2::object::ID,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : (PublicName, PublicNameCap) {
        let v0 = 0x2::object::new(arg0);
        let v1 = PublicName{
            id            : 0x2::object::new(arg0),
            capability_id : 0x2::object::uid_to_inner(&v0),
        };
        let v2 = PublicNameCap{
            id        : v0,
            valid_for : 0x2::object::uid_to_inner(&v1.id),
        };
        (v1, v2)
    }

    public fun create_app(arg0: &mut PublicName, arg1: &mut 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::move_registry::MoveRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppCap {
        let v0 = SuinsNftKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<SuinsNftKey, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.id, v0)) {
            0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::move_registry::register(arg1, 0x2::dynamic_field::borrow_mut<SuinsNftKey, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg0.id, v0), arg2, arg3, arg4)
        } else {
            0x96c9bed5a312b888603f462f22084e470cc8555a275ef61cc12dd83ecf23a04::utils::register(arg1, 0x2::dynamic_field::borrow_mut<SuinsNftKey, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration>(&mut arg0.id, v0), arg2, arg3, arg4)
        }
    }

    public fun destroy<T0: store>(arg0: PublicName, arg1: PublicNameCap) : T0 {
        let v0 = SuinsNftKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<SuinsNftKey, T0>(&arg0.id, v0), 0);
        assert!(is_valid_for(&arg1, &arg0), 1);
        let PublicName {
            id            : v1,
            capability_id : _,
        } = arg0;
        let v3 = v1;
        0x2::object::delete(v3);
        let PublicNameCap {
            id        : v4,
            valid_for : _,
        } = arg1;
        0x2::object::delete(v4);
        0x2::dynamic_field::remove<SuinsNftKey, T0>(&mut v3, v0)
    }

    fun is_valid_for(arg0: &PublicNameCap, arg1: &PublicName) : bool {
        arg0.valid_for == 0x2::object::uid_to_inner(&arg1.id)
    }

    public fun new_sld(arg0: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg1);
        let v2 = v0;
        let v3 = SuinsNftKey{dummy_field: false};
        0x2::dynamic_field::add<SuinsNftKey, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut v2.id, v3, arg0);
        0x2::transfer::share_object<PublicName>(v2);
        0x2::transfer::public_transfer<PublicNameCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun new_subdomain(arg0: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg1);
        let v2 = v0;
        let v3 = SuinsNftKey{dummy_field: false};
        0x2::dynamic_field::add<SuinsNftKey, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration>(&mut v2.id, v3, arg0);
        0x2::transfer::share_object<PublicName>(v2);
        0x2::transfer::public_transfer<PublicNameCap>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

