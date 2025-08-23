module 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::ntt {
    struct TransferTicket<phantom T0> {
        coins: 0x2::coin::Coin<T0>,
        token_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        trimmed_amount: 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::trimmed_amount::TrimmedAmount,
        recipient_chain: u16,
        recipient: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        payload: 0x1::option::Option<vector<u8>>,
        recipient_manager: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        should_queue: bool,
    }

    fun mint_or_unlock<T0>(arg0: &mut 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::State<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::mode::is_locking(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_mode<T0>(arg0))) {
            0x2::coin::take<T0>(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_balance_mut<T0>(arg0), arg1, arg2)
        } else {
            0x2::coin::mint<T0>(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_treasury_cap_mut<T0>(arg0), arg1, arg2)
        }
    }

    public fun prepare_transfer<T0>(arg0: &0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::State<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u16, arg4: vector<u8>, arg5: 0x1::option::Option<vector<u8>>, arg6: bool) : (TransferTicket<T0>, 0x2::balance::Balance<T0>) {
        let v0 = 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_peer<T0>(arg0, arg3);
        let (v1, v2) = 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::trimmed_amount::remove_dust<T0>(&mut arg1, 0x2::coin::get_decimals<T0>(arg2), 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::peer::get_token_decimals(v0));
        let v3 = TransferTicket<T0>{
            coins             : arg1,
            token_address     : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_id(0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2)),
            trimmed_amount    : v1,
            recipient_chain   : arg3,
            recipient         : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg4)),
            payload           : arg5,
            recipient_manager : *0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::peer::borrow_address(v0),
            should_queue      : arg6,
        };
        (v3, v2)
    }

    public fun redeem<T0, T1>(arg0: &mut 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::State<T0>, arg1: 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::upgrades::VersionGated, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::validated_transceiver_message::ValidatedTransceiverMessage<T1, vector<u8>>, arg4: &0x2::clock::Clock) {
        0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::upgrades::check_version<T0>(arg1, arg0);
        0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::assert_not_paused<T0>(arg0);
        let v0 = 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::auth::new_auth();
        let (v1, v2, v3) = 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::validated_transceiver_message::destruct_recipient_only<T1, 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::auth::ManagerAuth, 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::State<T0>, vector<u8>>(arg3, &v0, arg0);
        let v4 = v2;
        let (v5, v6, v7) = 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::ntt_manager_message::destruct<vector<u8>>(v3);
        let v8 = 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::ntt_manager_message::new<0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::NativeTokenTransfer>(v5, v6, 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::parse(v7));
        assert!(&v4 == 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::peer::borrow_address(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_peer<T0>(arg0, v1)), 13906835063401611263);
        0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::vote<T1, T0>(arg0, v1, v8);
        let (_, _, v11) = 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::ntt_manager_message::destruct<0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::NativeTokenTransfer>(v8);
        let (v12, _, _, v15, _) = 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::destruct(v11);
        let v17 = v12;
        assert!(v15 == 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::get_chain_id<T0>(arg0), 13906835089171677189);
        let v18 = 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::trimmed_amount::untrim(&v17, 0x2::coin::get_decimals<T0>(arg2));
        let v19 = 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::get_enabled_transceivers<T0>(arg0);
        if (0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::inbox::count_enabled_votes<0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::NativeTokenTransfer>(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_inbox_item_mut<T0>(arg0, v1, v8), &v19) < 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::get_threshold<T0>(arg0)) {
            return
        };
        let v20 = 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::rate_limit::consume_or_delay(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::peer::borrow_inbound_rate_limit_mut(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_peer_mut<T0>(arg0, v1)), arg4, v18);
        let v21 = if (0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::rate_limit::is_delayed(&v20)) {
            0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::rate_limit::delayed_until(&v20)
        } else {
            0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::rate_limit::refill(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::outbox::borrow_rate_limit_mut<0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::NativeTokenTransfer>(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_outbox_mut<T0>(arg0)), arg4, v18);
            0x2::clock::timestamp_ms(arg4)
        };
        0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::inbox::release_after<0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::NativeTokenTransfer>(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_inbox_item_mut<T0>(arg0, v1, v8), v21);
    }

    public fun release<T0>(arg0: &mut 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::State<T0>, arg1: 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::upgrades::VersionGated, arg2: u16, arg3: 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::ntt_manager_message::NttManagerMessage<0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::NativeTokenTransfer>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = release_impl<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
    }

    fun release_impl<T0>(arg0: &mut 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::State<T0>, arg1: 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::upgrades::VersionGated, arg2: u16, arg3: 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::ntt_manager_message::NttManagerMessage<0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::NativeTokenTransfer>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (address, 0x2::coin::Coin<T0>, 0x1::option::Option<vector<u8>>) {
        0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::upgrades::check_version<T0>(arg1, arg0);
        0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::assert_not_paused<T0>(arg0);
        if (!0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::try_release_in<T0>(arg0, arg2, arg3, arg5)) {
            abort 13906835402704158723
        };
        let (_, _, v2) = 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::ntt_manager_message::destruct<0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::NativeTokenTransfer>(arg3);
        let (v3, _, v5, _, v7) = 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::destruct(v2);
        let v8 = v3;
        (0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v5), mint_or_unlock<T0>(arg0, 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::trimmed_amount::untrim(&v8, 0x2::coin::get_decimals<T0>(arg4)), arg6), v7)
    }

    fun transfer_impl<T0>(arg0: &mut 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::State<T0>, arg1: 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::upgrades::VersionGated, arg2: &0x2::coin::CoinMetadata<T0>, arg3: TransferTicket<T0>, arg4: &0x2::clock::Clock, arg5: address) : 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::outbox::OutboxKey {
        0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::upgrades::check_version<T0>(arg1, arg0);
        0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::assert_not_paused<T0>(arg0);
        let TransferTicket {
            coins             : v0,
            token_address     : v1,
            trimmed_amount    : v2,
            recipient_chain   : v3,
            recipient         : v4,
            payload           : v5,
            recipient_manager : v6,
            should_queue      : v7,
        } = arg3;
        let v8 = v2;
        if (0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::mode::is_locking(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_mode<T0>(arg0))) {
            0x2::coin::put<T0>(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_balance_mut<T0>(arg0), v0);
        } else {
            0x2::coin::burn<T0>(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_treasury_cap_mut<T0>(arg0), v0);
        };
        let v9 = 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::rate_limit::consume_or_delay(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::outbox::borrow_rate_limit_mut<0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::NativeTokenTransfer>(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_outbox_mut<T0>(arg0)), arg4, 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::trimmed_amount::untrim(&v8, 0x2::coin::get_decimals<T0>(arg2)));
        let v10 = if (0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::rate_limit::is_delayed(&v9)) {
            if (!v7) {
                abort 13906834844358279169
            };
            0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::rate_limit::delayed_until(&v9)
        } else {
            0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::rate_limit::refill(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::peer::borrow_inbound_rate_limit_mut(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_peer_mut<T0>(arg0, v3)), arg4, 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::trimmed_amount::amount(&v8));
            0x2::clock::timestamp_ms(arg4)
        };
        0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::outbox::add<0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::NativeTokenTransfer>(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::borrow_outbox_mut<T0>(arg0), 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::outbox::new_outbox_item<0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::NativeTokenTransfer>(v10, v6, 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::ntt_manager_message::new<0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::NativeTokenTransfer>(0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::next_message_id<T0>(arg0), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(arg5), 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::native_token_transfer::new(v8, v1, v4, v3, v5))))
    }

    public fun transfer_tx_sender<T0>(arg0: &mut 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::State<T0>, arg1: 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::upgrades::VersionGated, arg2: &0x2::coin::CoinMetadata<T0>, arg3: TransferTicket<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::outbox::OutboxKey {
        transfer_impl<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::tx_context::sender(arg5))
    }

    public fun transfer_with_auth<T0, T1>(arg0: &T1, arg1: &mut 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::state::State<T0>, arg2: 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::upgrades::VersionGated, arg3: &0x2::coin::CoinMetadata<T0>, arg4: TransferTicket<T0>, arg5: &0x2::clock::Clock) : 0x7ecc21a6ac05e97faa4c331a6571906f523a9ec98758149f2fdfa35060a21575::outbox::OutboxKey {
        transfer_impl<T0>(arg1, arg2, arg3, arg4, arg5, 0xc85a2a3c5cdbe986bd22ab92e910f0ce283c8b38718ccd02969faafefd5a2697::contract_auth::assert_auth_type<T1>(arg0, b"NttSenderAuth"))
    }

    // decompiled from Move bytecode v6
}

