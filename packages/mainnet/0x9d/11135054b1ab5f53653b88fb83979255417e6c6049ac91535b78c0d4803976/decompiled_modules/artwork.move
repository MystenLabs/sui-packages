module 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::artwork {
    struct ArtworkVault<phantom T0> has key {
        id: 0x2::object::UID,
        metadata: ArtworkMetadata,
        round: u8,
        token_balance: 0x2::balance::Balance<T0>,
        allocated_tokens: u64,
        usdc_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        token_redeem_rate: u64,
        active_offering: 0x1::option::Option<0x2::object::ID>,
        past_offerings: vector<0x2::object::ID>,
        compatible_versions: 0x2::vec_set::VecSet<u64>,
    }

    struct ArtworkMetadata has store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        symbol: 0x1::string::String,
        image_url: 0x1::string::String,
        appraised_value: u64,
        is_sold: bool,
        sale_price: u64,
    }

    struct WAT<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        balance: 0x2::balance::Balance<T0>,
        artwork_vault: 0x2::object::ID,
    }

    struct ARTWORK has drop {
        dummy_field: bool,
    }

    public fun activate_trading_round<T0>(arg0: &mut ArtworkVault<T0>, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: &0x2::clock::Clock, arg3: 0x2::transfer::Receiving<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::Offering>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(current_round<T0>(arg0) == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::round_presale(), 8);
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg4), 5);
        let v0 = receive_offering_<T0>(arg0, arg3);
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::is_closed(&v0, arg2), 10);
        0x2::transfer::public_transfer<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::Offering>(v0, vault_address<T0>(arg0));
        arg0.round = 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::round_trading();
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::events::emit_trading_started(0x2::object::id<ArtworkVault<T0>>(arg0), 0x2::clock::timestamp_ms(arg2));
    }

    public fun appraised_value<T0>(arg0: &ArtworkVault<T0>) : u64 {
        arg0.metadata.appraised_value
    }

    public fun claim_earnings<T0>(arg0: &mut ArtworkVault<T0>, arg1: &mut 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::treasury_store::TreasuryStore, arg2: vector<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(current_round<T0>(arg0) == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::round_redeem(), 3);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::coin::Coin<T0>>(&arg2)) {
            let v2 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2);
            v0 = v0 + 0x2::coin::value<T0>(&v2);
            0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::treasury_store::burn_token<T0>(arg1, v2, arg3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
        let v3 = 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::helper::calculate_earnings(v0, token_redeem_rate<T0>(arg0));
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_balance) >= v3, 7);
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::events::emit_tokens_redeemed(0x2::object::id<ArtworkVault<T0>>(arg0), 0x2::tx_context::sender(arg3), v0, v3);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, v3), arg3)
    }

    public fun construct_artwork_metadata(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64) : ArtworkMetadata {
        ArtworkMetadata{
            name            : arg0,
            description     : arg1,
            symbol          : arg2,
            image_url       : arg3,
            appraised_value : arg4,
            is_sold         : false,
            sale_price      : 0,
        }
    }

    public fun current_offering<T0>(arg0: &ArtworkVault<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.active_offering
    }

    public fun current_round<T0>(arg0: &ArtworkVault<T0>) : u8 {
        arg0.round
    }

    public fun deposit_usdc<T0>(arg0: &mut ArtworkVault<T0>, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(arg1) == 0x2::tx_context::sender(arg3), 5);
        assert!(is_sold<T0>(arg0), 3);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
    }

    public fun description<T0>(arg0: &ArtworkVault<T0>) : 0x1::string::String {
        arg0.metadata.description
    }

    public fun image_url<T0>(arg0: &ArtworkVault<T0>) : 0x1::string::String {
        arg0.metadata.image_url
    }

    fun init(arg0: ARTWORK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ARTWORK>(arg0, arg1);
    }

    public fun is_sold<T0>(arg0: &ArtworkVault<T0>) : bool {
        arg0.metadata.is_sold
    }

    public fun mark_as_sold<T0>(arg0: &mut ArtworkVault<T0>, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(current_round<T0>(arg0) != 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::round_presale(), 9);
        assert!(arg2 > 0, 11);
        assert!(arg3 > 0, 11);
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg5), 5);
        arg0.metadata.is_sold = true;
        arg0.metadata.sale_price = arg2;
        arg0.round = 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::round_redeem();
        arg0.token_redeem_rate = arg3;
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::events::emit_artwork_sold(0x2::object::id<ArtworkVault<T0>>(arg0), arg2);
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::events::emit_redeem_started(0x2::object::id<ArtworkVault<T0>>(arg0), 0x2::clock::timestamp_ms(arg4), sale_price<T0>(arg0), token_redeem_rate<T0>(arg0));
    }

    public fun name<T0>(arg0: &ArtworkVault<T0>) : 0x1::string::String {
        arg0.metadata.name
    }

    public fun new_artwork_vault<T0>(arg0: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>, arg1: &mut 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::treasury_store::TreasuryStore, arg2: u64, arg3: ArtworkMetadata, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(arg0) == 0x2::tx_context::sender(arg4), 5);
        let v0 = 0x2::object::new(arg4);
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::events::emit_artwork_created(0x2::object::uid_to_inner(&v0), arg3.name, arg3.description, arg3.image_url, arg3.appraised_value, arg2);
        let v1 = ArtworkVault<T0>{
            id                  : v0,
            metadata            : arg3,
            round               : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::round_presale(),
            token_balance       : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::treasury_store::take_internal<T0>(arg1, arg2, arg4),
            allocated_tokens    : 0,
            usdc_balance        : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            token_redeem_rate   : 0,
            active_offering     : 0x1::option::none<0x2::object::ID>(),
            past_offerings      : 0x1::vector::empty<0x2::object::ID>(),
            compatible_versions : 0x2::vec_set::singleton<u64>(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::versioning::current_version()),
        };
        0x2::transfer::share_object<ArtworkVault<T0>>(v1);
    }

    public fun new_offering<T0>(arg0: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>, arg1: &mut ArtworkVault<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(arg0) == 0x2::tx_context::sender(arg7), 5);
        assert!(0x2::balance::value<T0>(&arg1.token_balance) >= arg4 + arg1.allocated_tokens, 7);
        let v0 = 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::new(vault_id<T0>(arg1), arg2, arg3, arg4, arg5, arg6, arg7);
        set_active_offering<T0>(arg1, 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::id(&v0));
        arg1.allocated_tokens = arg1.allocated_tokens + arg4;
        0x2::transfer::public_transfer<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::Offering>(v0, vault_address<T0>(arg1));
    }

    public fun purchase_wat<T0>(arg0: &mut ArtworkVault<T0>, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: 0x2::transfer::Receiving<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::Offering>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(current_round<T0>(arg0) == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::round_presale(), 3);
        let v0 = receive_offering_<T0>(arg0, arg3);
        assert!(!0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::is_closed(&v0, arg2) && 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::is_state_active(&v0), 13);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) >= 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::token_price(&v0) + 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::helper::calculate_fee(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::token_price(&v0), 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::fee_rate_bps(&v0)), 0);
        let (v1, v2, v3) = 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::helper::calculate_purchase(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1), 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::fee_rate_bps(&v0), 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::token_price(&v0));
        assert!(v3 <= 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::available_tokens(&v0), 7);
        let v4 = 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1);
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::collect_fee(&mut v0, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v4, v1));
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::deposit(&mut v0, v4);
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::update_tokens_sold(&mut v0, v3);
        let v5 = WAT<T0>{
            id            : 0x2::object::new(arg4),
            name          : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::wat_display_name(),
            description   : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::wat_display_description(),
            image_url     : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::wat_display_image_url(),
            project_url   : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::wat_display_project_url(),
            creator       : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::wat_display_creator(),
            balance       : 0x2::balance::split<T0>(&mut arg0.token_balance, v3),
            artwork_vault : vault_id<T0>(arg0),
        };
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::events::emit_tokens_purchased(vault_id<T0>(arg0), 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::id(&v0), 0x2::tx_context::sender(arg4), v3, v2, v1);
        0x2::transfer::transfer<WAT<T0>>(v5, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::Offering>(v0, vault_address<T0>(arg0));
    }

    public fun receive_offering<T0>(arg0: &mut ArtworkVault<T0>, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: 0x2::transfer::Receiving<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::Offering>, arg3: &mut 0x2::tx_context::TxContext) : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::Offering {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg3), 5);
        0x2::transfer::public_receive<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::Offering>(&mut arg0.id, arg2)
    }

    public(friend) fun receive_offering_<T0>(arg0: &mut ArtworkVault<T0>, arg1: 0x2::transfer::Receiving<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::Offering>) : 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::Offering {
        0x2::transfer::public_receive<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::offering::Offering>(&mut arg0.id, arg1)
    }

    public(friend) fun remove_active_offering<T0>(arg0: &mut ArtworkVault<T0>) {
        arg0.active_offering = 0x1::option::none<0x2::object::ID>();
    }

    public fun sale_price<T0>(arg0: &ArtworkVault<T0>) : u64 {
        arg0.metadata.sale_price
    }

    public(friend) fun set_active_offering<T0>(arg0: &mut ArtworkVault<T0>, arg1: 0x2::object::ID) {
        arg0.active_offering = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun symbol<T0>(arg0: &ArtworkVault<T0>) : 0x1::string::String {
        arg0.metadata.symbol
    }

    public fun token_balance<T0>(arg0: &ArtworkVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.token_balance)
    }

    public fun token_redeem_rate<T0>(arg0: &ArtworkVault<T0>) : u64 {
        arg0.token_redeem_rate
    }

    public fun unlock_tokens<T0>(arg0: WAT<T0>, arg1: &mut ArtworkVault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(current_round<T0>(arg1) == 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants::round_trading(), 3);
        let WAT {
            id            : v0,
            name          : _,
            description   : _,
            image_url     : _,
            project_url   : _,
            creator       : _,
            balance       : v6,
            artwork_vault : _,
        } = arg0;
        let v8 = v6;
        0x2::object::delete(v0);
        0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::events::emit_tokens_unlocked(0x2::object::id<ArtworkVault<T0>>(arg1), 0x2::tx_context::sender(arg2), 0x2::balance::value<T0>(&v8));
        0x2::coin::from_balance<T0>(v8, arg2)
    }

    public fun update_appraised_value<T0>(arg0: &mut ArtworkVault<T0>, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg3), 5);
        arg0.metadata.appraised_value = arg2;
    }

    public fun update_metadata<T0>(arg0: &mut ArtworkVault<T0>, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg4), 5);
        if (arg2 == 0x1::string::utf8(b"name")) {
            arg0.metadata.name = arg3;
        } else if (arg2 == 0x1::string::utf8(b"description")) {
            arg0.metadata.description = arg3;
        } else if (arg2 == 0x1::string::utf8(b"symbol")) {
            arg0.metadata.symbol = arg3;
        } else {
            assert!(arg2 == 0x1::string::utf8(b"image_url"), 12);
            arg0.metadata.image_url = arg3;
        };
    }

    public fun update_token_redeem_rate<T0>(arg0: &mut ArtworkVault<T0>, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::Admin>(arg1) == 0x2::tx_context::sender(arg3), 5);
        arg0.token_redeem_rate = arg2;
    }

    public fun usdc_balance<T0>(arg0: &ArtworkVault<T0>) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_balance)
    }

    public fun vault_address<T0>(arg0: &ArtworkVault<T0>) : address {
        let v0 = vault_id<T0>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public fun vault_id<T0>(arg0: &ArtworkVault<T0>) : 0x2::object::ID {
        0x2::object::id<ArtworkVault<T0>>(arg0)
    }

    public fun wat_balance<T0>(arg0: &WAT<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun withdraw_usdc<T0>(arg0: &mut ArtworkVault<T0>, arg1: &0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::RoleProof<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::owner<0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::role_store::SuperAdmin>(arg1) == 0x2::tx_context::sender(arg2), 5);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance), arg2)
    }

    // decompiled from Move bytecode v6
}

