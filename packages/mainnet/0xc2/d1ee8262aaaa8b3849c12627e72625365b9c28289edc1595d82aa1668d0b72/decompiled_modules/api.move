module 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::api {
    public fun assign_piname_to_address<T0: drop>(arg0: &0x2::clock::Clock, arg1: &T0, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::assign_piname_to_address(arg0, get_registry_mut<T0>(arg2, arg1), arg3, 0x2::tx_context::sender(arg4));
    }

    public fun create_piname<T0: drop>(arg0: &0x2::clock::Clock, arg1: &T0, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::create_piname(arg0, get_registry_mut<T0>(arg2, arg1), arg3, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<address>(0x2::tx_context::sender(arg4)), 0x1::option::none<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(), arg4);
    }

    fun get_registry_mut<T0: drop>(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg1: &T0) : &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry {
        let v0 = 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::caller::get_caller();
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::assert_friend_caller_is_authorized<0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::caller::PINS, T0>(arg0, &v0, arg1);
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_caller_registry_mut<0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::caller::PINS>(arg0, &v0)
    }

    public fun has_name<T0: drop>(arg0: &T0, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg2: address) : bool {
        0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::address_exists(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::AddressRegistry>(get_registry_mut<T0>(arg1, arg0)), arg2)
    }

    public fun piname_exists<T0: drop>(arg0: &T0, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg2: 0x1::string::String) : bool {
        0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::name_exists(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::NameRegistry>(get_registry_mut<T0>(arg1, arg0)), arg2)
    }

    public fun piname_is_available<T0: drop>(arg0: &0x2::clock::Clock, arg1: &T0, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: 0x1::string::String) : bool {
        0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::name_is_available(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::NameRegistry>(get_registry_mut<T0>(arg2, arg1)), arg0, arg3)
    }

    public fun set_piname_address<T0: drop>(arg0: &0x2::clock::Clock, arg1: &T0, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: &mut 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::PiNameOwnership, arg4: address) {
        0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::set_piname_address(arg0, get_registry_mut<T0>(arg2, arg1), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::get_name(arg3), arg4);
    }

    public fun set_piname_data<T0: drop>(arg0: &0x2::clock::Clock, arg1: &T0, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: &mut 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::PiNameOwnership, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::set_piname_data(arg0, get_registry_mut<T0>(arg2, arg1), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::get_name(arg3), arg4);
    }

    public fun set_piname_expiration<T0: drop>(arg0: &0x2::clock::Clock, arg1: &T0, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: &mut 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::PiNameOwnership, arg4: u64) {
        0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::set_piname_expiration(arg0, get_registry_mut<T0>(arg2, arg1), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::get_name(arg3), arg4);
    }

    public fun set_piname_nft<T0: drop>(arg0: &0x2::clock::Clock, arg1: &T0, arg2: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg3: &mut 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::PiNameOwnership, arg4: 0x2::object::ID) {
        0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::set_piname_nft(arg0, get_registry_mut<T0>(arg2, arg1), 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::get_name(arg3), arg4);
    }

    // decompiled from Move bytecode v6
}

