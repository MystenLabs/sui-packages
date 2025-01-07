module 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::interface {
    public fun blacklist_type<T0: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config::ProtocolAdminCap, arg1: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config::Config) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config::assert_version(arg1);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config::blacklist_type<T0>(arg1);
    }

    public fun unblacklist_type<T0: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config::ProtocolAdminCap, arg1: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config::Config) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config::assert_version(arg1);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config::unblacklist_type<T0>(arg1);
    }

    public fun add_kiosk_storage<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg1);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::add_kiosk_storage<T0, T1>(arg1, arg0, arg2, arg3);
    }

    public fun add_plain_storage<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg1);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::add_plain_storage<T0, T1>(arg1, arg0, arg2);
    }

    public fun contains<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: 0x2::object::ID) : bool {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::contains<T0, T1>(arg0, arg1)
    }

    public fun create_fractionalized_coin<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: &mut 0x2::tx_context::TxContext) : 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::CreateVaultCap<T0> {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::create_fractionalized_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun create_vault<T0: drop, T1: store + key>(arg0: 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::CreateVaultCap<T0>, arg1: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config::Config, arg2: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::shared_wrapper::SharedWrapper<0x2::package::Publisher>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: bool, arg6: bool, arg7: bool, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) : (0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config::assert_type_not_blacklisted<T1>(arg1);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::new<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun deposit_into_kiosk_storage_get_coin<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: vector<T1>, arg3: &0x2::transfer_policy::TransferPolicy<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg0);
        let v0 = 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::deposit_into_kiosk_storage_get_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::events::emit_deposited<T0, T1>(arg0, nft_ids<T1>(&arg2), 0x2::coin::value<T0>(&v0));
        v0
    }

    public fun deposit_into_kiosk_storage_get_coin_and_keep<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: vector<T1>, arg3: &0x2::transfer_policy::TransferPolicy<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::deposit_into_kiosk_storage_get_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun deposit_into_kiosk_storage_get_token<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: vector<T1>, arg3: &0x2::transfer_policy::TransferPolicy<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg0);
        let v0 = 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::deposit_into_kiosk_storage_get_token<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::events::emit_deposited<T0, T1>(arg0, nft_ids<T1>(&arg2), 0x2::token::value<T0>(&v0));
        v0
    }

    public fun deposit_into_kiosk_storage_get_token_and_keep<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: vector<T1>, arg3: &0x2::transfer_policy::TransferPolicy<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg0);
        let v0 = deposit_into_kiosk_storage_get_token<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::token::keep<T0>(v0, arg4);
    }

    public fun deposit_into_plain_storage_get_coin<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: vector<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg0);
        let v0 = 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::deposit_into_plain_storage_get_coin<T0, T1>(arg0, arg1, arg2);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::events::emit_deposited<T0, T1>(arg0, nft_ids<T1>(&arg1), 0x2::coin::value<T0>(&v0));
        v0
    }

    public fun deposit_into_plain_storage_get_coin_and_keep<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: vector<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::deposit_into_plain_storage_get_coin<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun deposit_into_plain_storage_get_token<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: vector<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg0);
        let v0 = 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::deposit_into_plain_storage_get_token<T0, T1>(arg0, arg1, arg2);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::events::emit_deposited<T0, T1>(arg0, nft_ids<T1>(&arg1), 0x2::token::value<T0>(&v0));
        v0
    }

    public fun deposit_into_plain_storage_get_token_and_keep<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: vector<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg0);
        let v0 = deposit_into_plain_storage_get_token<T0, T1>(arg0, arg1, arg2);
        0x2::token::keep<T0>(v0, arg2);
    }

    public fun deposit_sui_to_kiosk_storage<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg0);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::deposit_sui_to_kiosk_storage<T0, T1>(arg0, arg1);
    }

    public fun disable_kiosk_deposit<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg1);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::disable_kiosk_deposit<T0, T1>(arg1, arg0);
    }

    public fun enable_kiosk_deposit<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg1);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::enable_kiosk_deposit<T0, T1>(arg1, arg0);
    }

    public fun fractions_amount<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>) : u64 {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::fractions_amount<T0, T1>(arg0)
    }

    public(friend) fun get_token_policy_cap<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>) : 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::HotPotatoWrapper<T0> {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg1);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::get_token_policy_cap<T0, T1>(arg1, arg0)
    }

    public fun has_kiosk_storage<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>) : bool {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::has_kiosk_storage<T0, T1>(arg0)
    }

    public fun has_plain_storage<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>) : bool {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::has_plain_storage<T0, T1>(arg0)
    }

    public fun ids<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>) : vector<0x2::object::ID> {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::ids<T0, T1>(arg0)
    }

    public fun nft_amount<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>) : u64 {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::nft_amount<T0, T1>(arg0)
    }

    fun nft_ids<T0: key>(arg0: &vector<T0>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(arg0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<T0>(0x1::vector::borrow<T0>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun publish_vault<T0: drop, T1: store + key>(arg0: 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::CreateVaultCap<T0>, arg1: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::config::Config, arg2: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::shared_wrapper::SharedWrapper<0x2::package::Publisher>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: bool, arg6: bool, arg7: bool, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_vault<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v2 = v0;
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::events::emit_vault_published<T0, T1>(&v2);
        0x2::transfer::public_share_object<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>>(v2);
        0x2::transfer::public_transfer<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>>(v1, 0x2::tx_context::sender(arg13));
    }

    public(friend) fun return_token_policy_cap<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg2: 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::HotPotatoWrapper<T0>) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg1);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::return_token_policy_cap<T0, T1>(arg1, arg0, arg2);
    }

    public fun set_description<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: 0x1::string::String) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::set_description<T0, T1>(arg0, arg1);
    }

    public fun set_image_url<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: 0x1::string::String) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::set_image_url<T0, T1>(arg0, arg1);
    }

    public fun set_name<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: 0x1::string::String) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::set_name<T0, T1>(arg0, arg1);
    }

    public fun set_nft_default_price<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg2: u64) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg1);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::set_nft_default_price<T0, T1>(arg1, arg0, arg2);
    }

    public fun set_project_url<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: 0x1::string::String) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::set_project_url<T0, T1>(arg0, arg1);
    }

    public fun set_thumbnail_url<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: 0x1::string::String) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::set_thumbnail_url<T0, T1>(arg0, arg1);
    }

    public fun supply<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>) : u64 {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::supply<T0, T1>(arg0)
    }

    public(friend) fun token_policy_cap_ref<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>) : &0x2::token::TokenPolicyCap<T0> {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::token_policy_cap_ref<T0, T1>(arg1, arg0)
    }

    public(friend) fun token_policy_cap_ref_from_wrapper<T0>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::HotPotatoWrapper<T0>) : &0x2::token::TokenPolicyCap<T0> {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::token_policy_cap_ref_from_wrapper<T0>(arg0)
    }

    public fun withdraw_from_kiosk_storage_provide_coin<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: vector<0x2::object::ID>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : (vector<T1>, vector<0x2::transfer_policy::TransferRequest<T1>>) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg0);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::events::emit_withdrawn<T0, T1>(arg0, arg2, 0x2::coin::value<T0>(&arg3));
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::withdraw_from_kiosk_storage_provide_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun withdraw_from_kiosk_storage_provide_token<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: vector<0x2::object::ID>, arg3: 0x2::token::Token<T0>, arg4: &mut 0x2::tx_context::TxContext) : (vector<T1>, vector<0x2::transfer_policy::TransferRequest<T1>>) {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg0);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::events::emit_withdrawn<T0, T1>(arg0, arg2, 0x2::token::value<T0>(&arg3));
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::withdraw_from_kiosk_storage_provide_token<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun withdraw_from_plain_storage_provide_coin<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: vector<0x2::object::ID>, arg2: 0x2::coin::Coin<T0>) : vector<T1> {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg0);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::events::emit_withdrawn<T0, T1>(arg0, arg1, 0x2::coin::value<T0>(&arg2));
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::withdraw_from_plain_storage_provide_coin<T0, T1>(arg0, arg1, arg2)
    }

    public fun withdraw_from_plain_storage_provide_token<T0, T1: store + key>(arg0: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg1: vector<0x2::object::ID>, arg2: 0x2::token::Token<T0>) : vector<T1> {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg0);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::events::emit_withdrawn<T0, T1>(arg0, arg1, 0x2::token::value<T0>(&arg2));
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::withdraw_from_plain_storage_provide_token<T0, T1>(arg0, arg1, arg2)
    }

    public fun withdraw_sui_from_kiosk_storage<T0, T1: store + key>(arg0: &0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::AdminCap<T0, T1>, arg1: &mut 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::Vault<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::assert_version<T0, T1>(arg1);
        0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::withdraw_sui_from_kiosk_storage<T0, T1>(arg1, arg0, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

