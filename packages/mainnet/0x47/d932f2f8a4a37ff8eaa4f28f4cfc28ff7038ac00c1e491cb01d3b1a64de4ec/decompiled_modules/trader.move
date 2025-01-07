module 0x47d932f2f8a4a37ff8eaa4f28f4cfc28ff7038ac00c1e491cb01d3b1a64de4ec::trader {
    public fun buy<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::transfer_policy::TransferPolicy<0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace_mp::Hyperspace_mp>, arg6: &mut 0x2::transfer_policy::TransferPolicy<0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace::Hyperspace>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1, v2, v3) = 0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace::purchase<T0, 0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace_mp::Hyperspace_mp>(arg2, arg3, 0x2::coin::split<0x2::sui::SUI>(&mut arg7, arg8, arg9));
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        0x2::kiosk::lock<T0>(arg0, arg1, arg4, v0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v6, arg0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v6, 0x2::coin::split<0x2::sui::SUI>(&mut arg7, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg4, arg8), arg9));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace_mp::Hyperspace_mp>(arg5, &mut v4, 0x2::coin::split<0x2::sui::SUI>(&mut arg7, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace_mp::Hyperspace_mp>(arg5, arg8), arg9));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace_mp::Hyperspace_mp>(arg5, v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace::Hyperspace>(arg6, &mut v5, 0x2::coin::split<0x2::sui::SUI>(&mut arg7, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace::Hyperspace>(arg6, arg8), arg9));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x9a84b6a7914aedd6741e73cc2ca23cbc77e22ed3c5f884c072a51868fedde45b::hyperspace::Hyperspace>(arg6, v5);
        arg7
    }

    // decompiled from Move bytecode v6
}

