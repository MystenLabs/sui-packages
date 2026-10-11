module 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    struct FundsRescued has copy, drop {
        coin_id: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    struct RescueReceiveStarted has copy, drop {
        cctp_nonce: u256,
        cctp_source_domain: u32,
        mint_recipient: address,
        amount: u64,
    }

    entry fun complete(arg0: DeployerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::State>(0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::new_state(arg1, arg2));
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun register_cctp_mayan_caller(arg0: &0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::AdminCap, arg1: &mut 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::State, arg2: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg3: u32, arg4: address) {
        0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::assert_valid_version(arg1);
        assert!(arg3 != 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::local_domain(arg2), 0);
        0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::add_cctp_mayan_caller(arg0, arg1, arg3, arg4);
    }

    entry fun register_cctp_mayan_recipient<T0>(arg0: &0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::AdminCap, arg1: &mut 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::State, arg2: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg3: u32, arg4: &0x2::coin_registry::Currency<T0>, arg5: address) {
        0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::assert_valid_version(arg1);
        assert!(arg3 != 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::local_domain(arg2), 0);
        let v0 = 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg4);
        0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::add_cctp_mayan_recipient(arg0, arg1, arg3, 0x2::object::id_to_address(&v0), arg5);
    }

    entry fun rescue_funds<T0>(arg0: &0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::AdminCap, arg1: &0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::State, arg2: &mut 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::FundsReceiver, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg4: address) {
        0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::assert_valid_version(arg1);
        let v0 = 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::rescue_funds<T0>(arg0, arg2, arg3);
        let v1 = FundsRescued{
            coin_id : 0x2::object::id<0x2::coin::Coin<T0>>(&v0),
            amount  : 0x2::coin::value<T0>(&v0),
            to      : arg4,
        };
        0x2::event::emit<FundsRescued>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg4);
    }

    public fun rescue_receive(arg0: &0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::AdminCap, arg1: &0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::State, arg2: vector<u8>, arg3: vector<u8>) : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::ReceiveMessageTicket<0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::circle_auth::CircleAuth> {
        0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::assert_valid_version(arg1);
        let v0 = 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::cctp_message::from_bytes(&arg2);
        let v1 = RescueReceiveStarted{
            cctp_nonce         : 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::cctp_message::nonce(&v0),
            cctp_source_domain : 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::cctp_message::source_domain(&v0),
            mint_recipient     : 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::cctp_message::mint_recipient(&v0),
            amount             : 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::cctp_message::amount_net(&v0),
        };
        0x2::event::emit<RescueReceiveStarted>(v1);
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::create_receive_message_ticket<0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::circle_auth::CircleAuth>(0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::circle_auth::new(), arg2, arg3)
    }

    entry fun set_pause(arg0: &0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::AdminCap, arg1: &mut 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::State, arg2: bool) {
        0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::assert_valid_version(arg1);
        0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::set_paused(arg0, arg1, arg2);
    }

    entry fun set_whitelisted_driver(arg0: &0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::AdminCap, arg1: &mut 0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::State, arg2: address, arg3: bool) {
        0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::assert_valid_version(arg1);
        0xaf68093caddd0560e6806ccfd29c8e5f79eb5fa58c173e1f6ef76720e900332f::state::set_whitelisted_driver(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

