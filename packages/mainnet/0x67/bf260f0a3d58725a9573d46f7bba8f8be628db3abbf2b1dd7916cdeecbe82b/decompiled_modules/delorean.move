module 0xa1d5e3f98eb588b245a87c02363652436450aedb62ef1a7b018f16e6423059::delorean {
    struct DELOREAN has drop {
        dummy_field: bool,
    }

    struct DeloreanRegistry has store, key {
        id: 0x2::object::UID,
        supply: u16,
        total_supply: u16,
        map: 0x2::table::Table<u16, ItemDetails>,
        shuffle_vector: vector<u16>,
        prizes: vector<Prize>,
        is_shuffled: bool,
        addresses_that_already_minted: 0x2::table::Table<address, bool>,
        version: u64,
        admin_addresses: 0x2::vec_set::VecSet<address>,
    }

    struct DeloreanNFT has store, key {
        id: 0x2::object::UID,
        number_id: u16,
    }

    struct ItemDetails has drop, store {
        id: 0x2::object::ID,
        claimed: bool,
        prize: 0x1::option::Option<Prize>,
        minted_to: address,
    }

    struct Prize has copy, drop, store {
        prize_type: 0x1::string::String,
        number: u16,
    }

    struct Promise {
        receiver: address,
    }

    struct RedistributeRegistry has store, key {
        id: 0x2::object::UID,
        eligible_vector: vector<u16>,
        shuffle_vector: vector<u16>,
        prizes: vector<Prize>,
        is_shuffled: bool,
    }

    public fun add_admin(arg0: &0x2::package::Publisher, arg1: &mut DeloreanRegistry, arg2: address) {
        assert!(0x2::package::from_package<DELOREAN>(arg0), 9);
        assert!(0x2::vec_set::size<address>(&arg1.admin_addresses) < 10, 12);
        0x2::vec_set::insert<address>(&mut arg1.admin_addresses, arg2);
    }

    public fun config_is_shuffled(arg0: &DeloreanRegistry) : bool {
        arg0.is_shuffled
    }

    public fun config_is_shuffled_v2(arg0: &RedistributeRegistry) : bool {
        arg0.is_shuffled
    }

    public fun config_map(arg0: &DeloreanRegistry) : &0x2::table::Table<u16, ItemDetails> {
        &arg0.map
    }

    public fun config_prizes(arg0: &DeloreanRegistry) : vector<Prize> {
        arg0.prizes
    }

    public fun config_prizes_v2(arg0: &RedistributeRegistry) : vector<Prize> {
        arg0.prizes
    }

    public fun config_shuffle_vector(arg0: &DeloreanRegistry) : &vector<u16> {
        &arg0.shuffle_vector
    }

    public fun config_shuffle_vector_v2(arg0: &RedistributeRegistry) : &vector<u16> {
        &arg0.shuffle_vector
    }

    public fun config_supply(arg0: &DeloreanRegistry) : u16 {
        arg0.supply
    }

    public fun config_total_supply(arg0: &DeloreanRegistry) : u16 {
        arg0.total_supply
    }

    public fun config_version(arg0: &DeloreanRegistry) : u64 {
        arg0.version
    }

    entry fun create_redistribute_registry(arg0: &DeloreanRegistry, arg1: vector<u16>, arg2: u16, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_addresses, &v0), 10);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        0x2::random::shuffle<u16>(&mut v1, &mut arg1);
        let v2 = 0x1::vector::empty<u16>();
        let v3 = 0;
        while (v3 < arg2) {
            0x1::vector::push_back<u16>(&mut v2, 0x1::vector::pop_back<u16>(&mut arg1));
            v3 = v3 + 1;
        };
        let v4 = RedistributeRegistry{
            id              : 0x2::object::new(arg4),
            eligible_vector : v2,
            shuffle_vector  : 0x1::vector::empty<u16>(),
            prizes          : 0x1::vector::empty<Prize>(),
            is_shuffled     : false,
        };
        0x2::transfer::share_object<RedistributeRegistry>(v4);
    }

    public fun distribute_next_prize(arg0: &mut DeloreanRegistry, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_addresses, &v0), 10);
        assert!(arg0.version == 1, 8);
        assert!(!0x1::vector::is_empty<Prize>(&arg0.prizes), 5);
        assert!(arg0.is_shuffled, 4);
        let v1 = 0x1::vector::remove<Prize>(&mut arg0.prizes, 0);
        let v2 = 0;
        while (v2 < v1.number) {
            0x1::option::fill<Prize>(&mut 0x2::table::borrow_mut<u16, ItemDetails>(&mut arg0.map, 0x1::vector::pop_back<u16>(&mut arg0.shuffle_vector)).prize, v1);
            v2 = v2 + 1;
        };
    }

    public fun get_nft_id(arg0: u16, arg1: &DeloreanRegistry) : &0x2::object::ID {
        &0x2::table::borrow<u16, ItemDetails>(&arg1.map, arg0).id
    }

    public fun get_prize(arg0: u16, arg1: &DeloreanRegistry) : &Prize {
        0x1::option::borrow<Prize>(&0x2::table::borrow<u16, ItemDetails>(&arg1.map, arg0).prize)
    }

    fun init(arg0: DELOREAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DELOREAN>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"number_id"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{number_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b""));
        let v5 = 0x2::display::new_with_fields<DeloreanNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<DeloreanNFT>(&mut v5);
        let v6 = DeloreanRegistry{
            id                            : 0x2::object::new(arg1),
            supply                        : 0,
            total_supply                  : 0,
            map                           : 0x2::table::new<u16, ItemDetails>(arg1),
            shuffle_vector                : 0x1::vector::empty<u16>(),
            prizes                        : 0x1::vector::empty<Prize>(),
            is_shuffled                   : false,
            addresses_that_already_minted : 0x2::table::new<address, bool>(arg1),
            version                       : 1,
            admin_addresses               : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg1)),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DeloreanNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<DeloreanRegistry>(v6);
    }

    public fun make_kiosk_personal_and_send(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: Promise, arg3: &mut 0x2::tx_context::TxContext) {
        let Promise { receiver: v0 } = arg2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(arg0, arg1, v0, arg3);
    }

    public fun mint_nft_to_kiosk(arg0: &mut DeloreanRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::transfer_policy::TransferPolicy<DeloreanNFT>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_addresses, &v0), 10);
        assert!(arg0.version == 1, 8);
        let v1 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.addresses_that_already_minted, v1), 7);
        arg0.supply = arg0.supply + 1;
        assert!(arg0.supply <= arg0.total_supply, 0);
        let v2 = DeloreanNFT{
            id        : 0x2::object::new(arg3),
            number_id : arg0.supply,
        };
        let v3 = v2.number_id;
        0x1::vector::push_back<u16>(&mut arg0.shuffle_vector, v3);
        let v4 = ItemDetails{
            id        : 0x2::object::id<DeloreanNFT>(&v2),
            claimed   : false,
            prize     : 0x1::option::none<Prize>(),
            minted_to : v1,
        };
        0x2::table::add<u16, ItemDetails>(&mut arg0.map, v3, v4);
        0x2::table::add<address, bool>(&mut arg0.addresses_that_already_minted, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg1), true);
        0xa1d5e3f98eb588b245a87c02363652436450aedb62ef1a7b018f16e6423059::extension::lock<DeloreanNFT>(arg1, v2, arg2);
    }

    public fun mint_nft_to_non_personal_kiosk(arg0: &mut DeloreanRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<DeloreanNFT>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : Promise {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_addresses, &v0), 10);
        assert!(arg0.version == 1, 8);
        assert!(!0x2::table::contains<address, bool>(&arg0.addresses_that_already_minted, arg4), 7);
        arg0.supply = arg0.supply + 1;
        assert!(arg0.supply <= arg0.total_supply, 0);
        let v1 = DeloreanNFT{
            id        : 0x2::object::new(arg5),
            number_id : arg0.supply,
        };
        let v2 = v1.number_id;
        0x1::vector::push_back<u16>(&mut arg0.shuffle_vector, v2);
        let v3 = ItemDetails{
            id        : 0x2::object::id<DeloreanNFT>(&v1),
            claimed   : false,
            prize     : 0x1::option::none<Prize>(),
            minted_to : arg4,
        };
        0x2::table::add<u16, ItemDetails>(&mut arg0.map, v2, v3);
        0x2::table::add<address, bool>(&mut arg0.addresses_that_already_minted, arg4, true);
        0xa1d5e3f98eb588b245a87c02363652436450aedb62ef1a7b018f16e6423059::extension::add_(arg1, arg2, arg5);
        0xa1d5e3f98eb588b245a87c02363652436450aedb62ef1a7b018f16e6423059::extension::lock<DeloreanNFT>(arg1, v1, arg3);
        Promise{receiver: arg4}
    }

    public fun mint_nft_to_non_personal_kiosk_v2(arg0: &mut DeloreanRegistry, arg1: &mut RedistributeRegistry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<DeloreanNFT>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : Promise {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_addresses, &v0), 10);
        arg0.supply = arg0.supply + 1;
        assert!(arg0.supply <= arg0.total_supply, 0);
        let v1 = DeloreanNFT{
            id        : 0x2::object::new(arg6),
            number_id : arg0.supply,
        };
        let v2 = v1.number_id;
        0x1::vector::push_back<u16>(&mut arg1.shuffle_vector, v2);
        let v3 = ItemDetails{
            id        : 0x2::object::id<DeloreanNFT>(&v1),
            claimed   : false,
            prize     : 0x1::option::none<Prize>(),
            minted_to : arg5,
        };
        0x2::table::add<u16, ItemDetails>(&mut arg0.map, v2, v3);
        0xa1d5e3f98eb588b245a87c02363652436450aedb62ef1a7b018f16e6423059::extension::add_(arg2, arg3, arg6);
        0xa1d5e3f98eb588b245a87c02363652436450aedb62ef1a7b018f16e6423059::extension::lock<DeloreanNFT>(arg2, v1, arg4);
        Promise{receiver: arg5}
    }

    public fun prizes_sum(arg0: &DeloreanRegistry) : u16 {
        let v0 = &arg0.prizes;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Prize>(v0)) {
            0x1::vector::push_back<u16>(&mut v1, 0x1::vector::borrow<Prize>(v0, v2).number);
            v2 = v2 + 1;
        };
        let v3 = 0;
        0x1::vector::reverse<u16>(&mut v1);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u16>(&v1)) {
            v3 = v3 + 0x1::vector::pop_back<u16>(&mut v1);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u16>(v1);
        v3
    }

    public fun prizes_sum_v2(arg0: &RedistributeRegistry) : u16 {
        let v0 = &arg0.prizes;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Prize>(v0)) {
            0x1::vector::push_back<u16>(&mut v1, 0x1::vector::borrow<Prize>(v0, v2).number);
            v2 = v2 + 1;
        };
        let v3 = 0;
        0x1::vector::reverse<u16>(&mut v1);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u16>(&v1)) {
            v3 = v3 + 0x1::vector::pop_back<u16>(&mut v1);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u16>(v1);
        v3
    }

    public fun redistribute_next_prize(arg0: &mut DeloreanRegistry, arg1: &mut RedistributeRegistry, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_addresses, &v0), 10);
        assert!(!0x1::vector::is_empty<Prize>(&arg1.prizes), 5);
        assert!(arg1.is_shuffled, 4);
        let v1 = 0x1::vector::remove<Prize>(&mut arg1.prizes, 0);
        let v2 = 0;
        while (v2 < v1.number) {
            0x1::option::fill<Prize>(&mut 0x2::table::borrow_mut<u16, ItemDetails>(&mut arg0.map, 0x1::vector::pop_back<u16>(&mut arg1.shuffle_vector)).prize, v1);
            v2 = v2 + 1;
        };
    }

    public fun register_prize(arg0: 0x1::string::String, arg1: u16, arg2: &mut DeloreanRegistry, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg2.admin_addresses, &v0), 10);
        assert!(arg2.version == 1, 8);
        assert!(!arg2.is_shuffled, 3);
        assert!(prizes_sum(arg2) + arg1 <= arg2.total_supply, 6);
        let v1 = Prize{
            prize_type : arg0,
            number     : arg1,
        };
        0x1::vector::push_back<Prize>(&mut arg2.prizes, v1);
    }

    public fun register_prize_v2(arg0: 0x1::string::String, arg1: u16, arg2: &DeloreanRegistry, arg3: &mut RedistributeRegistry, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg2.admin_addresses, &v0), 10);
        assert!(!arg3.is_shuffled, 3);
        assert!(prizes_sum(arg2) + prizes_sum_v2(arg3) + arg1 <= arg2.total_supply, 6);
        let v1 = Prize{
            prize_type : arg0,
            number     : arg1,
        };
        0x1::vector::push_back<Prize>(&mut arg3.prizes, v1);
    }

    public fun remove_admin(arg0: &0x2::package::Publisher, arg1: &mut DeloreanRegistry, arg2: address) {
        assert!(0x2::package::from_package<DELOREAN>(arg0), 9);
        0x2::vec_set::remove<address>(&mut arg1.admin_addresses, &arg2);
        assert!(0x2::vec_set::size<address>(&arg1.admin_addresses) > 0, 11);
    }

    public fun reset_prizes(arg0: &mut DeloreanRegistry, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_addresses, &v0), 10);
        assert!(arg0.version == 1, 8);
        assert!(!arg0.is_shuffled, 3);
        arg0.prizes = 0x1::vector::empty<Prize>();
    }

    entry fun shuffle_vector(arg0: &0x2::random::Random, arg1: &mut DeloreanRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg1.admin_addresses, &v0), 10);
        assert!(arg1.version == 1, 8);
        assert!(!0x1::vector::is_empty<u16>(&arg1.shuffle_vector), 2);
        assert!(!arg1.is_shuffled, 3);
        assert!(arg1.total_supply == arg1.supply, 1);
        arg1.is_shuffled = true;
        let v1 = 0x2::random::new_generator(arg0, arg2);
        0x2::random::shuffle<u16>(&mut v1, &mut arg1.shuffle_vector);
    }

    entry fun shuffle_vector_v2(arg0: &0x2::random::Random, arg1: &DeloreanRegistry, arg2: &mut RedistributeRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg1.admin_addresses, &v0), 10);
        assert!(!0x1::vector::is_empty<u16>(&arg2.shuffle_vector), 2);
        assert!(!arg2.is_shuffled, 3);
        assert!(arg1.total_supply == arg1.supply, 1);
        arg2.is_shuffled = true;
        let v1 = 0x2::random::new_generator(arg0, arg3);
        0x2::random::shuffle<u16>(&mut v1, &mut arg2.shuffle_vector);
    }

    public fun update_total_supply(arg0: &mut DeloreanRegistry, arg1: u16, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admin_addresses, &v0), 10);
        assert!(arg0.version == 1, 8);
        assert!(arg1 >= arg0.supply, 1);
        arg0.total_supply = arg1;
    }

    // decompiled from Move bytecode v6
}

