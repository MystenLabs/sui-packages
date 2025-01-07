module 0x3d15498a20efb4c3c964eacc21b2615e0f6074314d5e77093c689f62bb14fec5::kiosk_utils {
    public fun take<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg3), 0x2::coin::zero<0x2::sui::SUI>(arg3))
    }

    // decompiled from Move bytecode v6
}

