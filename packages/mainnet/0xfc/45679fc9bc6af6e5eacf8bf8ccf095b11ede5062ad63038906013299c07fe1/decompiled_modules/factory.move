module 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::factory {
    struct Factory has key {
        id: 0x2::object::UID,
        tracked_merchant_addresses: 0x2::vec_map::VecMap<vector<u8>, address>,
    }

    struct MerchantCreatedEvent has copy, drop {
        merchant_object_id: address,
        merchant_id: vector<u8>,
        super_admin: address,
        nft_management_id: 0x2::object::ID,
        stamp_rally_management_id: 0x2::object::ID,
        e_ticket_management_id: 0x2::object::ID,
    }

    struct MerchantBlockedEvent has copy, drop {
        merchant_object_id: 0x2::object::ID,
    }

    struct MerchantUnblockedEvent has copy, drop {
        merchant_object_id: 0x2::object::ID,
    }

    public fun block_merchant(arg0: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::operator::Operator, arg1: &mut 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::operator::get_address(arg0), 1003);
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::block_merchant(arg1);
        let v0 = MerchantBlockedEvent{merchant_object_id: 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant>(arg1)};
        0x2::event::emit<MerchantBlockedEvent>(v0);
    }

    entry fun create_merchant(arg0: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::operator::Operator, arg1: &mut Factory, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::operator::get_public_key(arg0);
        assert!(!0x2::vec_map::contains<vector<u8>, address>(&arg1.tracked_merchant_addresses, &arg3), 1002);
        let v1 = b"";
        0x1::vector::append<u8>(&mut v1, arg3);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg4));
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v0, &v1), 1001);
        let v2 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::nft_management::init_nft_management(arg3, arg5);
        let v3 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::stamp_rally::init_stamp_rally_management(arg3, arg5);
        let v4 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::e_ticket::init_e_ticket_management(arg3, arg5);
        let v5 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::init_merchant(0x2::object::id<Factory>(arg1), arg3, arg4, v2, v3, v4, arg5);
        0x2::vec_map::insert<vector<u8>, address>(&mut arg1.tracked_merchant_addresses, arg3, v5);
        let v6 = MerchantCreatedEvent{
            merchant_object_id        : v5,
            merchant_id               : arg3,
            super_admin               : arg4,
            nft_management_id         : v2,
            stamp_rally_management_id : v3,
            e_ticket_management_id    : v4,
        };
        0x2::event::emit<MerchantCreatedEvent>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id                         : 0x2::object::new(arg0),
            tracked_merchant_addresses : 0x2::vec_map::empty<vector<u8>, address>(),
        };
        0x2::transfer::share_object<Factory>(v0);
    }

    public fun unblock_merchant(arg0: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::operator::Operator, arg1: &mut 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::operator::get_address(arg0), 1003);
        0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::unblock_merchant(arg1);
        let v0 = MerchantUnblockedEvent{merchant_object_id: 0x2::object::id<0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant::Merchant>(arg1)};
        0x2::event::emit<MerchantUnblockedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

