module 0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::operator {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, @0x21ff4b83eb1bcabe4f470addf4dab5be10177df2f2658925c517eceb55e48785);
    }

    public entry fun mint_nft_to_address(arg0: &OperatorCap, arg1: &0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::version::Version, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<0x1::ascii::String>, arg7: vector<0x1::ascii::String>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::version::assert_current_version(arg1);
        0x2::transfer::public_transfer<0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::early_contributor_pass::EarlyContributorPass>(0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::early_contributor_pass::mint_nft(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), arg8);
    }

    public entry fun mint_nft_to_kiosk(arg0: &OperatorCap, arg1: &0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::version::Version, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<0x1::ascii::String>, arg7: vector<0x1::ascii::String>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::version::assert_current_version(arg1);
        let (v0, v1) = 0x2::kiosk::new(arg9);
        let v2 = v1;
        let v3 = v0;
        0x2::kiosk::place<0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::early_contributor_pass::EarlyContributorPass>(&mut v3, &v2, 0x88adc865abcdf01157753e67bcb6199b0aacf13131e83f38fc887ca35667bcd7::early_contributor_pass::mint_nft(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    public(friend) fun new_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

