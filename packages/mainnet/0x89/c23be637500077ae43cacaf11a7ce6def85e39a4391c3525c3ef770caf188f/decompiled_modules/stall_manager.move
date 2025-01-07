module 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::stall_manager {
    public(friend) fun claim_bumper_prize<T0: store + key>(arg0: &mut 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::bumper_prize::BumperPrizeList, arg1: u64, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::bumper_prize::claim_bumper_prize<T0>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun create_bumper_list(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::bumper_prize::create_bumper_list(arg0)
    }

    public(friend) fun create_bumper_prize(arg0: &mut 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::bumper_prize::BumperPrizeList, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::bumper_prize::create_bumper_prize(arg0, arg1, arg2, arg3, arg4);
    }

    public(friend) fun get_random_in_bumper(arg0: &mut 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::bumper_prize::BumperPrizeList, arg1: &mut 0x2::tx_context::TxContext) {
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::bumper_prize::get_random_in_bumper(arg0, arg1);
    }

    public(friend) fun add_other_nft<T0: store + key>(arg0: &mut 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::goodie_bag::GoodieBagList, arg1: T0) {
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::goodie_bag::add_other_nft<T0>(arg0, arg1);
    }

    public(friend) fun set_merkle_root(arg0: vector<u8>, arg1: &mut 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::goodie_bag::GoodieBagList) {
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::goodie_bag::set_merkle_root(arg0, arg1);
    }

    public(friend) fun add_nft_in_stall_bumper<T0: store + key>(arg0: &mut 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::bumper_prize::BumperPrizeList, arg1: T0) {
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::bumper_prize::add_other_nft_in_event_bumper<T0>(arg0, arg1);
    }

    public(friend) fun create_goodie_item(arg0: &mut 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::goodie_bag::GoodieBagList, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::goodie_bag::create_goodie_bag(arg0, arg1, arg2, arg3, arg4);
    }

    public(friend) fun create_goodie_items(arg0: &mut 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::goodie_bag::GoodieBagList, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::goodie_bag::create_goodie_bag(arg0, arg1, arg2, arg3, arg4);
    }

    public(friend) fun create_goodie_list(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::goodie_bag::create_goodie_bag_list(arg0, arg1, arg2, arg3)
    }

    public(friend) fun create_invitation(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::nft_minter::create_invitation_list(arg0)
    }

    // decompiled from Move bytecode v6
}

