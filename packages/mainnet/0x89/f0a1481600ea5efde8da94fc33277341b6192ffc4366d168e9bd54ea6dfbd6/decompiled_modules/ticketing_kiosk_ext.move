module 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing_kiosk_ext {
    struct Extension has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Extension{dummy_field: false};
        0x2::kiosk_extension::add<Extension>(v0, arg0, arg1, 3, arg2);
    }

    public fun lock_ticket<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::Ticket<T0>, arg2: &0x2::transfer_policy::TransferPolicy<0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::Ticket<T0>>, arg3: 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::MintProof) {
        let (v0, v1) = 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::solve_mint_proof(arg3);
        assert!(v0 == 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::get_ticket_id<T0>(&arg1), 1);
        assert!(v1 == true, 3);
        let v2 = Extension{dummy_field: false};
        0x2::kiosk_extension::lock<Extension, 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::Ticket<T0>>(v2, arg0, arg1, arg2);
    }

    public fun place_ticket<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::Ticket<T0>, arg2: &0x2::transfer_policy::TransferPolicy<0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::Ticket<T0>>, arg3: 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::MintProof) {
        let (v0, v1) = 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::solve_mint_proof(arg3);
        assert!(v0 == 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::get_ticket_id<T0>(&arg1), 1);
        assert!(v1 == false, 2);
        let v2 = Extension{dummy_field: false};
        0x2::kiosk_extension::place<Extension, 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::Ticket<T0>>(v2, arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

