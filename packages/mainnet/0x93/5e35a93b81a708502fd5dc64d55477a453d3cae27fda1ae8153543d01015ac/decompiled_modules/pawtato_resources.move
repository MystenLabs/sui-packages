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

    public(friend) fun mint_chaos_seed_new(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED> {
        mint_coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_coal(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_coal::PAWTATO_COAL> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_coal::PAWTATO_COAL>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_coal_new(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL> {
        mint_coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>(arg0, arg1, arg2, arg3)
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

    public(friend) fun mint_crystal_new(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL> {
        mint_coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_gold(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold::PAWTATO_GOLD> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold::PAWTATO_GOLD>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_gold_bar(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold_bar::PAWTATO_GOLD_BAR> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_gold_bar::PAWTATO_GOLD_BAR>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_gold_bar_new(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR> {
        mint_coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_gold_new(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD> {
        mint_coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_iron(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron::PAWTATO_IRON> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron::PAWTATO_IRON>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_iron_bar(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron_bar::PAWTATO_IRON_BAR> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron_bar::PAWTATO_IRON_BAR>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_iron_bar_new(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR> {
        mint_coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_iron_new(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON> {
        mint_coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_phoenix_feather(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_phoenix_feather::PAWTATO_PHOENIX_FEATHER> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_phoenix_feather::PAWTATO_PHOENIX_FEATHER>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_phoenix_feather_new(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER> {
        mint_coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_stone(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_stone::PAWTATO_STONE> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_stone::PAWTATO_STONE>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_stone_new(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE> {
        mint_coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_titanium_splinter(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_titanium_splinter::PAWTATO_TITANIUM_SPLINTER> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_titanium_splinter::PAWTATO_TITANIUM_SPLINTER>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_titanium_splinter_new(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER> {
        mint_coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_water(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_water::PAWTATO_WATER> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_water::PAWTATO_WATER>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_water_new(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER> {
        mint_coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_wood(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_wood::PAWTATO_WOOD> {
        mint_coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_wood::PAWTATO_WOOD>(arg0, arg1, arg2, arg3)
    }

    public(friend) fun mint_wood_new(arg0: &mut PawtatoResources, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD> {
        mint_coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>(arg0, arg1, arg2, arg3)
    }

    public fun revoke_pool_authorization(arg0: &ResourcesAdminCap, arg1: &mut PawtatoResources, arg2: 0x2::object::ID) {
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.authorized_pools, arg2)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.authorized_pools, arg2);
        };
    }

    public fun transfer_chaos_seed_new(arg0: 0x2::coin::Coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed::PAWTATO_COIN_CHAOS_SEED>>(arg0, arg1);
    }

    public fun transfer_coal_new(arg0: 0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xab66d1392a81c2408b063217d7a4b3d349c25f8d8b74febfa03d0c107ef8ee9a::pawtato_coin_coal::PAWTATO_COIN_COAL>>(arg0, arg1);
    }

    public fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public fun transfer_crystal_new(arg0: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>>(arg0, arg1);
    }

    public fun transfer_gold_bar_new(arg0: 0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar::PAWTATO_COIN_GOLD_BAR>>(arg0, arg1);
    }

    public fun transfer_gold_new(arg0: 0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf9d3566bb782d792a93a16a9db69211808048dee1914b64cb7f96a3582258671::pawtato_coin_gold::PAWTATO_COIN_GOLD>>(arg0, arg1);
    }

    public fun transfer_iron_bar_new(arg0: 0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar::PAWTATO_COIN_IRON_BAR>>(arg0, arg1);
    }

    public fun transfer_iron_new(arg0: 0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x422d4e84d7eaee54e75c140e2f7ae9503311f516342ef2c6020c8f8be8629024::pawtato_coin_iron::PAWTATO_COIN_IRON>>(arg0, arg1);
    }

    public fun transfer_phoenix_feather_new(arg0: 0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather::PAWTATO_COIN_PHOENIX_FEATHER>>(arg0, arg1);
    }

    public fun transfer_stone(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_stone::PAWTATO_STONE>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_stone::transfer_stone(arg0, arg1);
    }

    public fun transfer_stone_new(arg0: 0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone::PAWTATO_COIN_STONE>>(arg0, arg1);
    }

    public fun transfer_titanium_splinter(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_titanium_splinter::PAWTATO_TITANIUM_SPLINTER>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_titanium_splinter::transfer_titanium_splinter(arg0, arg1);
    }

    public fun transfer_titanium_splinter_new(arg0: 0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter::PAWTATO_COIN_TITANIUM_SPLINTER>>(arg0, arg1);
    }

    public fun transfer_water(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_water::PAWTATO_WATER>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_water::transfer_water(arg0, arg1);
    }

    public fun transfer_water_new(arg0: 0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdbc712df0c412a0fcd6d4aec441e9748d05a0db16ff1fbdb04aa233a9eda454d::pawtato_coin_water::PAWTATO_COIN_WATER>>(arg0, arg1);
    }

    public fun transfer_wood(arg0: 0x2::coin::Coin<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_wood::PAWTATO_WOOD>, arg1: address) {
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_wood::transfer_wood(arg0, arg1);
    }

    public fun transfer_wood_new(arg0: 0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood::PAWTATO_COIN_WOOD>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

