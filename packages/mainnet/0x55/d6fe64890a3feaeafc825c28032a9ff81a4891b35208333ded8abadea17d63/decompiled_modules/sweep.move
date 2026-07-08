module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::sweep {
    struct ReceiveWallet<phantom T0> has store, key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        endowment_id: 0x2::object::ID,
        owner: address,
        purpose: 0x1::string::String,
        inbound: 0x2::balance::Balance<T0>,
        sweep_threshold_mist: u64,
        per_sweep_cap_mist: u64,
        sweep_interval_ms: u64,
        sweep_bounty_mist: u64,
        last_sweep_ms: u64,
        nonce: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct ReceiveWalletCreated has copy, drop {
        receive_wallet_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        endowment_id: 0x2::object::ID,
        owner: address,
        purpose: 0x1::string::String,
        sweep_threshold_mist: u64,
        per_sweep_cap_mist: u64,
        sweep_interval_ms: u64,
        sweep_bounty_mist: u64,
        timestamp_ms: u64,
    }

    struct ReceiveWalletConfigured has copy, drop {
        receive_wallet_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        sweep_threshold_mist: u64,
        per_sweep_cap_mist: u64,
        sweep_interval_ms: u64,
        sweep_bounty_mist: u64,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct ReceiveWalletDeposited has copy, drop {
        receive_wallet_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        depositor: address,
        amount_mist: u64,
        inbound_mist: u64,
        timestamp_ms: u64,
    }

    struct ReceiveWalletSwept has copy, drop {
        receive_wallet_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        endowment_id: 0x2::object::ID,
        keeper: address,
        swept_mist: u64,
        bounty_mist: u64,
        credited_mist: u64,
        remaining_inbound_mist: u64,
        endowment_principal_mist: u64,
        nonce: u64,
        epoch_ms: u64,
    }

    fun assert_owner(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: address) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, arg1);
    }

    fun assert_endowment_matches<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::treasury::Endowment<T0>) {
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::treasury::endowment_character_id<T0>(arg1) == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 401);
    }

    fun assert_receive_wallet_matches<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &ReceiveWallet<T0>) {
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 401);
    }

    fun assert_receive_wallet_owner<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &ReceiveWallet<T0>, arg2: address) {
        assert_owner(arg0, arg2);
        assert!(arg1.owner == arg2, 400);
        assert_receive_wallet_matches<T0>(arg0, arg1);
    }

    fun assert_ref(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 402);
        assert!(0x1::vector::length<u8>(arg0) <= 512, 403);
    }

    fun assert_sweep_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg3 > 0, 405);
        assert!(arg0 >= 1, 406);
        assert!(arg1 >= arg0, 408);
        assert!(arg1 >= 1, 407);
        assert!(arg3 < arg0, 409);
        assert!(arg2 >= 86400000, 412);
    }

    entry fun configure_receive_wallet<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut ReceiveWallet<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_receive_wallet_owner<T0>(arg0, arg1, 0x2::tx_context::sender(arg7));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_sweep_params(arg2, arg3, arg4, arg5);
        arg1.sweep_threshold_mist = arg2;
        arg1.per_sweep_cap_mist = arg3;
        arg1.sweep_interval_ms = arg4;
        arg1.sweep_bounty_mist = arg5;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg6);
        let v0 = ReceiveWalletConfigured{
            receive_wallet_id    : 0x2::object::uid_to_inner(&arg1.id),
            character_id         : arg1.character_id,
            owner                : arg1.owner,
            sweep_threshold_mist : arg2,
            per_sweep_cap_mist   : arg3,
            sweep_interval_ms    : arg4,
            sweep_bounty_mist    : arg5,
            nonce                : arg1.nonce,
            timestamp_ms         : arg1.updated_at_ms,
        };
        0x2::event::emit<ReceiveWalletConfigured>(v0);
    }

    entry fun create_receive_wallet<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::treasury::Endowment<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg8));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_endowment_matches<T0>(arg0, arg1);
        assert_ref(&arg2);
        assert_sweep_params(arg3, arg4, arg5, arg6);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = ReceiveWallet<T0>{
            id                   : 0x2::object::new(arg8),
            character_id         : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            endowment_id         : 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::treasury::endowment_object_id<T0>(arg1),
            owner                : 0x2::tx_context::sender(arg8),
            purpose              : 0x1::string::utf8(arg2),
            inbound              : 0x2::balance::zero<T0>(),
            sweep_threshold_mist : arg3,
            per_sweep_cap_mist   : arg4,
            sweep_interval_ms    : arg5,
            sweep_bounty_mist    : arg6,
            last_sweep_ms        : 0,
            nonce                : 0,
            created_at_ms        : v0,
            updated_at_ms        : v0,
        };
        let v2 = ReceiveWalletCreated{
            receive_wallet_id    : 0x2::object::uid_to_inner(&v1.id),
            character_id         : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            endowment_id         : 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::treasury::endowment_object_id<T0>(arg1),
            owner                : 0x2::tx_context::sender(arg8),
            purpose              : v1.purpose,
            sweep_threshold_mist : arg3,
            per_sweep_cap_mist   : arg4,
            sweep_interval_ms    : arg5,
            sweep_bounty_mist    : arg6,
            timestamp_ms         : v0,
        };
        0x2::event::emit<ReceiveWalletCreated>(v2);
        0x2::transfer::share_object<ReceiveWallet<T0>>(v1);
    }

    entry fun deposit<T0>(arg0: &mut ReceiveWallet<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 404);
        0x2::coin::put<T0>(&mut arg0.inbound, arg1);
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v1 = ReceiveWalletDeposited{
            receive_wallet_id : 0x2::object::uid_to_inner(&arg0.id),
            character_id      : arg0.character_id,
            depositor         : 0x2::tx_context::sender(arg3),
            amount_mist       : v0,
            inbound_mist      : 0x2::balance::value<T0>(&arg0.inbound),
            timestamp_ms      : arg0.updated_at_ms,
        };
        0x2::event::emit<ReceiveWalletDeposited>(v1);
    }

    public fun inbound_mist<T0>(arg0: &ReceiveWallet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.inbound)
    }

    public fun last_sweep_ms<T0>(arg0: &ReceiveWallet<T0>) : u64 {
        arg0.last_sweep_ms
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun per_sweep_cap_mist<T0>(arg0: &ReceiveWallet<T0>) : u64 {
        arg0.per_sweep_cap_mist
    }

    public fun receive_wallet_character_id<T0>(arg0: &ReceiveWallet<T0>) : 0x2::object::ID {
        arg0.character_id
    }

    public fun receive_wallet_endowment_id<T0>(arg0: &ReceiveWallet<T0>) : 0x2::object::ID {
        arg0.endowment_id
    }

    public fun receive_wallet_nonce<T0>(arg0: &ReceiveWallet<T0>) : u64 {
        arg0.nonce
    }

    public fun receive_wallet_owner<T0>(arg0: &ReceiveWallet<T0>) : address {
        arg0.owner
    }

    public fun sweep_bounty_mist<T0>(arg0: &ReceiveWallet<T0>) : u64 {
        arg0.sweep_bounty_mist
    }

    public fun sweep_interval_ms<T0>(arg0: &ReceiveWallet<T0>) : u64 {
        arg0.sweep_interval_ms
    }

    entry fun sweep_receive_wallet<T0>(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut ReceiveWallet<T0>, arg2: &mut 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::treasury::Endowment<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_receive_wallet_matches<T0>(arg0, arg1);
        assert_endowment_matches<T0>(arg0, arg2);
        assert!(arg1.endowment_id == 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::treasury::endowment_object_id<T0>(arg2), 413);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (arg1.last_sweep_ms > 0) {
            assert!(v0 >= arg1.last_sweep_ms + arg1.sweep_interval_ms, 411);
        };
        let v1 = 0x2::balance::value<T0>(&arg1.inbound);
        assert!(v1 >= arg1.sweep_threshold_mist, 410);
        let v2 = min_u64(v1, arg1.per_sweep_cap_mist);
        let v3 = arg1.sweep_bounty_mist;
        let v4 = 0x2::balance::split<T0>(&mut arg1.inbound, v2);
        arg1.last_sweep_ms = v0;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = v0;
        let v5 = ReceiveWalletSwept{
            receive_wallet_id        : 0x2::object::uid_to_inner(&arg1.id),
            character_id             : arg1.character_id,
            endowment_id             : arg1.endowment_id,
            keeper                   : 0x2::tx_context::sender(arg4),
            swept_mist               : v2,
            bounty_mist              : v3,
            credited_mist            : 0x2::balance::value<T0>(&v4),
            remaining_inbound_mist   : 0x2::balance::value<T0>(&arg1.inbound),
            endowment_principal_mist : 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::treasury::deposit_swept_principal<T0>(arg2, v4, arg3),
            nonce                    : arg1.nonce,
            epoch_ms                 : v0,
        };
        0x2::event::emit<ReceiveWalletSwept>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v4, v3, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun sweep_threshold_mist<T0>(arg0: &ReceiveWallet<T0>) : u64 {
        arg0.sweep_threshold_mist
    }

    // decompiled from Move bytecode v7
}

