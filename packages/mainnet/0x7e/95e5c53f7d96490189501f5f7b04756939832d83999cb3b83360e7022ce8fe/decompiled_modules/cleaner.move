module 0x9542b4869f9cd9184fb97709974972e2ce7c82a375494041ca7555e3c0f8cddf::cleaner {
    struct Smasher<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4, phantom T5, phantom T6, phantom T7, phantom T8, phantom T9, phantom T10, phantom T11, phantom T12, phantom T13, phantom T14> has key {
        id: 0x2::object::UID,
        a: 0x2::balance::Supply<T0>,
        b: 0x2::balance::Supply<T1>,
        c: 0x2::balance::Supply<T2>,
        d: 0x2::balance::Supply<T3>,
        e: 0x2::balance::Supply<T4>,
        f: 0x2::balance::Supply<T5>,
        g: 0x2::balance::Supply<T6>,
        h: 0x2::balance::Supply<T7>,
        i: 0x2::balance::Supply<T8>,
        j: 0x2::balance::Supply<T9>,
        k: 0x2::balance::Supply<T10>,
        l: 0x2::balance::Supply<T11>,
        m: 0x2::balance::Supply<T12>,
        n: 0x2::balance::Supply<T13>,
        o: 0x2::balance::Supply<T14>,
    }

    public fun claim_and_delete<T0>(arg0: &mut 0x2::coin_registry::Currency<T0>, arg1: &0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin_registry::is_metadata_cap_claimed<T0>(arg0)) {
            return
        };
        0x2::coin_registry::delete_metadata_cap<T0>(arg0, 0x2::coin_registry::claim_metadata_cap<T0>(arg0, arg1, arg2));
    }

    public fun new_smasher<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::TreasuryCap<T1>, arg2: 0x2::coin::TreasuryCap<T2>, arg3: 0x2::coin::TreasuryCap<T3>, arg4: 0x2::coin::TreasuryCap<T4>, arg5: 0x2::coin::TreasuryCap<T5>, arg6: 0x2::coin::TreasuryCap<T6>, arg7: 0x2::coin::TreasuryCap<T7>, arg8: 0x2::coin::TreasuryCap<T8>, arg9: 0x2::coin::TreasuryCap<T9>, arg10: 0x2::coin::TreasuryCap<T10>, arg11: 0x2::coin::TreasuryCap<T11>, arg12: 0x2::coin::TreasuryCap<T12>, arg13: 0x2::coin::TreasuryCap<T13>, arg14: 0x2::coin::TreasuryCap<T14>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = Smasher<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>{
            id : 0x2::object::new(arg15),
            a  : 0x2::coin::treasury_into_supply<T0>(arg0),
            b  : 0x2::coin::treasury_into_supply<T1>(arg1),
            c  : 0x2::coin::treasury_into_supply<T2>(arg2),
            d  : 0x2::coin::treasury_into_supply<T3>(arg3),
            e  : 0x2::coin::treasury_into_supply<T4>(arg4),
            f  : 0x2::coin::treasury_into_supply<T5>(arg5),
            g  : 0x2::coin::treasury_into_supply<T6>(arg6),
            h  : 0x2::coin::treasury_into_supply<T7>(arg7),
            i  : 0x2::coin::treasury_into_supply<T8>(arg8),
            j  : 0x2::coin::treasury_into_supply<T9>(arg9),
            k  : 0x2::coin::treasury_into_supply<T10>(arg10),
            l  : 0x2::coin::treasury_into_supply<T11>(arg11),
            m  : 0x2::coin::treasury_into_supply<T12>(arg12),
            n  : 0x2::coin::treasury_into_supply<T13>(arg13),
            o  : 0x2::coin::treasury_into_supply<T14>(arg14),
        };
        0x2::transfer::freeze_object<Smasher<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>>(v0);
    }

    public fun safe_migrate<T0>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::coin_registry::exists<T0>(arg0)) {
            0x2::coin_registry::migrate_legacy_metadata<T0>(arg0, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

