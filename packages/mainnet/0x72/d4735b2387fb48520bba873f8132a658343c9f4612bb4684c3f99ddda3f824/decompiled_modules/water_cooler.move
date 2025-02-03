module 0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::water_cooler {
    struct NFTCreated has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
    }

    struct WATER_COOLER has drop {
        dummy_field: bool,
    }

    struct WaterCooler has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        placeholder_image_url: 0x1::string::String,
        treasury: address,
        nfts: 0x2::table_vec::TableVec<0x2::object::ID>,
        revealed_nfts: vector<0x2::object::ID>,
        supply: u64,
        collection_id: 0x2::object::ID,
        settings_id: 0x2::object::ID,
        warehouse_id: 0x2::object::ID,
        is_initialized: bool,
        is_revealed: bool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        display: bool,
        init_counter: u64,
        minted_counter: u64,
    }

    struct WaterCoolerAdminCap has key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public fun supply(arg0: &WaterCooler) : u64 {
        arg0.supply
    }

    public(friend) fun add_balance(arg0: &mut WaterCooler, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun check_collection(arg0: &WaterCooler, arg1: &0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::collection::Collection) : bool {
        arg0.collection_id == 0x2::object::id<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::collection::Collection>(arg1)
    }

    public entry fun claim_balance(arg0: &WaterCoolerAdminCap, arg1: &mut WaterCooler, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), arg1.treasury);
    }

    public(friend) fun create_water_cooler(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::collection::new((arg4 as u16), arg8);
        let v1 = WaterCooler{
            id                    : 0x2::object::new(arg8),
            name                  : arg0,
            description           : arg1,
            image_url             : arg2,
            placeholder_image_url : arg3,
            treasury              : arg5,
            nfts                  : 0x2::table_vec::empty<0x2::object::ID>(arg8),
            revealed_nfts         : 0x1::vector::empty<0x2::object::ID>(),
            supply                : arg4,
            collection_id         : 0x2::object::id<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::collection::Collection>(&v0),
            settings_id           : arg6,
            warehouse_id          : arg7,
            is_initialized        : false,
            is_revealed           : false,
            balance               : 0x2::balance::zero<0x2::sui::SUI>(),
            owner                 : 0x2::tx_context::sender(arg8),
            display               : false,
            init_counter          : 0,
            minted_counter        : 0,
        };
        let v2 = WaterCoolerAdminCap{
            id  : 0x2::object::new(arg8),
            for : 0x2::object::id<WaterCooler>(&v1),
        };
        0x2::transfer::transfer<WaterCoolerAdminCap>(v2, 0x2::tx_context::sender(arg8));
        0x2::transfer::share_object<WaterCooler>(v1);
        0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::collection::transfer_collection(v0, arg8);
        0x2::object::id<WaterCooler>(&v1)
    }

    public(friend) fun get_is_initialized(arg0: &WaterCooler) : bool {
        arg0.is_initialized
    }

    public(friend) fun get_is_revealed(arg0: &WaterCooler) : bool {
        arg0.is_revealed
    }

    public fun get_nfts_num(arg0: &WaterCooler) : u64 {
        0x2::table_vec::length<0x2::object::ID>(&arg0.nfts)
    }

    public(friend) fun get_settings_id(arg0: &WaterCooler) : 0x2::object::ID {
        arg0.settings_id
    }

    public(friend) fun get_warehouse_id(arg0: &WaterCooler) : 0x2::object::ID {
        arg0.warehouse_id
    }

    public fun image_url(arg0: &WaterCooler) : 0x1::string::String {
        arg0.image_url
    }

    public(friend) fun inc_minted(arg0: &mut WaterCooler) {
        arg0.minted_counter = arg0.minted_counter + 1;
    }

    fun init(arg0: WATER_COOLER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WATER_COOLER>(arg0, arg1);
        let v1 = 0x2::display::new<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>(&v0, arg1);
        0x2::display::add<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{collection_name} #{number}"));
        0x2::display::add<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>>(v2);
    }

    public entry fun initialize_water_cooler(arg0: &WaterCoolerAdminCap, arg1: &mut WaterCooler, arg2: &0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::collection::Collection, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized == false, 0);
        let v0 = (0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::collection::supply(arg2) as u64);
        while (v0 != 0) {
            0x2::transfer::public_transfer<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>(0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::new(v0, arg1.name, arg1.description, 0x1::option::some<0x1::string::String>(arg1.placeholder_image_url), 0x1::option::none<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::attributes::Attributes>(), arg3), 0x2::tx_context::sender(arg3));
            v0 = v0 - 1;
        };
        if (0x2::table_vec::length<0x2::object::ID>(&arg1.nfts) == (0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::collection::supply(arg2) as u64)) {
            arg1.is_initialized = true;
        };
    }

    public entry fun initialize_with_data(arg0: &WaterCoolerAdminCap, arg1: &mut WaterCooler, arg2: &0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::collection::Collection, arg3: vector<u64>, arg4: vector<0x1::string::String>, arg5: vector<vector<0x1::string::String>>, arg6: vector<vector<0x1::string::String>>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized == false, 0);
        while (0x1::vector::length<0x1::string::String>(&arg4) > 0) {
            let v0 = 0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::new(0x1::vector::pop_back<u64>(&mut arg3), arg1.name, arg1.description, 0x1::option::some<0x1::string::String>(0x1::vector::pop_back<0x1::string::String>(&mut arg4)), 0x1::option::some<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::attributes::Attributes>(0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::attributes::admin_new(0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg5), 0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg6), arg7)), arg7);
            let v1 = NFTCreated{
                nft_id : 0x2::object::id<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>(&v0),
                minter : 0x2::tx_context::sender(arg7),
            };
            0x2::event::emit<NFTCreated>(v1);
            0x2::transfer::public_transfer<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>(v0, 0x2::tx_context::sender(arg7));
            arg1.init_counter = arg1.init_counter + 1;
        };
        if (arg1.init_counter == (0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::collection::supply(arg2) as u64)) {
            arg1.is_initialized = true;
        };
    }

    public fun is_initialized(arg0: &WaterCooler) : bool {
        arg0.is_initialized
    }

    public fun name(arg0: &WaterCooler) : 0x1::string::String {
        arg0.name
    }

    public fun owner(arg0: &WaterCooler) : address {
        arg0.owner
    }

    public fun placeholder_image(arg0: &WaterCooler) : 0x1::string::String {
        arg0.placeholder_image_url
    }

    public fun reveal_nft(arg0: &WaterCoolerAdminCap, arg1: &mut WaterCooler, arg2: &0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::collection::Collection, arg3: &mut 0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.collection_id == 0x2::object::id<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::collection::Collection>(arg2), 4);
        let v0 = 0x2::object::id<0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::Rinoco>(arg3);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.revealed_nfts, &v0), 2);
        0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::set_attributes(arg3, 0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::attributes::admin_new(arg4, arg5, arg7));
        0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::rinoco::set_image_url(arg3, arg6);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.revealed_nfts, v0);
        if (0x1::vector::length<0x2::object::ID>(&arg1.revealed_nfts) == (0x72d4735b2387fb48520bba873f8132a658343c9f4612bb4684c3f99ddda3f824::collection::supply(arg2) as u64)) {
            arg1.is_revealed = true;
        };
    }

    public(friend) fun send_fees(arg0: &WaterCooler, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
    }

    public fun set_treasury(arg0: &WaterCoolerAdminCap, arg1: &mut WaterCooler, arg2: address) {
        arg1.treasury = arg2;
    }

    public fun treasury(arg0: &WaterCooler) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v6
}

