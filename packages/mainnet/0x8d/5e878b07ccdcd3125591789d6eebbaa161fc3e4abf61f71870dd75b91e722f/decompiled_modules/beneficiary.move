module 0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::is_emergency(arg0), 302);
        assert!(0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::get_mut_pool<T0, T1>(arg0, 0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::event::withdrew_event(0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::global_id<T0, T1>(v0), 0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

