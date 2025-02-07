module 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::btc_transfer {
    struct BTCTransferModule has key {
        id: 0x2::object::UID,
        cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::ModuleCap,
        btc_module_id: 0x2::object::ID,
        simulation_public_key: vector<u8>,
        maximum_delay: u64,
    }

    public fun get_effects_btc_transfer(arg0: &BTCTransferModule, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::bitcoin_module::TxOutput>, arg4: 0x1::option::Option<0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::SignedPrice>, arg5: &0x2::clock::Clock) : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::TxEffectsResult<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::bitcoin_module::BTCAction> {
        if (0x1::option::is_some<0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::SignedPrice>(&arg4)) {
            assert!(0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::validate_signed_price(0x1::string::utf8(b"bitcoin"), arg1, b"native", arg0.simulation_public_key, arg0.maximum_delay, 0x1::option::borrow<0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::SignedPrice>(&arg4), arg5), 0);
        };
        let v0 = 0x1::vector::empty<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>();
        let v1 = 0;
        let v2 = 0x1::string::utf8(b"bitcoin:");
        0x1::string::append(&mut v2, arg1);
        while (v1 < 0x1::vector::length<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::bitcoin_module::TxOutput>(&arg3)) {
            let (v3, v4) = 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::bitcoin_module::view_tx_output(0x1::vector::borrow<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::bitcoin_module::TxOutput>(&arg3, v1));
            let v5 = if (0x1::option::is_some<0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::SignedPrice>(&arg4)) {
                let v6 = 0x1::option::destroy_some<0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::SignedPrice>(arg4);
                let (_, _, _, v10, v11, _, _) = 0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::view_signed_price(&v6);
                0x1::option::some<u256>((v4 as u256) * v10 / (0x2::math::pow(10, v11) as u256))
            } else {
                0x1::option::destroy_none<0xbc813cf16f98aa811aebb4da2e997d38f5347042c9e46ebfabd44d0e83f31b72::signature_utils::SignedPrice>(arg4);
                0x1::option::none<u256>()
            };
            0x1::vector::push_back<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::BalanceChange>(&mut v0, 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_balance_change(b"native", 0x1::option::some<vector<u8>>(v3), v2, (v4 as u256), v5, true));
            v1 = v1 + 1;
        };
        0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_tx_effects<0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::bitcoin_module::BTCAction>(&arg0.cap, arg2, arg0.btc_module_id, v2, 0x1::vector::empty<0x1::string::String>(), 0x1::option::none<vector<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::library::NetworkAddress>>(), v0, 0x5a4bd7f100e5ca68fdf6aef39aecf9561b8a52fc330b854cbee15aedc3822331::bitcoin_module::create_btc_action(arg3))
    }

    public fun init_btc_transfer_module(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = BTCTransferModule{
            id                    : v0,
            cap                   : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::module_interface::create_module_cap(0x2::object::uid_to_inner(&v0), arg3),
            btc_module_id         : arg0,
            simulation_public_key : arg1,
            maximum_delay         : arg2,
        };
        0x2::transfer::share_object<BTCTransferModule>(v1);
    }

    // decompiled from Move bytecode v6
}

