module 0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::vault {
    struct ChainTokenKey has copy, drop, store {
        chain_id: u16,
        token: vector<u8>,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::usdx::USDX>,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
        trusted_emitters: 0x2::vec_map::VecMap<u16, vector<u8>>,
        minted_per_token: 0x2::vec_map::VecMap<ChainTokenKey, u64>,
        consumed_vaas: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::ConsumedVAAs,
        revoked_operator_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        hourly_mint_limit: u64,
        hourly_minted: u64,
        window_start_ms: u64,
        max_mint_per_tx: u64,
        paused: bool,
        burn_nonce: u64,
    }

    public fun add_supported_evm_token(arg0: &0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::admin::AdminCap, arg1: &mut Vault, arg2: u16, arg3: vector<u8>) {
        assert_version(arg1);
        if (0x1::vector::length<u8>(&arg3) != 20) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_invalid_message();
        };
        let v0 = ChainTokenKey{
            chain_id : arg2,
            token    : arg3,
        };
        if (!0x2::vec_map::contains<ChainTokenKey, u64>(&arg1.minted_per_token, &v0)) {
            0x2::vec_map::insert<ChainTokenKey, u64>(&mut arg1.minted_per_token, v0, 0);
        };
    }

    public fun add_trusted_emitter(arg0: &0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::admin::AdminCap, arg1: &mut Vault, arg2: u16, arg3: vector<u8>) {
        assert_version(arg1);
        if (0x1::vector::length<u8>(&arg3) != 32) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_invalid_message();
        };
        if (0x2::vec_map::contains<u16, vector<u8>>(&arg1.trusted_emitters, &arg2)) {
            *0x2::vec_map::get_mut<u16, vector<u8>>(&mut arg1.trusted_emitters, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<u16, vector<u8>>(&mut arg1.trusted_emitters, arg2, arg3);
        };
    }

    public fun allow_version(arg0: &0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::admin::AdminCap, arg1: &mut Vault, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg1.allowed_versions, &arg2)) {
            0x2::vec_set::insert<u16>(&mut arg1.allowed_versions, arg2);
        };
    }

    public fun allowed_versions(arg0: &Vault) : vector<u16> {
        *0x2::vec_set::keys<u16>(&arg0.allowed_versions)
    }

    fun append_left_padded(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: u64) {
        let v0 = 0x1::vector::length<u8>(arg1);
        if (v0 > arg2) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_invalid_message();
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

    fun assert_version(arg0: &Vault) {
        let v0 = 0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::version::package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0)) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_invalid_version();
        };
    }

    public fun ban_operator_cap(arg0: &0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::admin::AdminCap, arg1: &mut Vault, arg2: 0x2::object::ID) {
        assert_version(arg1);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg1.revoked_operator_caps, &arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg1.revoked_operator_caps, arg2);
        };
    }

    public fun burn_for_withdrawal(arg0: &mut Vault, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: 0x2::coin::Coin<0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::usdx::USDX>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u16, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        if (arg0.paused) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_paused();
        };
        if (0x1::vector::length<u8>(&arg5) != 20) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_invalid_message();
        };
        if (0x1::vector::length<u8>(&arg6) != 20) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_invalid_message();
        };
        if (!0x2::vec_map::contains<u16, vector<u8>>(&arg0.trusted_emitters, &arg4)) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_unauthorized_origin();
        };
        let v0 = 0x2::coin::value<0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::usdx::USDX>(&arg2);
        if (v0 == 0) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_invalid_message();
        };
        record_burn(arg0, arg4, arg6, v0);
        0x2::coin::burn<0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::usdx::USDX>(&mut arg0.treasury_cap, arg2);
        arg0.burn_nonce = arg0.burn_nonce + 1;
        let v1 = compute_withdrawal_id(0x2::tx_context::sender(arg8), v0, &arg5, arg4, arg0.burn_nonce);
        0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::events::emit_withdrawal_initiated(v1, 0x2::tx_context::sender(arg8), v0, arg5, arg4, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg1, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg0.emitter_cap, 0, encode_withdraw_payload(1, arg4, &v1, &arg5, &arg6, v0)), arg7));
    }

    public fun burn_nonce(arg0: &Vault) : u64 {
        arg0.burn_nonce
    }

    fun check_rate_limit(arg0: &mut Vault, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 >= arg0.window_start_ms + 3600000) {
            arg0.window_start_ms = v0;
            arg0.hourly_minted = 0;
        };
        let v1 = arg0.hourly_minted + arg1;
        if (v1 > arg0.hourly_mint_limit) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_rate_limit_exceeded();
        };
        arg0.hourly_minted = v1;
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

    public fun disallow_version(arg0: &0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::admin::AdminCap, arg1: &mut Vault, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg1.allowed_versions, &arg2)) {
            0x2::vec_set::remove<u16>(&mut arg1.allowed_versions, &arg2);
        };
    }

    public fun emergency_pause(arg0: &0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::admin::OperatorCap, arg1: &mut Vault) {
        assert_version(arg1);
        let v0 = 0x2::object::id<0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::admin::OperatorCap>(arg0);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg1.revoked_operator_caps, &v0)) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_operator_revoked();
        };
        arg1.paused = true;
        0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::events::emit_paused(true);
    }

    fun encode_withdraw_payload(arg0: u8, arg1: u16, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>, arg5: u64) : vector<u8> {
        if (0x1::vector::length<u8>(arg2) != 32) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_invalid_message();
        };
        if (0x1::vector::length<u8>(arg3) != 20) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_invalid_message();
        };
        if (0x1::vector::length<u8>(arg4) != 20) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_invalid_message();
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
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_invalid_message();
        };
        v0
    }

    public fun has_trusted_emitter(arg0: &Vault, arg1: u16) : bool {
        0x2::vec_map::contains<u16, vector<u8>>(&arg0.trusted_emitters, &arg1)
    }

    public fun hourly_mint_limit(arg0: &Vault) : u64 {
        arg0.hourly_mint_limit
    }

    public fun hourly_minted(arg0: &Vault) : u64 {
        arg0.hourly_minted
    }

    public fun init_vault(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: 0x2::coin::TreasuryCap<0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::usdx::USDX>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id                    : 0x2::object::new(arg5),
            treasury_cap          : arg1,
            emitter_cap           : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg0, arg5),
            allowed_versions      : 0x2::vec_set::singleton<u16>(0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::version::package_version()),
            trusted_emitters      : 0x2::vec_map::empty<u16, vector<u8>>(),
            minted_per_token      : 0x2::vec_map::empty<ChainTokenKey, u64>(),
            consumed_vaas         : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::consumed_vaas::new(arg5),
            revoked_operator_caps : 0x2::vec_set::empty<0x2::object::ID>(),
            hourly_mint_limit     : arg2,
            hourly_minted         : 0,
            window_start_ms       : 0x2::clock::timestamp_ms(arg4),
            max_mint_per_tx       : arg3,
            paused                : false,
            burn_nonce            : 0,
        };
        0x2::transfer::share_object<Vault>(v0);
        0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::events::emit_vault_initialized(0x2::object::uid_to_address(&v0.id));
    }

    public fun is_evm_token_supported(arg0: &Vault, arg1: u16, arg2: vector<u8>) : bool {
        let v0 = ChainTokenKey{
            chain_id : arg1,
            token    : arg2,
        };
        0x2::vec_map::contains<ChainTokenKey, u64>(&arg0.minted_per_token, &v0)
    }

    public fun is_operator_cap_banned(arg0: &Vault, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_operator_caps, &arg1)
    }

    public fun max_mint_per_tx(arg0: &Vault) : u64 {
        arg0.max_mint_per_tx
    }

    public fun minted_for(arg0: &Vault, arg1: u16, arg2: vector<u8>) : u64 {
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

    public fun paused(arg0: &Vault) : bool {
        arg0.paused
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
                0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_amount_too_large();
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

    fun record_burn(arg0: &mut Vault, arg1: u16, arg2: vector<u8>, arg3: u64) {
        let v0 = ChainTokenKey{
            chain_id : arg1,
            token    : arg2,
        };
        if (!0x2::vec_map::contains<ChainTokenKey, u64>(&arg0.minted_per_token, &v0)) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_unsupported_evm_token();
        };
        let v1 = 0x2::vec_map::get_mut<ChainTokenKey, u64>(&mut arg0.minted_per_token, &v0);
        if (*v1 < arg3) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_insufficient_backing();
        };
        *v1 = *v1 - arg3;
    }

    fun record_mint(arg0: &mut Vault, arg1: u16, arg2: vector<u8>, arg3: u64) {
        let v0 = ChainTokenKey{
            chain_id : arg1,
            token    : arg2,
        };
        if (!0x2::vec_map::contains<ChainTokenKey, u64>(&arg0.minted_per_token, &v0)) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_unsupported_evm_token();
        };
        let v1 = 0x2::vec_map::get_mut<ChainTokenKey, u64>(&mut arg0.minted_per_token, &v0);
        *v1 = *v1 + arg3;
    }

    public fun redeem_vaa(arg0: &mut Vault, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        if (arg0.paused) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_paused();
        };
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg1, arg2, arg3);
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_chain(&v0);
        if (!0x2::vec_map::contains<u16, vector<u8>>(&arg0.trusted_emitters, &v1)) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_unauthorized_origin();
        };
        if (*0x2::vec_map::get<u16, vector<u8>>(&arg0.trusted_emitters, &v1) != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_address(&v0))) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_unauthorized_emitter();
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::consume(&mut arg0.consumed_vaas, &v0);
        let v2 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(v0);
        if (0x1::vector::length<u8>(&v2) != 139) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_payload_too_short();
        };
        if (*0x1::vector::borrow<u8>(&v2, 0) != 0) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_wrong_message_type();
        };
        let v3 = read_address(&v2, 35);
        let v4 = read_u256_as_u64(&v2, 99);
        if (v4 > arg0.max_mint_per_tx) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_amount_too_large();
        };
        record_mint(arg0, v1, read_evm_address_padded(&v2, 67), v4);
        check_rate_limit(arg0, v4, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::usdx::USDX>>(0x2::coin::mint<0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::usdx::USDX>(&mut arg0.treasury_cap, v4, arg4), v3);
        0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::events::emit_minted(v3, v4, v1, read_u64_be(&v2, 131), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&v0)));
    }

    public fun remove_supported_evm_token(arg0: &0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::admin::AdminCap, arg1: &mut Vault, arg2: u16, arg3: vector<u8>) {
        assert_version(arg1);
        let v0 = ChainTokenKey{
            chain_id : arg2,
            token    : arg3,
        };
        if (!0x2::vec_map::contains<ChainTokenKey, u64>(&arg1.minted_per_token, &v0)) {
            return
        };
        if (*0x2::vec_map::get<ChainTokenKey, u64>(&arg1.minted_per_token, &v0) != 0) {
            0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error::err_outstanding_backing();
        };
        let (_, _) = 0x2::vec_map::remove<ChainTokenKey, u64>(&mut arg1.minted_per_token, &v0);
    }

    public fun remove_trusted_emitter(arg0: &0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::admin::AdminCap, arg1: &mut Vault, arg2: u16) {
        assert_version(arg1);
        if (0x2::vec_map::contains<u16, vector<u8>>(&arg1.trusted_emitters, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<u16, vector<u8>>(&mut arg1.trusted_emitters, &arg2);
        };
    }

    public fun set_paused(arg0: &0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::admin::AdminCap, arg1: &mut Vault, arg2: bool) {
        assert_version(arg1);
        arg1.paused = arg2;
        0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::events::emit_paused(arg2);
    }

    public fun set_rate_limits(arg0: &0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::admin::AdminCap, arg1: &mut Vault, arg2: u64, arg3: u64) {
        assert_version(arg1);
        arg1.hourly_mint_limit = arg2;
        arg1.max_mint_per_tx = arg3;
    }

    public fun trusted_emitter(arg0: &Vault, arg1: u16) : vector<u8> {
        *0x2::vec_map::get<u16, vector<u8>>(&arg0.trusted_emitters, &arg1)
    }

    public fun unban_operator_cap(arg0: &0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::admin::AdminCap, arg1: &mut Vault, arg2: 0x2::object::ID) {
        assert_version(arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg1.revoked_operator_caps, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg1.revoked_operator_caps, &arg2);
        };
    }

    // decompiled from Move bytecode v6
}

