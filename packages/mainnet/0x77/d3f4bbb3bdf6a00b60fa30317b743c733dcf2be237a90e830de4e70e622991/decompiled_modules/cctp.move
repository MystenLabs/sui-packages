module 0x77d3f4bbb3bdf6a00b60fa30317b743c733dcf2be237a90e830de4e70e622991::cctp {
    struct SluiceBridge has drop {
        dummy_field: bool,
    }

    fun assert_usdc<T0>() {
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC", 13906834341847498759);
    }

    public fun burn_ticket<T0: drop>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::BridgeOut, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: u64, arg5: vector<u8>) : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::DepositForBurnWithPackageAuthTicket<T0, SluiceBridge> {
        assert_usdc<T0>();
        let v0 = SluiceBridge{dummy_field: false};
        let v1 = SluiceBridge{dummy_field: false};
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::create_deposit_for_burn_with_package_auth_ticket<T0, SluiceBridge>(arg2, 5, usdc_account(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::settle_bridge_out<SluiceBridge>(arg0, v0, arg1, 0x2::coin::value<T0>(&arg2), arg4), arg3), @0x0, (arg4 as u256), 2000, arg5, v1)
    }

    public fun claim_usdc<T0>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Account, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::Ticket<0x2::sui::SUI>) {
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::assert_relayer(arg0, arg4);
        assert_usdc<T0>();
        let v0 = SluiceBridge{dummy_field: false};
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account::take_received<T0, SluiceBridge>(arg0, v0, arg1, arg2, arg3, arg4)
    }

    public fun usdc_account(arg0: vector<u8>, arg1: u8) : address {
        0x1::vector::append<u8>(&mut arg0, x"06ddf6e1d765a193d9cbe146ceeb79ac1cb485ed5f5b37913a8cf5857eff00a9");
        0x1::vector::append<u8>(&mut arg0, x"c6fa7af3bedbad3a3d65f36aabc97431b1bbe4c2d2f6e0e47ca60203452f5d61");
        0x1::vector::push_back<u8>(&mut arg0, arg1);
        0x1::vector::append<u8>(&mut arg0, x"8c97258f4e2489f1bb3d1029148e0d830b5a1399daff1084048e7bd8dbe9f859");
        0x1::vector::append<u8>(&mut arg0, b"ProgramDerivedAddress");
        0x2::address::from_bytes(0x1::hash::sha2_256(arg0))
    }

    // decompiled from Move bytecode v7
}

