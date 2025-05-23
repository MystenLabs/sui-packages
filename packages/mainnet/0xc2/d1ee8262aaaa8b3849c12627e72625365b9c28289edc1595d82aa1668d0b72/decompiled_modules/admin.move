module 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        owner: address,
        publisher: 0x2::package::Publisher,
    }

    public fun assert_admin_owner_is_sender(arg0: &mut AdminCap, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::errors::ENotAdmin());
    }

    public entry fun authorize_caller<T0: drop>(arg0: &mut AdminCap, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin_owner_is_sender(arg0, arg2);
        let v0 = 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::caller::get_caller();
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::authorize_friend_caller<0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::caller::PINS, T0>(arg1, &v0);
    }

    public entry fun deauthorize_caller<T0: drop>(arg0: &mut AdminCap, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin_owner_is_sender(arg0, arg2);
        let v0 = 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::caller::get_caller();
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::deauthorize_friend_caller<0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::caller::PINS, T0>(arg1, &v0);
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{
            id        : 0x2::object::new(arg1),
            owner     : v0,
            publisher : 0x2::package::claim<ADMIN>(arg0, arg1),
        };
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    public entry fun initialize(arg0: &mut AdminCap, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin_owner_is_sender(arg0, arg2);
        let v0 = 0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::caller::get_caller();
        let v1 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_caller_registry_mut<0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::caller::PINS>(arg1, &v0);
        0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::name::initialize(v1, arg2);
        0xc2d1ee8262aaaa8b3849c12627e72625365b9c28289edc1595d82aa1668d0b72::display::initialize(v1, &mut arg0.publisher, arg2);
    }

    // decompiled from Move bytecode v6
}

