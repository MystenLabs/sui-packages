module 0x7b2159e438c8bb7d6bcadf704b8a1c018d044ca741ad850671e20cc477b2e1c0::kiosk_store {
    public entry fun buy_listed_item<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg0, arg1, arg2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v1);
        0x2::transfer::public_transfer<T0>(v0, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
    }

    public fun list_item<T0: store + key>(arg0: &0x2::kiosk::KioskOwnerCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<T0>(arg1, arg0, arg2, arg3);
    }

    public fun place_item<T0: store + key>(arg0: &0x2::kiosk::KioskOwnerCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: T0) {
        0x2::kiosk::place<T0>(arg1, arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

