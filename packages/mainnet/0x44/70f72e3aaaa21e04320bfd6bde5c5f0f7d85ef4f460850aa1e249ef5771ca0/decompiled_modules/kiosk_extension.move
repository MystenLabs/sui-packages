module 0x835feb8894c3b666555efdfae0e0687e3291b9a7da741f896e43d3d07ab2cdaa::kiosk_extension {
    public fun confirm_transfer_request(arg0: 0x2::transfer_policy::TransferRequest<0x835feb8894c3b666555efdfae0e0687e3291b9a7da741f896e43d3d07ab2cdaa::compatibility::CompatibilityCollectible>, arg1: &0x2::transfer_policy::TransferPolicy<0x835feb8894c3b666555efdfae0e0687e3291b9a7da741f896e43d3d07ab2cdaa::compatibility::CompatibilityCollectible>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x835feb8894c3b666555efdfae0e0687e3291b9a7da741f896e43d3d07ab2cdaa::compatibility::CompatibilityCollectible>(arg1, arg0);
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun list_collectible(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<0x835feb8894c3b666555efdfae0e0687e3291b9a7da741f896e43d3d07ab2cdaa::compatibility::CompatibilityCollectible>(arg0, arg1, arg2, arg3);
    }

    public fun lock_collectible(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<0x835feb8894c3b666555efdfae0e0687e3291b9a7da741f896e43d3d07ab2cdaa::compatibility::CompatibilityCollectible>, arg3: 0x835feb8894c3b666555efdfae0e0687e3291b9a7da741f896e43d3d07ab2cdaa::compatibility::CompatibilityCollectible) {
        0x2::kiosk::lock<0x835feb8894c3b666555efdfae0e0687e3291b9a7da741f896e43d3d07ab2cdaa::compatibility::CompatibilityCollectible>(arg0, arg1, arg2, arg3);
    }

    public fun place_and_list_collectible(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x835feb8894c3b666555efdfae0e0687e3291b9a7da741f896e43d3d07ab2cdaa::compatibility::CompatibilityCollectible, arg3: u64) {
        0x2::kiosk::place_and_list<0x835feb8894c3b666555efdfae0e0687e3291b9a7da741f896e43d3d07ab2cdaa::compatibility::CompatibilityCollectible>(arg0, arg1, arg2, arg3);
    }

    public fun prove_locked_purchase(arg0: &mut 0x2::transfer_policy::TransferRequest<0x835feb8894c3b666555efdfae0e0687e3291b9a7da741f896e43d3d07ab2cdaa::compatibility::CompatibilityCollectible>, arg1: &0x2::kiosk::Kiosk) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0x835feb8894c3b666555efdfae0e0687e3291b9a7da741f896e43d3d07ab2cdaa::compatibility::CompatibilityCollectible>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

