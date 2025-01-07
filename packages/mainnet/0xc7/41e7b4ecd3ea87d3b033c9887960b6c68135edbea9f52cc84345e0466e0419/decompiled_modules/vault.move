module 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct Vault<phantom T0, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        version: u64,
        mints_token: bool,
        plain_storage: 0x1::option::Option<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::PlainStorage>,
        kiosk_storage: 0x1::option::Option<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::KioskStorage>,
        kiosk_deposit_enabled: bool,
        ids: 0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::LinkedSet<0x2::object::ID>,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        token_policy_cap: 0x1::option::Option<0x2::token::TokenPolicyCap<T0>>,
        fractions_amount: u64,
    }

    struct AdminCap<phantom T0, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        display: 0x2::display::Display<Vault<T0, T1>>,
    }

    struct CreateVaultCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        decimals: u8,
    }

    struct HotPotatoWrapper<phantom T0> {
        token_policy_cap: 0x2::token::TokenPolicyCap<T0>,
    }

    public(friend) fun new<T0, T1: store + key>(arg0: CreateVaultCap<T0>, arg1: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::shared_wrapper::SharedWrapper<0x2::package::Publisher>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: bool, arg5: bool, arg6: bool, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, AdminCap<T0, T1>) {
        let CreateVaultCap {
            id           : v0,
            treasury_cap : v1,
            decimals     : v2,
        } = arg0;
        let v3 = v1;
        0x2::object::delete(v0);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(arg7));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(arg8));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(arg9));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(arg10));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(arg11));
        let v8 = 0x2::display::new_with_fields<Vault<T0, T1>>(0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::shared_wrapper::obj_ref<0x2::package::Publisher>(arg1), v4, v6, arg12);
        0x2::display::update_version<Vault<T0, T1>>(&mut v8);
        let v9 = if (arg5) {
            0x1::option::some<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::PlainStorage>(0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::new(arg12))
        } else {
            0x1::option::none<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::PlainStorage>()
        };
        let v10 = if (arg6) {
            0x1::option::some<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::KioskStorage>(0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::new(arg3, arg12))
        } else {
            0x1::option::none<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::KioskStorage>()
        };
        let v11 = if (arg4) {
            let (v12, v13) = 0x2::token::new_policy<T0>(&v3, arg12);
            0x2::token::share_policy<T0>(v12);
            0x1::option::some<0x2::token::TokenPolicyCap<T0>>(v13)
        } else {
            0x1::option::none<0x2::token::TokenPolicyCap<T0>>()
        };
        let v14 = Vault<T0, T1>{
            id                    : 0x2::object::new(arg12),
            version               : 1,
            mints_token           : arg4,
            plain_storage         : v9,
            kiosk_storage         : v10,
            kiosk_deposit_enabled : true,
            ids                   : 0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::empty<0x2::object::ID>(arg12),
            treasury_cap          : v3,
            token_policy_cap      : v11,
            fractions_amount      : 0x2::math::pow(10, v2),
        };
        let v15 = 0x2::coin::value<0x2::sui::SUI>(&arg2) != 0;
        if (v15 && arg6) {
            let v16 = &mut v14;
            deposit_sui_to_kiosk_storage<T0, T1>(v16, arg2);
        } else if (v15) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg12));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v17 = AdminCap<T0, T1>{
            id      : 0x2::object::new(arg12),
            display : v8,
        };
        (v14, v17)
    }

    fun kiosk_storage<T0, T1: store + key>(arg0: &Vault<T0, T1>) : &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::KioskStorage {
        0x1::option::borrow<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::KioskStorage>(&arg0.kiosk_storage)
    }

    public(friend) fun set_nft_default_price<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap<T0, T1>, arg2: u64) {
        assert_has_kiosk_storage<T0, T1>(arg0);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::set_nft_default_price(kiosk_storage_mut<T0, T1>(arg0), arg2);
    }

    fun plain_storage<T0, T1: store + key>(arg0: &Vault<T0, T1>) : &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::PlainStorage {
        0x1::option::borrow<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::PlainStorage>(&arg0.plain_storage)
    }

    public(friend) fun contains<T0, T1: store + key>(arg0: &Vault<T0, T1>, arg1: 0x2::object::ID) : bool {
        0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::contains<0x2::object::ID>(&arg0.ids, arg1)
    }

    public(friend) fun add_kiosk_storage<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_has_no_kiosk_storage<T0, T1>(arg0);
        0x1::option::fill<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::KioskStorage>(&mut arg0.kiosk_storage, 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::new(arg2, arg3));
    }

    public(friend) fun add_plain_storage<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_has_no_plain_storage<T0, T1>(arg0);
        0x1::option::fill<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::PlainStorage>(&mut arg0.plain_storage, 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::new(arg2));
    }

    fun assert_correct_kiosk<T0, T1: store + key>(arg0: &Vault<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk) {
        assert!(0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::is_correct_kiosk(kiosk_storage<T0, T1>(arg0), arg1), 8);
    }

    fun assert_enough_fractionalized_entity_to_withdraw_nft<T0, T1: store + key>(arg0: &Vault<T0, T1>, arg1: &vector<0x2::object::ID>, arg2: u64) {
        assert!(0x1::vector::length<0x2::object::ID>(arg1) <= arg2 / arg0.fractions_amount, 1);
    }

    fun assert_has_kiosk_storage<T0, T1: store + key>(arg0: &Vault<T0, T1>) {
        assert!(has_kiosk_storage<T0, T1>(arg0), 5);
    }

    fun assert_has_no_kiosk_storage<T0, T1: store + key>(arg0: &Vault<T0, T1>) {
        assert!(!has_kiosk_storage<T0, T1>(arg0), 7);
    }

    fun assert_has_no_plain_storage<T0, T1: store + key>(arg0: &Vault<T0, T1>) {
        assert!(!has_plain_storage<T0, T1>(arg0), 6);
    }

    fun assert_has_plain_storage<T0, T1: store + key>(arg0: &Vault<T0, T1>) {
        assert!(has_plain_storage<T0, T1>(arg0), 4);
    }

    fun assert_kiosk_deposit_enabled<T0, T1: store + key>(arg0: &Vault<T0, T1>) {
        assert!(arg0.kiosk_deposit_enabled, 2);
    }

    fun assert_mints_token<T0, T1: store + key>(arg0: &Vault<T0, T1>) {
        assert!(arg0.mints_token, 10);
    }

    fun assert_non_zero_vector_of_nft<T0>(arg0: &vector<T0>) {
        assert!(0x1::vector::length<T0>(arg0) > 0, 0);
    }

    fun assert_use_coin<T0, T1: store + key>(arg0: &Vault<T0, T1>) {
        assert!(!arg0.mints_token, 9);
    }

    public(friend) fun assert_version<T0, T1: store + key>(arg0: &Vault<T0, T1>) {
        assert!(arg0.version == 1, 11);
    }

    public(friend) fun create_fractionalized_coin<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: &mut 0x2::tx_context::TxContext) : CreateVaultCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        CreateVaultCap<T0>{
            id           : 0x2::object::new(arg6),
            treasury_cap : v0,
            decimals     : arg1,
        }
    }

    fun deposit_into_kiosk_storage<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: vector<T1>, arg3: &0x2::transfer_policy::TransferPolicy<T1>) : u64 {
        assert_has_kiosk_storage<T0, T1>(arg0);
        assert_correct_kiosk<T0, T1>(arg0, arg1);
        assert_kiosk_deposit_enabled<T0, T1>(arg0);
        assert_non_zero_vector_of_nft<T1>(&arg2);
        while (0x1::vector::length<T1>(&arg2) > 0) {
            let v0 = 0x1::vector::pop_back<T1>(&mut arg2);
            0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::push_front<0x2::object::ID>(&mut arg0.ids, 0x2::object::id<T1>(&v0));
            let v1 = kiosk_storage_mut<T0, T1>(arg0);
            0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::deposit<T1>(v1, arg1, arg3, v0);
        };
        0x1::vector::destroy_empty<T1>(arg2);
        0x1::vector::length<T1>(&arg2) * arg0.fractions_amount
    }

    public(friend) fun deposit_into_kiosk_storage_get_coin<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: vector<T1>, arg3: &0x2::transfer_policy::TransferPolicy<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_use_coin<T0, T1>(arg0);
        let v0 = deposit_into_kiosk_storage<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, v0, arg4)
    }

    public(friend) fun deposit_into_kiosk_storage_get_token<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: vector<T1>, arg3: &0x2::transfer_policy::TransferPolicy<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        assert_mints_token<T0, T1>(arg0);
        let v0 = deposit_into_kiosk_storage<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::token::mint<T0>(&mut arg0.treasury_cap, v0, arg4)
    }

    fun deposit_into_plain_storage<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: vector<T1>) : u64 {
        assert_has_plain_storage<T0, T1>(arg0);
        assert_non_zero_vector_of_nft<T1>(&arg1);
        while (0x1::vector::length<T1>(&arg1) > 0) {
            let v0 = 0x1::vector::pop_back<T1>(&mut arg1);
            0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::push_front<0x2::object::ID>(&mut arg0.ids, 0x2::object::id<T1>(&v0));
            let v1 = plain_storage_mut<T0, T1>(arg0);
            0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::deposit<T1>(v1, v0);
        };
        0x1::vector::destroy_empty<T1>(arg1);
        0x1::vector::length<T1>(&arg1) * arg0.fractions_amount
    }

    public(friend) fun deposit_into_plain_storage_get_coin<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: vector<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_use_coin<T0, T1>(arg0);
        let v0 = deposit_into_plain_storage<T0, T1>(arg0, arg1);
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, v0, arg2)
    }

    public(friend) fun deposit_into_plain_storage_get_token<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: vector<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        assert_mints_token<T0, T1>(arg0);
        let v0 = deposit_into_plain_storage<T0, T1>(arg0, arg1);
        0x2::token::mint<T0>(&mut arg0.treasury_cap, v0, arg2)
    }

    public(friend) fun deposit_sui_to_kiosk_storage<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::deposit_sui(kiosk_storage_mut<T0, T1>(arg0), 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun disable_kiosk_deposit<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap<T0, T1>) {
        assert_has_plain_storage<T0, T1>(arg0);
        arg0.kiosk_deposit_enabled = false;
    }

    public(friend) fun enable_kiosk_deposit<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap<T0, T1>) {
        arg0.kiosk_deposit_enabled = true;
    }

    public(friend) fun fractions_amount<T0, T1: store + key>(arg0: &Vault<T0, T1>) : u64 {
        arg0.fractions_amount
    }

    public(friend) fun get_token_policy_cap<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap<T0, T1>) : HotPotatoWrapper<T0> {
        assert_mints_token<T0, T1>(arg0);
        HotPotatoWrapper<T0>{token_policy_cap: 0x1::option::extract<0x2::token::TokenPolicyCap<T0>>(&mut arg0.token_policy_cap)}
    }

    public(friend) fun has_kiosk_storage<T0, T1: store + key>(arg0: &Vault<T0, T1>) : bool {
        0x1::option::is_some<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::KioskStorage>(&arg0.kiosk_storage)
    }

    public(friend) fun has_plain_storage<T0, T1: store + key>(arg0: &Vault<T0, T1>) : bool {
        0x1::option::is_some<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::PlainStorage>(&arg0.plain_storage)
    }

    public(friend) fun ids<T0, T1: store + key>(arg0: &Vault<T0, T1>) : vector<0x2::object::ID> {
        0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::into_vector<0x2::object::ID>(&arg0.ids)
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::shared_wrapper::wrap_and_share<0x2::package::Publisher>(0x2::package::claim<VAULT>(arg0, arg1), arg1);
    }

    fun kiosk_storage_mut<T0, T1: store + key>(arg0: &mut Vault<T0, T1>) : &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::KioskStorage {
        0x1::option::borrow_mut<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::KioskStorage>(&mut arg0.kiosk_storage)
    }

    public(friend) fun nft_amount<T0, T1: store + key>(arg0: &Vault<T0, T1>) : u64 {
        0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::length<0x2::object::ID>(&arg0.ids)
    }

    fun plain_storage_mut<T0, T1: store + key>(arg0: &mut Vault<T0, T1>) : &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::PlainStorage {
        0x1::option::borrow_mut<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::PlainStorage>(&mut arg0.plain_storage)
    }

    public(friend) fun return_token_policy_cap<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap<T0, T1>, arg2: HotPotatoWrapper<T0>) {
        let HotPotatoWrapper { token_policy_cap: v0 } = arg2;
        0x1::option::fill<0x2::token::TokenPolicyCap<T0>>(&mut arg0.token_policy_cap, v0);
    }

    public(friend) fun set_description<T0, T1: store + key>(arg0: &mut AdminCap<T0, T1>, arg1: 0x1::string::String) {
        0x2::display::edit<Vault<T0, T1>>(&mut arg0.display, 0x1::string::utf8(b"description"), arg1);
        0x2::display::update_version<Vault<T0, T1>>(&mut arg0.display);
    }

    public(friend) fun set_image_url<T0, T1: store + key>(arg0: &mut AdminCap<T0, T1>, arg1: 0x1::string::String) {
        0x2::display::edit<Vault<T0, T1>>(&mut arg0.display, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::update_version<Vault<T0, T1>>(&mut arg0.display);
    }

    public(friend) fun set_name<T0, T1: store + key>(arg0: &mut AdminCap<T0, T1>, arg1: 0x1::string::String) {
        0x2::display::edit<Vault<T0, T1>>(&mut arg0.display, 0x1::string::utf8(b"name"), arg1);
        0x2::display::update_version<Vault<T0, T1>>(&mut arg0.display);
    }

    public(friend) fun set_project_url<T0, T1: store + key>(arg0: &mut AdminCap<T0, T1>, arg1: 0x1::string::String) {
        0x2::display::edit<Vault<T0, T1>>(&mut arg0.display, 0x1::string::utf8(b"project_url"), arg1);
        0x2::display::update_version<Vault<T0, T1>>(&mut arg0.display);
    }

    public(friend) fun set_thumbnail_url<T0, T1: store + key>(arg0: &mut AdminCap<T0, T1>, arg1: 0x1::string::String) {
        0x2::display::edit<Vault<T0, T1>>(&mut arg0.display, 0x1::string::utf8(b"thumbnail_url"), arg1);
        0x2::display::update_version<Vault<T0, T1>>(&mut arg0.display);
    }

    public(friend) fun supply<T0, T1: store + key>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury_cap)
    }

    public(friend) fun token_policy_cap_ref<T0, T1: store + key>(arg0: &Vault<T0, T1>, arg1: &AdminCap<T0, T1>) : &0x2::token::TokenPolicyCap<T0> {
        assert_mints_token<T0, T1>(arg0);
        0x1::option::borrow<0x2::token::TokenPolicyCap<T0>>(&arg0.token_policy_cap)
    }

    public(friend) fun token_policy_cap_ref_from_wrapper<T0>(arg0: &HotPotatoWrapper<T0>) : &0x2::token::TokenPolicyCap<T0> {
        &arg0.token_policy_cap
    }

    fun withdraw_from_kiosk_storage<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: vector<0x2::object::ID>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (vector<T1>, vector<0x2::transfer_policy::TransferRequest<T1>>) {
        assert_has_kiosk_storage<T0, T1>(arg0);
        assert_correct_kiosk<T0, T1>(arg0, arg1);
        assert_enough_fractionalized_entity_to_withdraw_nft<T0, T1>(arg0, &arg2, arg3);
        let v0 = 0x1::vector::empty<T1>();
        let v1 = 0x1::vector::empty<0x2::transfer_policy::TransferRequest<T1>>();
        while (0x1::vector::length<0x2::object::ID>(&arg2) > 0) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg2);
            assert!(0x2::kiosk::has_item(arg1, v2), 3);
            let v3 = kiosk_storage_mut<T0, T1>(arg0);
            let (v4, v5) = 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::withdraw<T1>(v3, arg1, v2, arg4);
            0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::remove<0x2::object::ID>(&mut arg0.ids, v2);
            0x1::vector::push_back<T1>(&mut v0, v4);
            0x1::vector::push_back<0x2::transfer_policy::TransferRequest<T1>>(&mut v1, v5);
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
        (v0, v1)
    }

    public(friend) fun withdraw_from_kiosk_storage_provide_coin<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: vector<0x2::object::ID>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : (vector<T1>, vector<0x2::transfer_policy::TransferRequest<T1>>) {
        assert_use_coin<T0, T1>(arg0);
        let (v0, v1) = withdraw_from_kiosk_storage<T0, T1>(arg0, arg1, arg2, 0x2::coin::value<T0>(&arg3), arg4);
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg3);
        (v0, v1)
    }

    public(friend) fun withdraw_from_kiosk_storage_provide_token<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: vector<0x2::object::ID>, arg3: 0x2::token::Token<T0>, arg4: &mut 0x2::tx_context::TxContext) : (vector<T1>, vector<0x2::transfer_policy::TransferRequest<T1>>) {
        assert_mints_token<T0, T1>(arg0);
        let (v0, v1) = withdraw_from_kiosk_storage<T0, T1>(arg0, arg1, arg2, 0x2::token::value<T0>(&arg3), arg4);
        0x2::token::burn<T0>(&mut arg0.treasury_cap, arg3);
        (v0, v1)
    }

    fun withdraw_from_plain_storage<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) : vector<T1> {
        assert_has_plain_storage<T0, T1>(arg0);
        assert_enough_fractionalized_entity_to_withdraw_nft<T0, T1>(arg0, &arg1, arg2);
        let v0 = 0x1::vector::empty<T1>();
        while (0x1::vector::length<0x2::object::ID>(&arg1) > 0) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            assert!(0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::contains(plain_storage<T0, T1>(arg0), v1), 3);
            let v2 = plain_storage_mut<T0, T1>(arg0);
            0xdb982f402a039f196f3e13cd73795db441393b5bc6eef7a0295a333808982a7d::linked_set::remove<0x2::object::ID>(&mut arg0.ids, v1);
            0x1::vector::push_back<T1>(&mut v0, 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage::withdraw<T1>(v2, v1));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg1);
        v0
    }

    public(friend) fun withdraw_from_plain_storage_provide_coin<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: vector<0x2::object::ID>, arg2: 0x2::coin::Coin<T0>) : vector<T1> {
        assert_use_coin<T0, T1>(arg0);
        let v0 = withdraw_from_plain_storage<T0, T1>(arg0, arg1, 0x2::coin::value<T0>(&arg2));
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg2);
        v0
    }

    public(friend) fun withdraw_from_plain_storage_provide_token<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: vector<0x2::object::ID>, arg2: 0x2::token::Token<T0>) : vector<T1> {
        assert_mints_token<T0, T1>(arg0);
        let v0 = withdraw_from_plain_storage<T0, T1>(arg0, arg1, 0x2::token::value<T0>(&arg2));
        0x2::token::burn<T0>(&mut arg0.treasury_cap, arg2);
        v0
    }

    public(friend) fun withdraw_sui_from_kiosk_storage<T0, T1: store + key>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_has_kiosk_storage<T0, T1>(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::kiosk_storage::withdraw_sui(kiosk_storage_mut<T0, T1>(arg0), arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

