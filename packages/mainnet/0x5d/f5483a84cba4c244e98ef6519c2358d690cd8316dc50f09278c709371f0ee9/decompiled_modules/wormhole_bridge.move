module 0xc6129ed341b014213284742d681766c48ea3cbb287f91685f0c0ccd608e17982::wormhole_bridge {
    struct WormholeBridge has drop {
        dummy_field: bool,
    }

    struct ChainTokenKey has copy, drop, store {
        chain_id: u16,
        token: vector<u8>,
    }

    struct BurnWindow has copy, drop, store {
        burned: u64,
        window_start_ms: u64,
    }

    struct PersonalBurnCap has store {
        cap_amount: u64,
        window_ms: u64,
        user_burns: 0x2::table::Table<address, BurnWindow>,
    }

    struct Bridge has key {
        id: 0x2::object::UID,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        trusted_emitters: 0x2::vec_map::VecMap<u16, vector<u8>>,
        minted_per_token: 0x2::vec_map::VecMap<ChainTokenKey, u64>,
        consumed_vaas: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs,
        keepers: 0x2::vec_set::VecSet<address>,
        daily_mint_limit: u64,
        mint_buckets: vector<u64>,
        mint_last_bucket: u64,
        max_mint_per_tx: u64,
        daily_burn_limit: u64,
        burn_buckets: vector<u64>,
        burn_last_bucket: u64,
        max_burn_per_tx: u64,
        personal_burn_cap: PersonalBurnCap,
        paused: bool,
        burn_nonce: u64,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
    }

    public fun add_keeper(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg1: &mut Bridge, arg2: address) {
        assert_valid_package_version(arg1);
        if (!0x2::vec_set::contains<address>(&arg1.keepers, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.keepers, arg2);
        };
    }

    public fun add_supported_evm_token(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg1: &mut Bridge, arg2: u16, arg3: vector<u8>) {
        assert_valid_package_version(arg1);
        if (0x1::vector::length<u8>(&arg3) != 20) {
            abort 13906836188683436039
        };
        let v0 = ChainTokenKey{
            chain_id : arg2,
            token    : arg3,
        };
        if (!0x2::vec_map::contains<ChainTokenKey, u64>(&arg1.minted_per_token, &v0)) {
            0x2::vec_map::insert<ChainTokenKey, u64>(&mut arg1.minted_per_token, v0, 0);
        };
    }

    public fun add_trusted_emitter(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg1: &mut Bridge, arg2: u16, arg3: vector<u8>) {
        assert_valid_package_version(arg1);
        if (0x1::vector::length<u8>(&arg3) != 32) {
            abort 13906836029769646087
        };
        if (0x2::vec_map::contains<u16, vector<u8>>(&arg1.trusted_emitters, &arg2)) {
            *0x2::vec_map::get_mut<u16, vector<u8>>(&mut arg1.trusted_emitters, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<u16, vector<u8>>(&mut arg1.trusted_emitters, arg2, arg3);
        };
    }

    public fun add_version(arg0: &mut Bridge, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            return
        };
        0x2::vec_set::insert<u16>(&mut arg0.allowed_versions, arg2);
    }

    fun append_left_padded(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: u64) {
        let v0 = 0x1::vector::length<u8>(arg1);
        if (v0 > arg2) {
            abort 13906837928145190919
        };
        let v1 = 0;
        while (v1 < arg2 - v0) {
            0x1::vector::push_back<u8>(arg0, 0);
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(arg0, *arg1);
    }

    fun append_u64_as_u256_be(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 0;
        while (v0 < 24) {
            0x1::vector::push_back<u8>(arg0, 0);
            v0 = v0 + 1;
        };
        let v1 = 64;
        while (v1 > 0) {
            let v2 = v1 - 8;
            v1 = v2;
            0x1::vector::push_back<u8>(arg0, ((arg1 >> v2 & 255) as u8));
        };
    }

    fun assert_nonzero_sui_recipient(arg0: address) {
        if (arg0 == @0x0) {
            abort 13906837863720681479
        };
    }

    fun assert_rate_limit_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        if (arg0 < 1000000000) {
            abort 13906837477175328801
        };
        if (arg2 < 1000000000) {
            abort 13906837481470296097
        };
        if (arg1 < 1) {
            abort 13906837485765263393
        };
        if (arg3 < 1) {
            abort 13906837490060230689
        };
    }

    public(friend) fun assert_valid_package<T0>(arg0: &0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T0>) {
        0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::assert_valid_module_version<T0, WormholeBridge>(arg0, package_version());
    }

    fun assert_valid_package_version(arg0: &Bridge) {
        let v0 = 3;
        assert!(0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0), 13906834732691357731);
    }

    public fun burn_for_withdrawal_authorized<T0, T1: drop>(arg0: &mut Bridge, arg1: &mut 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T0>, arg2: T1, arg3: u16, arg4: 0x2::object::ID, arg5: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u16, arg9: vector<u8>, arg10: vector<u8>, arg11: &0x2::clock::Clock) {
        assert_valid_package<T0>(arg1);
        0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::assert_valid_module_version<T0, T1>(arg1, arg3);
        if (arg0.paused) {
            abort 13906835759188279327
        };
        if (0x1::vector::length<u8>(&arg9) != 20) {
            abort 13906835763481673735
        };
        if (0x1::vector::length<u8>(&arg10) != 20) {
            abort 13906835767776641031
        };
        if (!0x2::vec_map::contains<u16, vector<u8>>(&arg0.trusted_emitters, &arg8)) {
            abort 13906835772071215105
        };
        let v0 = 0x2::coin::value<T0>(&arg6);
        if (v0 == 0) {
            abort 13906835784956510215
        };
        if (v0 > arg0.max_burn_per_tx) {
            abort 13906835789252395029
        };
        check_burn_rate_limit(arg0, v0, arg11);
        check_personal_burn_cap(arg0, arg4, v0, arg11);
        let v1 = 0x2::object::id_to_address(&arg4);
        record_burn(arg0, arg8, arg10, v0);
        0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::burn<T0, WormholeBridge>(arg1, arg4, witness(), package_version(), arg6, arg11);
        arg0.burn_nonce = arg0.burn_nonce + 1;
        let v2 = compute_withdrawal_id(v1, v0, &arg9, arg8, arg0.burn_nonce);
        0xc6129ed341b014213284742d681766c48ea3cbb287f91685f0c0ccd608e17982::events::emit_withdrawal_initiated(v2, v1, v0, arg9, arg8, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg5, arg7, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg0.emitter_cap, 0, encode_withdraw_payload(1, arg8, &v2, &arg9, &arg10, v0)), arg11));
    }

    public fun burn_nonce(arg0: &Bridge) : u64 {
        arg0.burn_nonce
    }

    fun check_burn_rate_limit(arg0: &mut Bridge, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 3600000;
        let v1 = if (v0 > arg0.burn_last_bucket) {
            v0 - arg0.burn_last_bucket
        } else {
            0
        };
        if (v1 >= 25) {
            let v2 = 0;
            while (v2 < 25) {
                *0x1::vector::borrow_mut<u64>(&mut arg0.burn_buckets, v2) = 0;
                v2 = v2 + 1;
            };
        } else {
            let v3 = 1;
            while (v3 <= v1) {
                *0x1::vector::borrow_mut<u64>(&mut arg0.burn_buckets, (arg0.burn_last_bucket + v3) % 25) = 0;
                v3 = v3 + 1;
            };
        };
        arg0.burn_last_bucket = v0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 25) {
            v4 = v4 + (*0x1::vector::borrow<u64>(&arg0.burn_buckets, v5) as u128);
            v5 = v5 + 1;
        };
        if (v4 + (arg1 as u128) > (arg0.daily_burn_limit as u128)) {
            abort 13906837296786046999
        };
        let v6 = v0 % 25;
        *0x1::vector::borrow_mut<u64>(&mut arg0.burn_buckets, v6) = *0x1::vector::borrow<u64>(&arg0.burn_buckets, v6) + arg1;
    }

    fun check_personal_burn_cap(arg0: &mut Bridge, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = &mut arg0.personal_burn_cap;
        if (v0.cap_amount == 0) {
            return
        };
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::object::id_to_address(&arg1);
        if (!0x2::table::contains<address, BurnWindow>(&v0.user_burns, v2)) {
            let v3 = BurnWindow{
                burned          : 0,
                window_start_ms : v1,
            };
            0x2::table::add<address, BurnWindow>(&mut v0.user_burns, v2, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, BurnWindow>(&mut v0.user_burns, v2);
        if (v1 >= v4.window_start_ms + v0.window_ms) {
            v4.burned = 0;
            v4.window_start_ms = v1;
        };
        let v5 = (v4.burned as u128) + (arg2 as u128);
        assert!(v5 <= (v0.cap_amount as u128), 13906837434225131545);
        v4.burned = (v5 as u64);
    }

    fun check_rate_limit(arg0: &mut Bridge, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 3600000;
        let v1 = if (v0 > arg0.mint_last_bucket) {
            v0 - arg0.mint_last_bucket
        } else {
            0
        };
        if (v1 >= 25) {
            let v2 = 0;
            while (v2 < 25) {
                *0x1::vector::borrow_mut<u64>(&mut arg0.mint_buckets, v2) = 0;
                v2 = v2 + 1;
            };
        } else {
            let v3 = 1;
            while (v3 <= v1) {
                *0x1::vector::borrow_mut<u64>(&mut arg0.mint_buckets, (arg0.mint_last_bucket + v3) % 25) = 0;
                v3 = v3 + 1;
            };
        };
        arg0.mint_last_bucket = v0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 25) {
            v4 = v4 + (*0x1::vector::borrow<u64>(&arg0.mint_buckets, v5) as u128);
            v5 = v5 + 1;
        };
        if (v4 + (arg1 as u128) > (arg0.daily_mint_limit as u128)) {
            abort 13906837198001537043
        };
        let v6 = v0 % 25;
        *0x1::vector::borrow_mut<u64>(&mut arg0.mint_buckets, v6) = *0x1::vector::borrow<u64>(&arg0.mint_buckets, v6) + arg1;
    }

    fun compute_withdrawal_id(arg0: address, arg1: u64, arg2: &vector<u8>, arg3: u16, arg4: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        let v1 = 64;
        while (v1 > 0) {
            v1 = v1 - 8;
            0x1::vector::push_back<u8>(&mut v0, ((arg1 >> v1 & 255) as u8));
        };
        0x1::vector::append<u8>(&mut v0, *arg2);
        0x1::vector::push_back<u8>(&mut v0, ((arg3 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg3 & 255) as u8));
        let v2 = 64;
        while (v2 > 0) {
            v2 = v2 - 8;
            0x1::vector::push_back<u8>(&mut v0, ((arg4 >> v2 & 255) as u8));
        };
        0x2::hash::keccak256(&v0)
    }

    public fun daily_burn_limit(arg0: &Bridge) : u64 {
        arg0.daily_burn_limit
    }

    public fun daily_burned(arg0: &Bridge) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 25) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg0.burn_buckets, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun daily_mint_limit(arg0: &Bridge) : u64 {
        arg0.daily_mint_limit
    }

    public fun daily_minted(arg0: &Bridge) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 25) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg0.mint_buckets, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun emergency_pause(arg0: &mut Bridge, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        assert_valid_package_version(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.keepers, &v0)) {
            abort 13906836527987294237
        };
        arg0.paused = true;
        0xc6129ed341b014213284742d681766c48ea3cbb287f91685f0c0ccd608e17982::events::emit_paused(true);
    }

    fun encode_withdraw_payload(arg0: u8, arg1: u16, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>, arg5: u64) : vector<u8> {
        if (0x1::vector::length<u8>(arg2) != 32) {
            abort 13906837610317611015
        };
        if (0x1::vector::length<u8>(arg3) != 20) {
            abort 13906837614612578311
        };
        if (0x1::vector::length<u8>(arg4) != 20) {
            abort 13906837618907545607
        };
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::vector::push_back<u8>(&mut v0, ((arg1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg1 & 255) as u8));
        0x1::vector::append<u8>(&mut v0, *arg2);
        let v1 = &mut v0;
        append_left_padded(v1, arg3, 32);
        let v2 = &mut v0;
        append_left_padded(v2, arg4, 32);
        let v3 = &mut v0;
        append_u64_as_u256_be(v3, arg5);
        if (0x1::vector::length<u8>(&v0) != 131) {
            abort 13906837666152185863
        };
        v0
    }

    public fun has_trusted_emitter(arg0: &Bridge, arg1: u16) : bool {
        0x2::vec_map::contains<u16, vector<u8>>(&arg0.trusted_emitters, &arg1)
    }

    public fun init_bridge(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_rate_limit_config(arg2, arg3, arg4, arg5);
        assert!(arg7 > 0, 13906835166482530331);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg1, arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = 0x2::object::new(arg9);
        let v3 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::new(arg9);
        let v4 = Bridge{
            id                : v2,
            emitter_cap       : v0,
            trusted_emitters  : 0x2::vec_map::empty<u16, vector<u8>>(),
            minted_per_token  : 0x2::vec_map::empty<ChainTokenKey, u64>(),
            consumed_vaas     : v3,
            keepers           : 0x2::vec_set::empty<address>(),
            daily_mint_limit  : arg2,
            mint_buckets      : new_rate_buckets(),
            mint_last_bucket  : v1 / 3600000,
            max_mint_per_tx   : arg3,
            daily_burn_limit  : arg4,
            burn_buckets      : new_rate_buckets(),
            burn_last_bucket  : v1 / 3600000,
            max_burn_per_tx   : arg5,
            personal_burn_cap : new_personal_burn_cap(arg6, arg7, arg9),
            paused            : false,
            burn_nonce        : 0,
            allowed_versions  : 0x2::vec_set::singleton<u16>(3),
        };
        0x2::transfer::share_object<Bridge>(v4);
        0xc6129ed341b014213284742d681766c48ea3cbb287f91685f0c0ccd608e17982::events::emit_bridge_initialized(0x2::object::uid_to_address(&v4.id));
    }

    public fun is_evm_token_supported(arg0: &Bridge, arg1: u16, arg2: vector<u8>) : bool {
        let v0 = ChainTokenKey{
            chain_id : arg1,
            token    : arg2,
        };
        0x2::vec_map::contains<ChainTokenKey, u64>(&arg0.minted_per_token, &v0)
    }

    public fun is_keeper(arg0: &Bridge, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.keepers, &arg1)
    }

    public fun max_burn_per_tx(arg0: &Bridge) : u64 {
        arg0.max_burn_per_tx
    }

    public fun max_mint_per_tx(arg0: &Bridge) : u64 {
        arg0.max_mint_per_tx
    }

    public fun minted_for(arg0: &Bridge, arg1: u16, arg2: vector<u8>) : u64 {
        let v0 = ChainTokenKey{
            chain_id : arg1,
            token    : arg2,
        };
        if (0x2::vec_map::contains<ChainTokenKey, u64>(&arg0.minted_per_token, &v0)) {
            *0x2::vec_map::get<ChainTokenKey, u64>(&arg0.minted_per_token, &v0)
        } else {
            0
        }
    }

    fun new_personal_burn_cap(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : PersonalBurnCap {
        PersonalBurnCap{
            cap_amount : arg0,
            window_ms  : arg1,
            user_burns : 0x2::table::new<address, BurnWindow>(arg2),
        }
    }

    fun new_rate_buckets() : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 25) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun package_version() : u16 {
        3
    }

    public fun paused(arg0: &Bridge) : bool {
        arg0.paused
    }

    public fun personal_burn_cap_amount(arg0: &Bridge) : u64 {
        arg0.personal_burn_cap.cap_amount
    }

    public fun personal_burn_cap_window_ms(arg0: &Bridge) : u64 {
        arg0.personal_burn_cap.window_ms
    }

    public fun personal_burned(arg0: &Bridge, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, BurnWindow>(&arg0.personal_burn_cap.user_burns, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, BurnWindow>(&arg0.personal_burn_cap.user_burns, arg1);
        if (0x2::clock::timestamp_ms(arg2) >= v0.window_start_ms + arg0.personal_burn_cap.window_ms) {
            0
        } else {
            v0.burned
        }
    }

    fun read_address(arg0: &vector<u8>, arg1: u64) : address {
        0x2::address::from_bytes(read_bytes(arg0, arg1, 32))
    }

    fun read_bytes(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun read_evm_address_padded(arg0: &vector<u8>, arg1: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 12;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun read_u256_as_u64(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 24) {
            if (*0x1::vector::borrow<u8>(arg0, arg1 + v0) != 0) {
                abort 13906837769232056337
            };
            v0 = v0 + 1;
        };
        read_u64_be(arg0, arg1 + 24)
    }

    fun read_u64_be(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    fun record_burn(arg0: &mut Bridge, arg1: u16, arg2: vector<u8>, arg3: u64) {
        let v0 = ChainTokenKey{
            chain_id : arg1,
            token    : arg2,
        };
        if (!0x2::vec_map::contains<ChainTokenKey, u64>(&arg0.minted_per_token, &v0)) {
            abort 13906837030497288203
        };
        let v1 = 0x2::vec_map::get_mut<ChainTokenKey, u64>(&mut arg0.minted_per_token, &v0);
        if (*v1 < arg3) {
            abort 13906837039087353869
        };
        *v1 = *v1 - arg3;
    }

    fun record_mint(arg0: &mut Bridge, arg1: u16, arg2: vector<u8>, arg3: u64) {
        let v0 = ChainTokenKey{
            chain_id : arg1,
            token    : arg2,
        };
        if (!0x2::vec_map::contains<ChainTokenKey, u64>(&arg0.minted_per_token, &v0)) {
            abort 13906837000432517131
        };
        let v1 = 0x2::vec_map::get_mut<ChainTokenKey, u64>(&mut arg0.minted_per_token, &v0);
        *v1 = *v1 + arg3;
    }

    public fun redeem_vaa<T0>(arg0: &mut Bridge, arg1: &mut 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T0>, arg2: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::DepositRequest<T0> {
        assert_valid_package<T0>(arg1);
        if (arg0.paused) {
            abort 13906835454245601311
        };
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg3, arg4, arg5);
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_chain(&v0);
        if (!0x2::vec_map::contains<u16, vector<u8>>(&arg0.trusted_emitters, &v1)) {
            abort 13906835484308406273
        };
        if (*0x2::vec_map::get<u16, vector<u8>>(&arg0.trusted_emitters, &v1) != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_address(&v0))) {
            abort 13906835488603504643
        };
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::payload(&v0);
        if (0x1::vector::length<u8>(&v2) != 139) {
            abort 13906835514373701641
        };
        if (*0x1::vector::borrow<u8>(&v2, 0) != 0) {
            abort 13906835518668406789
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::consume(&mut arg0.consumed_vaas, &v0);
        let v3 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(v0);
        let v4 = read_address(&v3, 35);
        let v5 = read_u256_as_u64(&v3, 99);
        assert_nonzero_sui_recipient(v4);
        if (v5 == 0) {
            abort 13906835570208145415
        };
        if (v5 > arg0.max_mint_per_tx) {
            abort 13906835574503768081
        };
        record_mint(arg0, v1, read_evm_address_padded(&v3, 67), v5);
        check_rate_limit(arg0, v5, arg5);
        0xc6129ed341b014213284742d681766c48ea3cbb287f91685f0c0ccd608e17982::events::emit_minted(v4, v5, v1, read_u64_be(&v3, 131), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&v0)));
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::request_deposit<T0>(arg2, 0x2::object::id_from_address(v4), 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::mint<T0, WormholeBridge>(arg1, witness(), package_version(), v5, arg6), b"")
    }

    public fun remove_keeper(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg1: &mut Bridge, arg2: address) {
        assert_valid_package_version(arg1);
        if (0x2::vec_set::contains<address>(&arg1.keepers, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.keepers, &arg2);
        };
    }

    public fun remove_supported_evm_token(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg1: &mut Bridge, arg2: u16, arg3: vector<u8>) {
        assert_valid_package_version(arg1);
        let v0 = ChainTokenKey{
            chain_id : arg2,
            token    : arg3,
        };
        if (!0x2::vec_map::contains<ChainTokenKey, u64>(&arg1.minted_per_token, &v0)) {
            return
        };
        if (*0x2::vec_map::get<ChainTokenKey, u64>(&arg1.minted_per_token, &v0) != 0) {
            abort 13906836253108469775
        };
        let (_, _) = 0x2::vec_map::remove<ChainTokenKey, u64>(&mut arg1.minted_per_token, &v0);
    }

    public fun remove_trusted_emitter(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg1: &mut Bridge, arg2: u16) {
        assert_valid_package_version(arg1);
        if (!0x2::vec_map::contains<u16, vector<u8>>(&arg1.trusted_emitters, &arg2)) {
            return
        };
        let v0 = 0x2::vec_map::keys<ChainTokenKey, u64>(&arg1.minted_per_token);
        let v1 = 0;
        while (v1 < 0x1::vector::length<ChainTokenKey>(&v0)) {
            let v2 = 0x1::vector::borrow<ChainTokenKey>(&v0, v1);
            if (v2.chain_id == arg2) {
                if (*0x2::vec_map::get<ChainTokenKey, u64>(&arg1.minted_per_token, v2) != 0) {
                    abort 13906836128554418191
                };
            };
            v1 = v1 + 1;
        };
        let (_, _) = 0x2::vec_map::remove<u16, vector<u8>>(&mut arg1.trusted_emitters, &arg2);
    }

    public fun remove_version(arg0: &mut Bridge, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            return
        };
        0x2::vec_set::remove<u16>(&mut arg0.allowed_versions, &arg2);
    }

    public fun reset_personal_burn_window(arg0: &mut Bridge, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: address) {
        assert_valid_package_version(arg0);
        if (0x2::table::contains<address, BurnWindow>(&arg0.personal_burn_cap.user_burns, arg2)) {
            0x2::table::remove<address, BurnWindow>(&mut arg0.personal_burn_cap.user_burns, arg2);
        };
    }

    public fun set_paused(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg1: &mut Bridge, arg2: bool) {
        assert_valid_package_version(arg1);
        arg1.paused = arg2;
        0xc6129ed341b014213284742d681766c48ea3cbb287f91685f0c0ccd608e17982::events::emit_paused(arg2);
    }

    public fun set_personal_burn_cap(arg0: &mut Bridge, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u64, arg3: u64) {
        assert_valid_package_version(arg0);
        assert!(arg3 > 0, 13906836412023046171);
        arg0.personal_burn_cap.cap_amount = arg2;
        arg0.personal_burn_cap.window_ms = arg3;
    }

    public fun set_rate_limits(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg1: &mut Bridge, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert_valid_package_version(arg1);
        assert_rate_limit_config(arg2, arg3, arg4, arg5);
        arg1.daily_mint_limit = arg2;
        arg1.max_mint_per_tx = arg3;
        arg1.daily_burn_limit = arg4;
        arg1.max_burn_per_tx = arg5;
    }

    public fun trusted_emitter(arg0: &Bridge, arg1: u16) : vector<u8> {
        *0x2::vec_map::get<u16, vector<u8>>(&arg0.trusted_emitters, &arg1)
    }

    public(friend) fun witness() : WormholeBridge {
        WormholeBridge{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

