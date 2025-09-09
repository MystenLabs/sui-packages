module 0x6eed7ba483e3940a9c7b36e5e117c84f6a39c49d84d29946565b85f21c0b85f4::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        reserve: 0x2::balance::Balance<T0>,
    }

    public entry fun create_vault<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg1),
            reserve : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &AdminCap) {
        0x2::balance::join<T0>(&mut arg0.reserve, arg1);
    }

    public fun deposit_coin<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &AdminCap) {
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun deposit_with_event<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &AdminCap) {
        0x6eed7ba483e3940a9c7b36e5e117c84f6a39c49d84d29946565b85f21c0b85f4::event::emit_deposit_event(0x2::object::id<Vault<T0>>(arg0), 0x2::balance::value<T0>(&arg1));
        0x2::balance::join<T0>(&mut arg0.reserve, arg1);
    }

    public fun deposit_with_threshold<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &AdminCap) {
        assert!(0x2::balance::value<T0>(&arg1) > arg2, 1);
        0x2::balance::join<T0>(&mut arg0.reserve, arg1);
    }

    public fun deposit_with_threshold_and_event<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &AdminCap) {
        assert!(0x2::balance::value<T0>(&arg1) > arg2, 1);
        0x6eed7ba483e3940a9c7b36e5e117c84f6a39c49d84d29946565b85f21c0b85f4::event::emit_deposit_event(0x2::object::id<Vault<T0>>(arg0), 0x2::balance::value<T0>(&arg1));
        0x2::balance::join<T0>(&mut arg0.reserve, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun new_admin(arg0: address, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg0);
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &AdminCap) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.reserve, arg1)
    }

    public fun withdraw_coin<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(&mut arg0.reserve, arg1, arg3)
    }

    // decompiled from Move bytecode v6
}

