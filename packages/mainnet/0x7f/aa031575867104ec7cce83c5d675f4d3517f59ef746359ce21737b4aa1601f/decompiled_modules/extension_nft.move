module 0x4029616b7d1496bf853e8024cb23a0f0ca10fe58aafefbec674119c312bcca22::extension_nft {
    struct BuildSlotExt has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BuildSlotExt{dummy_field: false};
        0x2::kiosk_extension::add<BuildSlotExt>(v0, arg0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1), 2, arg2);
    }

    public(friend) fun lock<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: T0, arg2: &0x2::transfer_policy::TransferPolicy<T0>) {
        let v0 = BuildSlotExt{dummy_field: false};
        0x2::kiosk_extension::lock<BuildSlotExt, T0>(v0, arg0, arg1, arg2);
    }

    public fun add_(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BuildSlotExt{dummy_field: false};
        0x2::kiosk_extension::add<BuildSlotExt>(v0, arg0, arg1, 2, arg2);
    }

    // decompiled from Move bytecode v6
}

