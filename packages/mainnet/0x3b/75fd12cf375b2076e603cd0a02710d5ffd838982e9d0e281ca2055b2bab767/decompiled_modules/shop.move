module 0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop {
    struct CommerceAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ShopRegistry has key {
        id: 0x2::object::UID,
    }

    struct CharacterSaleKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct CosmeticSaleKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct PolicyKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CanonicalPolicy has copy, drop, store {
        policy_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct MintProceeds has drop {
        dummy_field: bool,
    }

    struct CharacterSale has key {
        id: 0x2::object::UID,
        version: u64,
        definition_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        price_mist: u64,
        minted: u64,
        max_supply: u64,
        paused: bool,
        mint_cap: 0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::MintCap,
    }

    struct CosmeticSale has key {
        id: 0x2::object::UID,
        version: u64,
        definition_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        price_mist: u64,
        minted: u64,
        max_supply: u64,
        paused: bool,
        mint_cap: 0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::MintCap,
    }

    struct SaleCreated has copy, drop {
        sale_id: 0x2::object::ID,
        definition_id: 0x2::object::ID,
        is_character: bool,
        price_mist: u64,
        max_supply: u64,
        policy_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct SaleUpdated has copy, drop {
        sale_id: 0x2::object::ID,
        price_mist: u64,
        max_supply: u64,
        paused: bool,
    }

    struct CharacterPurchased has copy, drop {
        sale_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        buyer: address,
        kiosk_id: 0x2::object::ID,
        edition_serial: u64,
        price_mist: u64,
    }

    struct CosmeticPurchased has copy, drop {
        sale_id: 0x2::object::ID,
        cosmetic_id: 0x2::object::ID,
        buyer: address,
        kiosk_id: 0x2::object::ID,
        price_mist: u64,
    }

    fun assert_canonical<T0, T1>(arg0: &ShopRegistry, arg1: 0x2::object::ID) : (0x2::object::ID, 0x1::type_name::TypeName) {
        assert!(canonical_policy_id<T1>(arg0) == 0x1::option::some<0x2::object::ID>(arg1), 13906836493627490332);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(canonical_policy_coin_type<T1>(arg0) == 0x1::option::some<0x1::type_name::TypeName>(v0), 13906836502217555998);
        (arg1, v0)
    }

    fun assert_character_mintable<T0>(arg0: &CharacterSale, arg1: &0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CharacterDefinition, arg2: &0x2::transfer_policy::TransferPolicy<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>) {
        assert!(arg0.version == 1, 13906836558050426884);
        assert!(!arg0.paused, 13906836562345525254);
        assert!(0x2::object::id<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CharacterDefinition>(arg1) == arg0.definition_id, 13906836566641016846);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>>(arg2) == arg0.policy_id, 13906836570936639512);
        assert!(0x1::type_name::with_original_ids<T0>() == arg0.coin_type, 13906836575231737882);
        assert!(arg0.minted < arg0.max_supply, 13906836579525525512);
    }

    fun assert_sale_terms(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0 && arg0 <= 1000000000000, 13906836725555068946);
        assert!(arg1 > 0 && arg1 >= arg2, 13906836729849905168);
    }

    public fun canonical_policy_coin_type<T0>(arg0: &ShopRegistry) : 0x1::option::Option<0x1::type_name::TypeName> {
        if (has_canonical_policy<T0>(arg0)) {
            let v1 = PolicyKey<T0>{dummy_field: false};
            0x1::option::some<0x1::type_name::TypeName>(0x2::dynamic_field::borrow<PolicyKey<T0>, CanonicalPolicy>(&arg0.id, v1).coin_type)
        } else {
            0x1::option::none<0x1::type_name::TypeName>()
        }
    }

    public fun canonical_policy_id<T0>(arg0: &ShopRegistry) : 0x1::option::Option<0x2::object::ID> {
        if (has_canonical_policy<T0>(arg0)) {
            let v1 = PolicyKey<T0>{dummy_field: false};
            0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<PolicyKey<T0>, CanonicalPolicy>(&arg0.id, v1).policy_id)
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun character_sale_address(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : address {
        let v0 = CharacterSaleKey{pos0: arg1};
        0x2::derived_object::derive_address<CharacterSaleKey>(arg0, v0)
    }

    public fun character_sale_coin_type(arg0: &CharacterSale) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun character_sale_max_supply(arg0: &CharacterSale) : u64 {
        arg0.max_supply
    }

    public fun character_sale_minted(arg0: &CharacterSale) : u64 {
        arg0.minted
    }

    public fun character_sale_paused(arg0: &CharacterSale) : bool {
        arg0.paused
    }

    public fun character_sale_policy_id(arg0: &CharacterSale) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun character_sale_price(arg0: &CharacterSale) : u64 {
        arg0.price_mist
    }

    public fun cosmetic_sale_address(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : address {
        let v0 = CosmeticSaleKey{pos0: arg1};
        0x2::derived_object::derive_address<CosmeticSaleKey>(arg0, v0)
    }

    public fun cosmetic_sale_coin_type(arg0: &CosmeticSale) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun cosmetic_sale_minted(arg0: &CosmeticSale) : u64 {
        arg0.minted
    }

    public fun cosmetic_sale_policy_id(arg0: &CosmeticSale) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun cosmetic_sale_price(arg0: &CosmeticSale) : u64 {
        arg0.price_mist
    }

    public fun create_character_sale<T0>(arg0: &mut ShopRegistry, arg1: &CommerceAdminCap, arg2: &0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CharacterDefinition, arg3: &0x2::transfer_policy::TransferPolicy<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>, arg4: 0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::MintCap, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_sale_terms(arg5, arg6, 0);
        let (v0, v1) = assert_canonical<T0, 0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>(arg0, 0x2::object::id<0x2::transfer_policy::TransferPolicy<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>>(arg3));
        let v2 = 0x2::object::id<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CharacterDefinition>(arg2);
        let v3 = CharacterSaleKey{pos0: v2};
        let v4 = CharacterSale{
            id            : 0x2::derived_object::claim<CharacterSaleKey>(&mut arg0.id, v3),
            version       : 1,
            definition_id : v2,
            policy_id     : v0,
            coin_type     : v1,
            price_mist    : arg5,
            minted        : 0,
            max_supply    : arg6,
            paused        : false,
            mint_cap      : arg4,
        };
        let v5 = 0x2::object::id<CharacterSale>(&v4);
        let v6 = SaleCreated{
            sale_id       : v5,
            definition_id : v2,
            is_character  : true,
            price_mist    : arg5,
            max_supply    : arg6,
            policy_id     : v0,
            coin_type     : v1,
        };
        0x2::event::emit<SaleCreated>(v6);
        0x2::transfer::share_object<CharacterSale>(v4);
        v5
    }

    public fun create_cosmetic_sale<T0>(arg0: &mut ShopRegistry, arg1: &CommerceAdminCap, arg2: &0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CosmeticDefinition, arg3: &0x2::transfer_policy::TransferPolicy<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Cosmetic>, arg4: 0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::MintCap, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_sale_terms(arg5, arg6, 0);
        let (v0, v1) = assert_canonical<T0, 0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Cosmetic>(arg0, 0x2::object::id<0x2::transfer_policy::TransferPolicy<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Cosmetic>>(arg3));
        let v2 = 0x2::object::id<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CosmeticDefinition>(arg2);
        let v3 = CosmeticSaleKey{pos0: v2};
        let v4 = CosmeticSale{
            id            : 0x2::derived_object::claim<CosmeticSaleKey>(&mut arg0.id, v3),
            version       : 1,
            definition_id : v2,
            policy_id     : v0,
            coin_type     : v1,
            price_mist    : arg5,
            minted        : 0,
            max_supply    : arg6,
            paused        : false,
            mint_cap      : arg4,
        };
        let v5 = 0x2::object::id<CosmeticSale>(&v4);
        let v6 = SaleCreated{
            sale_id       : v5,
            definition_id : v2,
            is_character  : false,
            price_mist    : arg5,
            max_supply    : arg6,
            policy_id     : v0,
            coin_type     : v1,
        };
        0x2::event::emit<SaleCreated>(v6);
        0x2::transfer::share_object<CosmeticSale>(v4);
        v5
    }

    public fun has_canonical_policy<T0>(arg0: &ShopRegistry) : bool {
        let v0 = PolicyKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists<PolicyKey<T0>>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CommerceAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CommerceAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ShopRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<ShopRegistry>(v1);
    }

    public fun max_price_mist() : u64 {
        1000000000000
    }

    public fun migrate_character_sale(arg0: &mut CharacterSale, arg1: &CommerceAdminCap) {
        assert!(arg0.version < 1, 13906835630337490948);
        arg0.version = 1;
    }

    public fun migrate_cosmetic_sale(arg0: &mut CosmeticSale, arg1: &CommerceAdminCap) {
        assert!(arg0.version < 1, 13906835651812327428);
        arg0.version = 1;
    }

    fun mint_character_into_kiosk<T0>(arg0: &mut CharacterSale, arg1: &0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CharacterDefinition, arg2: &0x2::transfer_policy::TransferPolicy<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>, arg3: &mut 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::AgentRegistry, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, u64) {
        arg0.minted = arg0.minted + 1;
        let v0 = arg0.minted;
        let v1 = 0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::mint_character(&arg0.mint_cap, arg1, v0, arg6, arg7);
        let v2 = 0x2::object::id<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>(&v1);
        0x2::kiosk::lock<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>(arg4, arg5, arg2, v1);
        (v2, 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::open_account<T0>(arg3, arg4, arg5, v2, arg6, arg7), v0)
    }

    public(friend) fun mint_reserved_character<T0>(arg0: &mut CharacterSale, arg1: &0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CharacterDefinition, arg2: &0x2::transfer_policy::TransferPolicy<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>, arg3: &mut 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::AgentRegistry, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, u64) {
        assert_character_mintable<T0>(arg0, arg1, arg2);
        assert!(0x2::kiosk::kiosk_owner_cap_for(arg5) == 0x2::object::id<0x2::kiosk::Kiosk>(arg4), 13906836381957816340);
        mint_character_into_kiosk<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun open_edition() : u64 {
        18446744073709551615
    }

    public fun purchase_character<T0>(arg0: &mut CharacterSale, arg1: &0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CharacterDefinition, arg2: &0x2::transfer_policy::TransferPolicy<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>, arg3: &mut 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::AgentRegistry, arg4: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::FeeVault<T0>, arg5: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_character_mintable<T0>(arg0, arg1, arg2);
        assert!(arg9 == arg0.price_mist, 13906835763481870346);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) == arg0.price_mist, 13906835767776968716);
        assert!(0x2::kiosk::kiosk_owner_cap_for(arg7) == 0x2::object::id<0x2::kiosk::Kiosk>(arg6), 13906835772072460308);
        let v0 = MintProceeds{dummy_field: false};
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::deposit<T0, MintProceeds>(arg4, arg5, v0, 0x2::coin::into_balance<0x2::sui::SUI>(arg8));
        let (v1, v2, v3) = mint_character_into_kiosk<T0>(arg0, arg1, arg2, arg3, arg6, arg7, arg10, arg11);
        let v4 = CharacterPurchased{
            sale_id        : 0x2::object::id<CharacterSale>(arg0),
            character_id   : v1,
            account_id     : v2,
            buyer          : 0x2::tx_context::sender(arg11),
            kiosk_id       : 0x2::object::id<0x2::kiosk::Kiosk>(arg6),
            edition_serial : v3,
            price_mist     : arg0.price_mist,
        };
        0x2::event::emit<CharacterPurchased>(v4);
        v1
    }

    public fun purchase_cosmetic<T0>(arg0: &mut CosmeticSale, arg1: &0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CosmeticDefinition, arg2: &0x2::transfer_policy::TransferPolicy<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Cosmetic>, arg3: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::FeeVault<T0>, arg4: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.version == 1, 13906835943870103556);
        assert!(!arg0.paused, 13906835948165201926);
        assert!(0x2::object::id<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::CosmeticDefinition>(arg1) == arg0.definition_id, 13906835952460693518);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Cosmetic>>(arg2) == arg0.policy_id, 13906835956756316184);
        assert!(0x1::type_name::with_original_ids<T0>() == arg0.coin_type, 13906835961051414554);
        assert!(arg0.minted < arg0.max_supply, 13906835965345202184);
        assert!(arg8 == arg0.price_mist, 13906835969640300554);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) == arg0.price_mist, 13906835973935398924);
        assert!(0x2::kiosk::kiosk_owner_cap_for(arg6) == 0x2::object::id<0x2::kiosk::Kiosk>(arg5), 13906835978230890516);
        let v0 = MintProceeds{dummy_field: false};
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::deposit<T0, MintProceeds>(arg3, arg4, v0, 0x2::coin::into_balance<0x2::sui::SUI>(arg7));
        arg0.minted = arg0.minted + 1;
        let v1 = 0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::mint_cosmetic(&arg0.mint_cap, arg1, arg9, arg10);
        let v2 = 0x2::object::id<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Cosmetic>(&v1);
        0x2::kiosk::lock<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Cosmetic>(arg5, arg6, arg2, v1);
        let v3 = CosmeticPurchased{
            sale_id     : 0x2::object::id<CosmeticSale>(arg0),
            cosmetic_id : v2,
            buyer       : 0x2::tx_context::sender(arg10),
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg5),
            price_mist  : arg0.price_mist,
        };
        0x2::event::emit<CosmeticPurchased>(v3);
        v2
    }

    public(friend) fun register_canonical_policy<T0>(arg0: &mut ShopRegistry, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName) {
        let v0 = PolicyKey<T0>{dummy_field: false};
        let v1 = CanonicalPolicy{
            policy_id : arg1,
            coin_type : arg2,
        };
        0x2::dynamic_field::add<PolicyKey<T0>, CanonicalPolicy>(&mut arg0.id, v0, v1);
    }

    public(friend) fun registry_uid(arg0: &ShopRegistry) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun registry_uid_mut(arg0: &mut ShopRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun set_character_sale(arg0: &mut CharacterSale, arg1: &CommerceAdminCap, arg2: u64, arg3: u64, arg4: bool) {
        assert!(arg0.version == 1, 13906835467128733700);
        let v0 = if (arg2 != arg0.price_mist) {
            true
        } else if (arg3 != arg0.max_supply) {
            true
        } else {
            arg4 != arg0.paused
        };
        assert!(v0, 13906835480014815254);
        assert_sale_terms(arg2, arg3, arg0.minted);
        arg0.price_mist = arg2;
        arg0.max_supply = arg3;
        arg0.paused = arg4;
        let v1 = SaleUpdated{
            sale_id    : 0x2::object::id<CharacterSale>(arg0),
            price_mist : arg2,
            max_supply : arg3,
            paused     : arg4,
        };
        0x2::event::emit<SaleUpdated>(v1);
    }

    public fun set_cosmetic_sale(arg0: &mut CosmeticSale, arg1: &CommerceAdminCap, arg2: u64, arg3: u64, arg4: bool) {
        assert!(arg0.version == 1, 13906835557323046916);
        let v0 = if (arg2 != arg0.price_mist) {
            true
        } else if (arg3 != arg0.max_supply) {
            true
        } else {
            arg4 != arg0.paused
        };
        assert!(v0, 13906835570209128470);
        assert_sale_terms(arg2, arg3, arg0.minted);
        arg0.price_mist = arg2;
        arg0.max_supply = arg3;
        arg0.paused = arg4;
        let v1 = SaleUpdated{
            sale_id    : 0x2::object::id<CosmeticSale>(arg0),
            price_mist : arg2,
            max_supply : arg3,
            paused     : arg4,
        };
        0x2::event::emit<SaleUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

