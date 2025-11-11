module 0xc1c3296426f2bd4ac6d70dd95606bc5e11127f8e61f5c436f0ec79296ed58657::royalty {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig has drop, store {
        royalty_bp: u16,
        recipient: address,
    }

    struct RoyaltyPaidEvent has copy, drop {
        item_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    public fun calculate_amount(arg0: u64, arg1: u16) : u64 {
        calculate_royalty(arg0, arg1)
    }

    fun calculate_royalty(arg0: u64, arg1: u16) : u64 {
        arg0 * (arg1 as u64) / 10000
    }

    public fun get_fork_royalty(arg0: &0x2::transfer_policy::TransferPolicy<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork>) : (address, u16) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork, Rule, RoyaltyConfig>(v0, arg0);
        (v1.recipient, v1.royalty_bp)
    }

    public fun get_marvin_royalty(arg0: &0x2::transfer_policy::TransferPolicy<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin>) : (address, u16) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin, Rule, RoyaltyConfig>(v0, arg0);
        (v1.recipient, v1.royalty_bp)
    }

    public fun pay_fork_royalty(arg0: &0x2::transfer_policy::TransferPolicy<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork>, arg1: &mut 0x2::transfer_policy::TransferRequest<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork, Rule, RoyaltyConfig>(v0, arg0);
        let v2 = calculate_royalty(0x2::transfer_policy::paid<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork>(arg1), v1.royalty_bp);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg3), v1.recipient);
        let v3 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork, Rule>(v3, arg1);
        let v4 = RoyaltyPaidEvent{
            item_id   : 0x2::transfer_policy::item<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork>(arg1),
            amount    : v2,
            recipient : v1.recipient,
        };
        0x2::event::emit<RoyaltyPaidEvent>(v4);
        arg2
    }

    public fun pay_marvin_royalty(arg0: &0x2::transfer_policy::TransferPolicy<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin>, arg1: &mut 0x2::transfer_policy::TransferRequest<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin, Rule, RoyaltyConfig>(v0, arg0);
        let v2 = calculate_royalty(0x2::transfer_policy::paid<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin>(arg1), v1.royalty_bp);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg3), v1.recipient);
        let v3 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin, Rule>(v3, arg1);
        let v4 = RoyaltyPaidEvent{
            item_id   : 0x2::transfer_policy::item<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin>(arg1),
            amount    : v2,
            recipient : v1.recipient,
        };
        0x2::event::emit<RoyaltyPaidEvent>(v4);
        arg2
    }

    public fun setup_fork_policy(arg0: &0x2::package::Publisher, arg1: u16, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferPolicyCap<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork> {
        assert!(arg1 <= 10000, 1);
        let (v0, v1) = 0x2::transfer_policy::new<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork>(arg0, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = RoyaltyConfig{
            royalty_bp : arg1,
            recipient  : arg2,
        };
        let v5 = Rule{dummy_field: false};
        0x2::transfer_policy::add_rule<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork, Rule, RoyaltyConfig>(v5, &mut v3, &v2, v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork>>(v3);
        v2
    }

    public fun setup_marvin_policy(arg0: &0x2::package::Publisher, arg1: u16, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferPolicyCap<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin> {
        assert!(arg1 <= 10000, 1);
        let (v0, v1) = 0x2::transfer_policy::new<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin>(arg0, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = RoyaltyConfig{
            royalty_bp : arg1,
            recipient  : arg2,
        };
        let v5 = Rule{dummy_field: false};
        0x2::transfer_policy::add_rule<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin, Rule, RoyaltyConfig>(v5, &mut v3, &v2, v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin>>(v3);
        v2
    }

    public fun update_fork_config(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork>, arg1: &0x2::transfer_policy::TransferPolicyCap<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork>, arg2: u16, arg3: address) {
        assert!(arg2 <= 10000, 1);
        0x2::transfer_policy::remove_rule<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork, Rule, RoyaltyConfig>(arg0, arg1);
        let v0 = Rule{dummy_field: false};
        let v1 = RoyaltyConfig{
            royalty_bp : arg2,
            recipient  : arg3,
        };
        0x2::transfer_policy::add_rule<0x101cf4d03593c51a87e588f45fcb1ca0c86c1365c94f38fb772021bada7e76bf::fork::Fork, Rule, RoyaltyConfig>(v0, arg0, arg1, v1);
    }

    public fun update_marvin_config(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin>, arg1: &0x2::transfer_policy::TransferPolicyCap<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin>, arg2: u16, arg3: address) {
        assert!(arg2 <= 10000, 1);
        0x2::transfer_policy::remove_rule<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin, Rule, RoyaltyConfig>(arg0, arg1);
        let v0 = Rule{dummy_field: false};
        let v1 = RoyaltyConfig{
            royalty_bp : arg2,
            recipient  : arg3,
        };
        0x2::transfer_policy::add_rule<0x179659777e20c117858cb884209819b46524f02edf4247f38f48ef34cf881797::marvin::Marvin, Rule, RoyaltyConfig>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

