module 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name {
    struct NAME has drop {
        dummy_field: bool,
    }

    struct PiNameOwnership has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        created_at: u64,
    }

    struct PiName has drop, store {
        name: 0x1::string::String,
        owner: address,
        ownership_id: 0x2::object::ID,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        expiration_ms: 0x1::option::Option<u64>,
        address: 0x1::option::Option<address>,
        data: 0x1::option::Option<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
        created_at: u64,
    }

    struct NameRegistry has store, key {
        id: 0x2::object::UID,
    }

    struct AddressRegistry has store, key {
        id: 0x2::object::UID,
    }

    public fun address_exists(arg0: &AddressRegistry, arg1: address) : bool {
        0x2::dynamic_field::exists_with_type<address, 0x1::string::String>(&arg0.id, arg1)
    }

    public fun address_remove_from_lookup(arg0: &mut AddressRegistry, arg1: address) {
        assert!(address_exists(arg0, arg1), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::EAddressNotFound());
        0x2::dynamic_field::remove<address, 0x1::string::String>(&mut arg0.id, arg1);
    }

    public fun assign_piname_to_address(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: 0x1::string::String, arg3: address) {
        let v0 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<NameRegistry>(arg1);
        assert!(!name_is_available(v0, arg0, arg2), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::ENameAvailable());
        assert!(*0x1::option::borrow<address>(&borrow_record_mut(v0, arg2).address) == arg3, 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::ENameAddressMismatch());
        let v1 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<AddressRegistry>(arg1);
        if (address_exists(v1, arg3)) {
            address_remove_from_lookup(v1, arg3);
        };
        lookup_insert(v1, arg3, arg2);
    }

    public fun borrow_record(arg0: &NameRegistry, arg1: 0x1::string::String) : &PiName {
        assert!(name_exists(arg0, arg1), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::ENameNotFound());
        0x2::dynamic_field::borrow<0x1::string::String, PiName>(&arg0.id, arg1)
    }

    public fun borrow_record_mut(arg0: &mut NameRegistry, arg1: 0x1::string::String) : &mut PiName {
        assert!(name_exists(arg0, arg1), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::ENameNotFound());
        0x2::dynamic_field::borrow_mut<0x1::string::String, PiName>(&mut arg0.id, arg1)
    }

    public fun create_piname(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<address>, arg6: 0x1::option::Option<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<NameRegistry>(arg1);
        assert!(name_is_available(v1, arg0, arg2), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::ENameAvailable());
        if (name_exists(v1, arg2)) {
            remove_name(v1, arg2);
        };
        let v2 = PiNameOwnership{
            id         : 0x2::object::new(arg7),
            name       : arg2,
            created_at : 0x2::clock::timestamp_ms(arg0),
        };
        let v3 = PiName{
            name          : arg2,
            owner         : v0,
            ownership_id  : 0x2::object::id<PiNameOwnership>(&v2),
            nft_id        : arg3,
            expiration_ms : arg4,
            address       : arg5,
            data          : arg6,
            created_at    : 0x2::clock::timestamp_ms(arg0),
        };
        insert_name(v1, arg2, v3);
        0x2::transfer::transfer<PiNameOwnership>(v2, v0);
    }

    public fun get_expiration_ms(arg0: &PiName) : u64 {
        *0x1::option::borrow<u64>(&arg0.expiration_ms)
    }

    public fun get_name(arg0: &PiNameOwnership) : 0x1::string::String {
        arg0.name
    }

    public fun initialize(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NameRegistry{id: 0x2::object::new(arg1)};
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::add<NameRegistry>(arg0, v0);
        let v1 = AddressRegistry{id: 0x2::object::new(arg1)};
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::add<AddressRegistry>(arg0, v1);
    }

    public fun insert_name(arg0: &mut NameRegistry, arg1: 0x1::string::String, arg2: PiName) {
        assert!(!name_exists(arg0, arg1), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::ENameAlreadyExists());
        0x2::dynamic_field::add<0x1::string::String, PiName>(&mut arg0.id, arg1, arg2);
    }

    fun is_valid_name(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::length(arg0);
        if (v0 < 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::constants::MIN_NAME_LENGTH() || v0 > 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::constants::MAX_NAME_LENGTH()) {
            return false
        };
        let v1 = 0x1::string::as_bytes(arg0);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u8>(v1, v2);
            let v4 = if (v3 >= 97 && v3 <= 122) {
                true
            } else if (v3 >= 48 && v3 <= 57) {
                true
            } else {
                v3 == 45
            };
            if (!v4) {
                return false
            };
            if ((v2 == 0 || v2 == v0 - 1) && v3 == 45) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun is_valid_ownership(arg0: &PiName, arg1: &PiNameOwnership) : bool {
        arg0.ownership_id == 0x2::object::id<PiNameOwnership>(arg1) && arg0.name == arg1.name
    }

    public fun lookup_insert(arg0: &mut AddressRegistry, arg1: address, arg2: 0x1::string::String) {
        assert!(!address_exists(arg0, arg1), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::EAddressAlreadyExists());
        0x2::dynamic_field::add<address, 0x1::string::String>(&mut arg0.id, arg1, arg2);
    }

    public fun lookup_remove(arg0: &mut AddressRegistry, arg1: address, arg2: 0x1::string::String) {
        if (!address_exists(arg0, arg1)) {
            return
        };
        if (*0x2::dynamic_field::borrow<address, 0x1::string::String>(&arg0.id, arg1) == arg2) {
            0x2::dynamic_field::remove<address, 0x1::string::String>(&mut arg0.id, arg1);
        };
    }

    public fun name_exists(arg0: &NameRegistry, arg1: 0x1::string::String) : bool {
        0x2::dynamic_field::exists_with_type<0x1::string::String, PiName>(&arg0.id, arg1)
    }

    public fun name_is_available(arg0: &NameRegistry, arg1: &0x2::clock::Clock, arg2: 0x1::string::String) : bool {
        assert!(is_valid_name(&arg2), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::EInvalidName());
        if (name_exists(arg0, arg2)) {
            let v1 = borrow_record(arg0, arg2);
            0x1::option::is_some<u64>(&v1.expiration_ms) && get_expiration_ms(v1) < 0x2::clock::timestamp_ms(arg1)
        } else {
            true
        }
    }

    public fun remove_name(arg0: &mut NameRegistry, arg1: 0x1::string::String) {
        assert!(name_exists(arg0, arg1), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::ENameNotFound());
        0x2::dynamic_field::remove<0x1::string::String, PiName>(&mut arg0.id, arg1);
    }

    fun reset_piname_internal(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: 0x1::string::String) {
        let v0 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<NameRegistry>(arg1);
        assert!(name_is_available(v0, arg0, arg2), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::ENameNotAvailable());
        let v1 = borrow_record_mut(v0, arg2);
        v1.nft_id = 0x1::option::none<0x2::object::ID>();
        v1.expiration_ms = 0x1::option::none<u64>();
        v1.address = 0x1::option::none<address>();
        v1.data = 0x1::option::none<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>();
    }

    public fun set_piname_address(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: 0x1::string::String, arg3: address) {
        update_piname_internal(arg0, arg1, arg2, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<address>(arg3), 0x1::option::none<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>());
    }

    public fun set_piname_data(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: 0x1::string::String, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        update_piname_internal(arg0, arg1, arg2, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::none<address>(), 0x1::option::some<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg3));
    }

    public fun set_piname_data_key(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<NameRegistry>(arg1);
        assert!(name_is_available(v0, arg0, arg2), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::ENameNotAvailable());
        let v1 = borrow_record_mut(v0, arg2);
        if (0x1::option::is_none<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&v1.data)) {
            v1.data = 0x1::option::some<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(0x2::vec_map::empty<0x1::string::String, 0x1::string::String>());
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(0x1::option::borrow_mut<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut v1.data), arg3, arg4);
    }

    public fun set_piname_expiration(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: 0x1::string::String, arg3: u64) {
        update_piname_internal(arg0, arg1, arg2, 0x1::option::none<0x2::object::ID>(), 0x1::option::some<u64>(arg3), 0x1::option::none<address>(), 0x1::option::none<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>());
    }

    public fun set_piname_nft(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: 0x1::string::String, arg3: 0x2::object::ID) {
        update_piname_internal(arg0, arg1, arg2, 0x1::option::some<0x2::object::ID>(arg3), 0x1::option::none<u64>(), 0x1::option::none<address>(), 0x1::option::none<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>());
    }

    public fun unset_piname_data_key(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        let v0 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<NameRegistry>(arg1);
        assert!(name_is_available(v0, arg0, arg2), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::ENameNotAvailable());
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(0x1::option::borrow_mut<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut borrow_record_mut(v0, arg2).data), &arg3);
    }

    fun update_piname_internal(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<address>, arg6: 0x1::option::Option<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>) {
        let v0 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<NameRegistry>(arg1);
        assert!(name_is_available(v0, arg0, arg2), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::ENameNotAvailable());
        let v1 = borrow_record_mut(v0, arg2);
        if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
            v1.nft_id = arg3;
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            assert!(*0x1::option::borrow<u64>(&arg4) > get_expiration_ms(v1), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::EInvalidExpiration());
            v1.expiration_ms = arg4;
        };
        if (0x1::option::is_some<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg6)) {
            v1.data = arg6;
        };
        let v2 = v1.address;
        if (0x1::option::is_some<address>(&arg5)) {
            v1.address = arg5;
        };
        if (0x1::option::is_some<address>(&arg5) && 0x1::option::is_some<address>(&v2)) {
            let v3 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<AddressRegistry>(arg1);
            lookup_remove(v3, 0x1::option::extract<address>(&mut v2), v1.name);
        };
    }

    // decompiled from Move bytecode v6
}

