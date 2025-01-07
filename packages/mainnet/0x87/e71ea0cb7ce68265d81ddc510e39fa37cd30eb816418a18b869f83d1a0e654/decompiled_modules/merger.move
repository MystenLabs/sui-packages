module 0x87e71ea0cb7ce68265d81ddc510e39fa37cd30eb816418a18b869f83d1a0e654::merger {
    public fun merge_from_kiosk<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: vector<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) : vector<0x2::transfer_policy::TransferRequest<T0>> {
        let v0 = 0x1::vector::empty<0x2::transfer_policy::TransferRequest<T0>>();
        while (0x1::vector::length<0x2::object::ID>(&arg5) > 0) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg5);
            0x2::kiosk::list<T0>(arg3, arg4, v1, 0);
            let (v2, v3) = 0x2::kiosk::purchase<T0>(arg3, v1, 0x2::coin::zero<0x2::sui::SUI>(arg6));
            0x2::kiosk::lock<T0>(arg1, arg2, arg0, v2);
            0x1::vector::push_back<0x2::transfer_policy::TransferRequest<T0>>(&mut v0, v3);
        };
        v0
    }

    public fun merge_from_kiosk_to_personal_kiosk<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: vector<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) : vector<0x2::transfer_policy::TransferRequest<T0>> {
        merge_from_kiosk<T0>(arg0, arg1, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2), arg3, arg4, arg5, arg6)
    }

    public fun merge_from_personal_kiosk<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: vector<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) : vector<0x2::transfer_policy::TransferRequest<T0>> {
        merge_from_kiosk<T0>(arg0, arg1, arg2, arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4), arg5, arg6)
    }

    public fun merge_from_personal_kiosk_to_personal_kiosk<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: vector<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) : vector<0x2::transfer_policy::TransferRequest<T0>> {
        merge_from_kiosk<T0>(arg0, arg1, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2), arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4), arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

