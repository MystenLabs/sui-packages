module 0x23ab80d352345b7b1e16622b01516713292a272de9eb765a774a4726a1d16431::suicity_house {
    struct SuiCityCap has key {
        id: 0x2::object::UID,
    }

    struct House has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        x: u64,
        y: u64,
        zone: 0x1::string::String,
        config: vector<u64>,
    }

    struct Profile has store, key {
        id: 0x2::object::UID,
        nick_name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct Interior has store, key {
        id: 0x2::object::UID,
    }

    struct SuiCityData has key {
        id: 0x2::object::UID,
        current_supply: u64,
        public_claimed: u64,
        pass_mint_allowed: bool,
        paid_mint_allowed: bool,
        price: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        houseRegistry: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct HouseLookupResult has drop {
        token_id: u64,
        house_id: 0x2::object::ID,
    }

    struct FurnitureAdded<phantom T0> has copy, drop {
        interior_id: 0x2::object::ID,
        furniture_id: 0x2::object::ID,
    }

    struct FurnitureRemoved<phantom T0> has copy, drop {
        interior_id: 0x2::object::ID,
        furniture_id: 0x2::object::ID,
    }

    struct HouseClaimed has copy, drop {
        id: 0x2::object::ID,
        citizen: address,
    }

    struct ProfileEdited has copy, drop {
        profile_id: 0x2::object::ID,
    }

    struct AddedToPrifile has copy, drop {
        profile_id: 0x2::object::ID,
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct RemovedFromProfile has copy, drop {
        profile_id: 0x2::object::ID,
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct SUICITY_HOUSE has drop {
        dummy_field: bool,
    }

    public entry fun add_furniture<T0: store + key>(arg0: &mut House, arg1: T0) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Interior>(&mut arg0.id, 1);
        let v1 = FurnitureAdded<T0>{
            interior_id  : 0x2::object::id<Interior>(v0),
            furniture_id : 0x2::object::id<T0>(&arg1),
        };
        0x2::event::emit<FurnitureAdded<T0>>(v1);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut v0.id, 0x2::object::id<T0>(&arg1), arg1);
    }

    public entry fun add_to_profile(arg0: &mut House, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Profile>(&mut arg0.id, 0);
        let v1 = 0x1::string::utf8(arg1);
        let v2 = 0x1::string::utf8(arg2);
        let v3 = AddedToPrifile{
            profile_id : 0x2::object::uid_to_inner(&v0.id),
            key        : v1,
            value      : v2,
        };
        0x2::event::emit<AddedToPrifile>(v3);
        0x2::dynamic_field::add<0x1::string::String, 0x1::string::String>(&mut v0.id, v1, v2);
    }

    public entry fun change_house_price(arg0: &SuiCityCap, arg1: &mut SuiCityData, arg2: u64) {
        arg1.price = arg2;
    }

    public entry fun edit_config(arg0: &mut House, arg1: vector<u64>) {
        arg0.config = arg1;
    }

    public entry fun edit_display<T0: key>(arg0: &mut 0x2::display::Display<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::display::edit<T0>(arg0, arg1, arg2);
    }

    public entry fun edit_profile(arg0: &mut House, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Profile>(&mut arg0.id, 0);
        v0.nick_name = 0x1::string::utf8(arg1);
        v0.image_url = 0x1::string::utf8(arg2);
        let v1 = ProfileEdited{profile_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<ProfileEdited>(v1);
    }

    public entry fun get_all_houses(arg0: &SuiCityData) : vector<HouseLookupResult> {
        let v0 = 0x1::vector::empty<HouseLookupResult>();
        let v1 = 1;
        while (v1 <= arg0.current_supply) {
            let v2 = HouseLookupResult{
                token_id : v1,
                house_id : *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.houseRegistry, v1),
            };
            0x1::vector::push_back<HouseLookupResult>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun get_houses_by_token_ids(arg0: &SuiCityData, arg1: vector<u64>) : vector<HouseLookupResult> {
        let v0 = 0x1::vector::empty<HouseLookupResult>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            if (0x2::table::contains<u64, 0x2::object::ID>(&arg0.houseRegistry, v2)) {
                let v3 = HouseLookupResult{
                    token_id : v2,
                    house_id : *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.houseRegistry, v2),
                };
                0x1::vector::push_back<HouseLookupResult>(&mut v0, v3);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: SUICITY_HOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"coordinate_x"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"coordinate_y"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"token_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"houseConfig"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"No. #{token_id} @({x}, {y}) {zone}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.suicitynft.fun/houses/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.suicitynft.fun/api/images/v2/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{x}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{y}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{config}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A fully on-chain city that lives on SuiNetwork. SuiCityNFT is a fun open-source NFT project that is constantly evolving by its citizens. So there is something new to explore every day in SuiCity!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicitynft.fun"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiCityNFT"));
        let v4 = 0x2::package::claim<SUICITY_HOUSE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<House>(&v4, v0, v2, arg1);
        0x2::display::update_version<House>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<House>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = SuiCityCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SuiCityCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = SuiCityData{
            id                : 0x2::object::new(arg1),
            current_supply    : 0,
            public_claimed    : 0,
            pass_mint_allowed : true,
            paid_mint_allowed : true,
            price             : 18000000000,
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            houseRegistry     : 0x2::table::new<u64, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<SuiCityData>(v7);
    }

    fun mint(arg0: &mut SuiCityData, arg1: vector<u64>, arg2: &0x23ab80d352345b7b1e16622b01516713292a272de9eb765a774a4726a1d16431::suicity_map::SuiCity, arg3: &mut 0x2::tx_context::TxContext) : House {
        assert!(arg0.current_supply < 2468, 100);
        let v0 = Profile{
            id        : 0x2::object::new(arg3),
            nick_name : 0x1::string::utf8(b"_"),
            image_url : 0x1::string::utf8(b"https://app.suicitynft.fun/api/images/v2/placeholder"),
        };
        let v1 = Interior{id: 0x2::object::new(arg3)};
        let v2 = arg0.current_supply + 1;
        let v3 = 0x23ab80d352345b7b1e16622b01516713292a272de9eb765a774a4726a1d16431::suicity_map::get_coordinate(arg2, v2);
        let v4 = House{
            id       : 0x2::object::new(arg3),
            token_id : v2,
            x        : 0x23ab80d352345b7b1e16622b01516713292a272de9eb765a774a4726a1d16431::suicity_map::get_x(v3),
            y        : 0x23ab80d352345b7b1e16622b01516713292a272de9eb765a774a4726a1d16431::suicity_map::get_y(v3),
            zone     : 0x23ab80d352345b7b1e16622b01516713292a272de9eb765a774a4726a1d16431::suicity_map::get_zone(v3),
            config   : arg1,
        };
        0x2::dynamic_object_field::add<u64, Profile>(&mut v4.id, 0, v0);
        0x2::dynamic_object_field::add<u64, Interior>(&mut v4.id, 1, v1);
        arg0.current_supply = arg0.current_supply + 1;
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.houseRegistry, v4.token_id, 0x2::object::id<House>(&v4));
        v4
    }

    public entry fun passport_owner_claim(arg0: &mut SuiCityData, arg1: u64, arg2: vector<vector<u64>>, arg3: &0x23ab80d352345b7b1e16622b01516713292a272de9eb765a774a4726a1d16431::suicity_map::SuiCity, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pass_mint_allowed == true, 200);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg4, &arg5, &arg6, 0) == true, 400);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = mint(arg0, *0x1::vector::borrow<vector<u64>>(&arg2, v1), arg3, arg7);
            let v3 = HouseClaimed{
                id      : 0x2::object::id<House>(&v2),
                citizen : 0x2::tx_context::sender(arg7),
            };
            0x2::event::emit<HouseClaimed>(v3);
            v1 = v1 + 1;
            0x2::transfer::transfer<House>(v2, v0);
        };
    }

    public entry fun public_claim(arg0: &mut SuiCityData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: vector<vector<u64>>, arg4: &0x23ab80d352345b7b1e16622b01516713292a272de9eb765a774a4726a1d16431::suicity_map::SuiCity, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paid_mint_allowed == true, 201);
        assert!(arg0.public_claimed + arg2 <= 2468 - 1294, 101);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2 * arg0.price, 500);
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = mint(arg0, *0x1::vector::borrow<vector<u64>>(&arg3, v1), arg4, arg5);
            let v3 = HouseClaimed{
                id      : 0x2::object::id<House>(&v2),
                citizen : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<HouseClaimed>(v3);
            arg0.public_claimed = arg0.public_claimed + 1;
            v1 = v1 + 1;
            0x2::transfer::transfer<House>(v2, v0);
        };
    }

    public entry fun remove_from_profile(arg0: &mut House, arg1: vector<u8>) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Profile>(&mut arg0.id, 0);
        let v1 = 0x1::string::utf8(arg1);
        let v2 = RemovedFromProfile{
            profile_id : 0x2::object::uid_to_inner(&v0.id),
            key        : v1,
            value      : 0x2::dynamic_field::remove<0x1::string::String, 0x1::string::String>(&mut v0.id, v1),
        };
        0x2::event::emit<RemovedFromProfile>(v2);
    }

    public entry fun remove_furniture<T0: store + key>(arg0: &mut House, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Interior>(&mut arg0.id, 1);
        let v1 = FurnitureRemoved<T0>{
            interior_id  : 0x2::object::id<Interior>(v0),
            furniture_id : arg1,
        };
        0x2::event::emit<FurnitureRemoved<T0>>(v1);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut v0.id, arg1), 0x2::tx_context::sender(arg2));
    }

    public entry fun start_paid_mint(arg0: &SuiCityCap, arg1: &mut SuiCityData) {
        arg1.paid_mint_allowed = true;
    }

    public entry fun start_pass_mint(arg0: &SuiCityCap, arg1: &mut SuiCityData) {
        arg1.pass_mint_allowed = true;
    }

    public entry fun stop_paid_mint(arg0: &SuiCityCap, arg1: &mut SuiCityData) {
        arg1.paid_mint_allowed = false;
    }

    public entry fun stop_pass_mint(arg0: &SuiCityCap, arg1: &mut SuiCityData) {
        arg1.pass_mint_allowed = false;
    }

    public entry fun withdraw(arg0: &SuiCityCap, arg1: &mut SuiCityData, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

