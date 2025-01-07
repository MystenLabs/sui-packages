module 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::kiosk {
    public fun place_and_list_with_purchase_cap<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: T0, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        0x2::kiosk::place<T0>(arg0, arg1, arg2);
        0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, 0x2::object::id<T0>(&arg2), arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

