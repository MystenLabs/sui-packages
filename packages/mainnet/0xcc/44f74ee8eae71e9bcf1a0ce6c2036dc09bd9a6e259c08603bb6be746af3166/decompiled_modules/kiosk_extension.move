module 0xcc44f74ee8eae71e9bcf1a0ce6c2036dc09bd9a6e259c08603bb6be746af3166::kiosk_extension {
    public fun confirm_transfer_request(arg0: 0x2::transfer_policy::TransferRequest<0xcc44f74ee8eae71e9bcf1a0ce6c2036dc09bd9a6e259c08603bb6be746af3166::medics::CompatibilityCollectible>, arg1: &0x2::transfer_policy::TransferPolicy<0xcc44f74ee8eae71e9bcf1a0ce6c2036dc09bd9a6e259c08603bb6be746af3166::medics::CompatibilityCollectible>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xcc44f74ee8eae71e9bcf1a0ce6c2036dc09bd9a6e259c08603bb6be746af3166::medics::CompatibilityCollectible>(arg1, arg0);
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun list_collectible(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<0xcc44f74ee8eae71e9bcf1a0ce6c2036dc09bd9a6e259c08603bb6be746af3166::medics::CompatibilityCollectible>(arg0, arg1, arg2, arg3);
    }

    public fun lock_collectible(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<0xcc44f74ee8eae71e9bcf1a0ce6c2036dc09bd9a6e259c08603bb6be746af3166::medics::CompatibilityCollectible>, arg3: 0xcc44f74ee8eae71e9bcf1a0ce6c2036dc09bd9a6e259c08603bb6be746af3166::medics::CompatibilityCollectible) {
        0x2::kiosk::lock<0xcc44f74ee8eae71e9bcf1a0ce6c2036dc09bd9a6e259c08603bb6be746af3166::medics::CompatibilityCollectible>(arg0, arg1, arg2, arg3);
    }

    public fun place_and_list_collectible(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0xcc44f74ee8eae71e9bcf1a0ce6c2036dc09bd9a6e259c08603bb6be746af3166::medics::CompatibilityCollectible, arg3: u64) {
        0x2::kiosk::place_and_list<0xcc44f74ee8eae71e9bcf1a0ce6c2036dc09bd9a6e259c08603bb6be746af3166::medics::CompatibilityCollectible>(arg0, arg1, arg2, arg3);
    }

    public fun prove_locked_purchase(arg0: &mut 0x2::transfer_policy::TransferRequest<0xcc44f74ee8eae71e9bcf1a0ce6c2036dc09bd9a6e259c08603bb6be746af3166::medics::CompatibilityCollectible>, arg1: &0x2::kiosk::Kiosk) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xcc44f74ee8eae71e9bcf1a0ce6c2036dc09bd9a6e259c08603bb6be746af3166::medics::CompatibilityCollectible>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

