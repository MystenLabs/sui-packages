module 0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::confirmer {
    struct Confirmer has store, key {
        id: 0x2::object::UID,
        fee_tier: 0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::fee_tier::FeeTier,
        nonce_manager: 0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::nonce_manager::NonceManager,
    }

    struct ConfirmSwapEvent has copy, drop {
        quote_id: 0x1::string::String,
        mm_vault_id: 0x2::object::ID,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        nonce: u64,
    }

    public fun collect_fee<T0>(arg0: &mut Confirmer, arg1: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::admin_cap::AdminCap, arg2: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::check_version(arg2);
        0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::fee_tier::collect_fee<T0>(&mut arg0.fee_tier, arg3)
    }

    public fun confirm_swap<T0, T1>(arg0: &mut Confirmer, arg1: &mut 0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::mm_vault::MMVault, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<T0>, arg8: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::check_version(arg8);
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<T1>(), 13906834483581681675);
        assert!(arg3 > 0, 13906834487875993601);
        assert!(0x2::clock::timestamp_ms(arg9) / 1000 <= arg4, 13906834492171485193);
        assert!(0x2::coin::value<T0>(&arg7) > 0, 13906834496466059267);
        0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::nonce_manager::increment_nonce(&mut arg0.nonce_manager, arg5, arg10);
        let v0 = 0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::mm_vault::swap<T0, T1>(arg1, arg2, arg7, arg3, arg4, arg5, arg6, arg8, arg10);
        let v1 = 0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::fee_tier::fee_amount<T0, T1>(&arg0.fee_tier, arg3);
        assert!(0x2::balance::value<T1>(&v0) == arg3, 13906834569480634373);
        if (v1 > 0) {
            0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::fee_tier::receive_fee<T1>(&mut arg0.fee_tier, 0x2::balance::split<T1>(&mut v0, v1));
        };
        assert!(0x2::balance::value<T1>(&v0) > 0, 13906834590955601927);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg10), 0x2::tx_context::sender(arg10));
        let v2 = ConfirmSwapEvent{
            quote_id    : arg2,
            mm_vault_id : 0x2::object::id<0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::mm_vault::MMVault>(arg1),
            from        : 0x1::type_name::with_defining_ids<T0>(),
            target      : 0x1::type_name::with_defining_ids<T1>(),
            amount_in   : 0x2::coin::value<T0>(&arg7),
            amount_out  : arg3,
            fee_amount  : v1,
            nonce       : arg5,
        };
        0x2::event::emit<ConfirmSwapEvent>(v2);
    }

    public fun get_fee_tier(arg0: &Confirmer) : &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::fee_tier::FeeTier {
        &arg0.fee_tier
    }

    public fun get_nonce_manager(arg0: &Confirmer) : &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::nonce_manager::NonceManager {
        &arg0.nonce_manager
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Confirmer{
            id            : 0x2::object::new(arg0),
            fee_tier      : 0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::fee_tier::new_fee_tier(arg0),
            nonce_manager : 0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::nonce_manager::new_nonce_manager(arg0),
        };
        0x2::transfer::public_share_object<Confirmer>(v0);
    }

    public fun set_default_fee_rate(arg0: &mut Confirmer, arg1: u32, arg2: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::admin_cap::AdminCap, arg3: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::Versioned) {
        0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::check_version(arg3);
        0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::fee_tier::set_default_fee_rate(&mut arg0.fee_tier, arg1);
    }

    public fun set_fee_rate<T0, T1>(arg0: &mut Confirmer, arg1: u32, arg2: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::admin_cap::AdminCap, arg3: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::Versioned) {
        0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned::check_version(arg3);
        0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::fee_tier::set_fee_rate<T0, T1>(&mut arg0.fee_tier, arg1);
    }

    // decompiled from Move bytecode v6
}

