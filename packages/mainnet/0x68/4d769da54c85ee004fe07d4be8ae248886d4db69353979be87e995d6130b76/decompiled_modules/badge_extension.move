module 0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge_extension {
    struct BadgeExt has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BadgeExt{dummy_field: false};
        0x2::kiosk_extension::add<BadgeExt>(v0, arg0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1), 2, arg2);
    }

    public fun is_installed(arg0: &0x2::kiosk::Kiosk) : bool {
        0x2::kiosk_extension::is_installed<BadgeExt>(arg0)
    }

    public(friend) fun lock(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::Badge, arg2: &0x2::transfer_policy::TransferPolicy<0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::Badge>) {
        let v0 = BadgeExt{dummy_field: false};
        0x2::kiosk_extension::lock<BadgeExt, 0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::Badge>(v0, arg0, arg1, arg2);
    }

    public(friend) fun add_with_cap(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BadgeExt{dummy_field: false};
        0x2::kiosk_extension::add<BadgeExt>(v0, arg0, arg1, 2, arg2);
    }

    // decompiled from Move bytecode v6
}

