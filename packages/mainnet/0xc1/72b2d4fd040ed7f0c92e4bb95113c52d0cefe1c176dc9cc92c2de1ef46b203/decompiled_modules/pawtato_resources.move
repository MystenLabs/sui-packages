module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources {
    struct PawtatoResources has key {
        id: 0x2::object::UID,
        treasury_caps: 0x2::bag::Bag,
        authorized_pools: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct ResourcesAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PAWTATO_RESOURCES has drop {
        dummy_field: bool,
    }

    public fun transfer_chaos_seed(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_chaos_seed::PAWTATO_CHAOS_SEED>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_chaos_seed::transfer_chaos_seed(arg0, arg1);
    }

    public fun transfer_coal(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_coal::PAWTATO_COAL>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_coal::transfer_coal(arg0, arg1);
    }

    public fun transfer_crystal(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_crystal::PAWTATO_CRYSTAL>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_crystal::transfer_crystal(arg0, arg1);
    }

    public fun transfer_gold(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold::PAWTATO_GOLD>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold::transfer_gold(arg0, arg1);
    }

    public fun transfer_gold_bar(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold_bar::PAWTATO_GOLD_BAR>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold_bar::transfer_gold_bar(arg0, arg1);
    }

    public fun transfer_iron(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron::PAWTATO_IRON>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron::transfer_iron(arg0, arg1);
    }

    public fun transfer_iron_bar(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron_bar::PAWTATO_IRON_BAR>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron_bar::transfer_iron_bar(arg0, arg1);
    }

    public fun transfer_phoenix_feather(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_phoenix_feather::PAWTATO_PHOENIX_FEATHER>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_phoenix_feather::transfer_phoenix_feather(arg0, arg1);
    }

    public fun add_treasury_cap<T0>(arg0: &ResourcesAdminCap, arg1: &mut PawtatoResources, arg2: 0x2::coin::TreasuryCap<T0>) {
        0x2::bag::add<0x1::string::String, 0x2::coin::TreasuryCap<T0>>(&mut arg1.treasury_caps, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string<T0>(), arg2);
    }

    public fun authorize_pool(arg0: &ResourcesAdminCap, arg1: &mut PawtatoResources, arg2: 0x2::object::ID) {
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.authorized_pools, arg2, true);
    }

    public fun has_treasury_cap<T0>(arg0: &PawtatoResources) : bool {
        0x2::bag::contains<0x1::string::String>(&arg0.treasury_caps, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string<T0>())
    }

    fun init(arg0: PAWTATO_RESOURCES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ResourcesAdminCap{id: 0x2::object::new(arg1)};
        let v1 = PawtatoResources{
            id               : 0x2::object::new(arg1),
            treasury_caps    : 0x2::bag::new(arg1),
            authorized_pools : 0x2::table::new<0x2::object::ID, bool>(arg1),
        };
        0x2::transfer::share_object<PawtatoResources>(v1);
        0x2::transfer::transfer<ResourcesAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun initialize_after_upgrade(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ResourcesAdminCap{id: 0x2::object::new(arg1)};
        let v1 = PawtatoResources{
            id               : 0x2::object::new(arg1),
            treasury_caps    : 0x2::bag::new(arg1),
            authorized_pools : 0x2::table::new<0x2::object::ID, bool>(arg1),
        };
        0x2::transfer::share_object<PawtatoResources>(v1);
        0x2::transfer::transfer<ResourcesAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_pool_authorized(arg0: &PawtatoResources, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.authorized_pools, arg1)
    }

    public(friend) fun mint_chaos_seed(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_chaos_seed::PAWTATO_CHAOS_SEED> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_chaos_seed::PAWTATO_CHAOS_SEED>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_coal(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_coal::PAWTATO_COAL> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_coal::PAWTATO_COAL>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_coin<T0>(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.authorized_pools, arg1), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unauthorized_pool_to_mint());
        let v0 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers::get_coin_type_string<T0>();
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.treasury_caps, v0), 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_treasury_cap_not_found());
        0x2::coin::mint<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_caps, v0), arg2, arg3)
    }

    public(friend) fun mint_crystal(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_crystal::PAWTATO_CRYSTAL> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_crystal::PAWTATO_CRYSTAL>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_gold(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold::PAWTATO_GOLD> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold::PAWTATO_GOLD>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_gold_bar(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold_bar::PAWTATO_GOLD_BAR> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold_bar::PAWTATO_GOLD_BAR>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_iron(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron::PAWTATO_IRON> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron::PAWTATO_IRON>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_iron_bar(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron_bar::PAWTATO_IRON_BAR> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron_bar::PAWTATO_IRON_BAR>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_phoenix_feather(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_phoenix_feather::PAWTATO_PHOENIX_FEATHER> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_phoenix_feather::PAWTATO_PHOENIX_FEATHER>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_stone(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_stone::PAWTATO_STONE> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_stone::PAWTATO_STONE>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_titanium_splinter(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_titanium_splinter::PAWTATO_TITANIUM_SPLINTER> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_titanium_splinter::PAWTATO_TITANIUM_SPLINTER>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_water(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_water::PAWTATO_WATER> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_water::PAWTATO_WATER>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_wood(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_wood::PAWTATO_WOOD> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_wood::PAWTATO_WOOD>(arg0, arg1, arg2, arg3)
    }

    public fun revoke_pool_authorization(arg0: &ResourcesAdminCap, arg1: &mut PawtatoResources, arg2: 0x2::object::ID) {
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.authorized_pools, arg2)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.authorized_pools, arg2);
        };
    }

    public fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public fun transfer_stone(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_stone::PAWTATO_STONE>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_stone::transfer_stone(arg0, arg1);
    }

    public fun transfer_titanium_splinter(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_titanium_splinter::PAWTATO_TITANIUM_SPLINTER>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_titanium_splinter::transfer_titanium_splinter(arg0, arg1);
    }

    public fun transfer_water(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_water::PAWTATO_WATER>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_water::transfer_water(arg0, arg1);
    }

    public fun transfer_wood(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_wood::PAWTATO_WOOD>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_wood::transfer_wood(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

