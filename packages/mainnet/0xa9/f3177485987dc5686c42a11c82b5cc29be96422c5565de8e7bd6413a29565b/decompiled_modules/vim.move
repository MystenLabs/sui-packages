module 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim {
    struct VIM has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TreasuryLock<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    public(friend) fun burn<T0>(arg0: &mut TreasuryLock<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 0);
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, 0x2::coin::split<T0>(&mut arg1, arg2, arg3));
        reture_back_or_delete<T0>(arg1, arg3);
    }

    public(friend) fun mint_balance<T0>(arg0: &mut TreasuryLock<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::coin::mint_balance<T0>(&mut arg0.treasury_cap, arg1)
    }

    public fun total_supply<T0>(arg0: &TreasuryLock<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury_cap)
    }

    fun init(arg0: VIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIM>(arg0, 6, b"Vim", b"Vimverse Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIM>>(v1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIM>>(v0, v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, v2);
    }

    public entry fun new_lock<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryLock<T0>{
            id           : 0x2::object::new(arg1),
            treasury_cap : arg0,
        };
        0x2::transfer::share_object<TreasuryLock<T0>>(v0);
    }

    fun reture_back_or_delete<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

