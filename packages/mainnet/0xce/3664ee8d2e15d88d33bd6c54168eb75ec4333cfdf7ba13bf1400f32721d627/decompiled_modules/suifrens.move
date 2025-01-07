module 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens {
    struct SuiFren<phantom T0> has store, key {
        id: 0x2::object::UID,
        generation: u64,
        birthdate: u64,
        cohort: u32,
        genes: vector<u8>,
        attributes: vector<0x1::string::String>,
        birth_location: 0x1::string::String,
    }

    struct AppCap has drop, store {
        app_name: 0x1::string::String,
        cohort: u32,
        cohort_name: 0x1::string::String,
        time_limit: u64,
        minting_limit: u64,
        minting_counter: u64,
        allowed_country_codes: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AppKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct SUIFRENS has drop {
        dummy_field: bool,
    }

    struct SuiFrenMinted has copy, drop {
        id: 0x2::object::ID,
        app_name: 0x1::string::String,
        generation: u64,
        cohort: u32,
        genes: vector<u8>,
        attributes: vector<0x1::string::String>,
        birth_location: 0x1::string::String,
        birthdate: u64,
        created_by: address,
    }

    public fun add_country_code<T0>(arg0: &AdminCap, arg1: &mut 0x2::object::UID, arg2: 0x1::string::String) {
        let v0 = app_cap_mut<T0>(arg1);
        assert!(!0x2::vec_set::contains<0x1::string::String>(&v0.allowed_country_codes, &arg2), 3);
        0x2::vec_set::insert<0x1::string::String>(&mut v0.allowed_country_codes, arg2);
    }

    fun app_cap_mut<T0>(arg0: &mut 0x2::object::UID) : &mut AppCap {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AppKey<T0>, AppCap>(arg0, v0)
    }

    public fun attributes<T0>(arg0: &SuiFren<T0>) : &vector<0x1::string::String> {
        &arg0.attributes
    }

    public fun authorize_app<T0>(arg0: &AdminCap, arg1: &mut 0x2::object::UID, arg2: 0x1::string::String, arg3: u32, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: vector<0x1::string::String>) {
        let v0 = AppKey<T0>{dummy_field: false};
        let v1 = AppCap{
            app_name              : arg2,
            cohort                : arg3,
            cohort_name           : arg4,
            time_limit            : arg5,
            minting_limit         : arg6,
            minting_counter       : 0,
            allowed_country_codes : vec_to_set<0x1::string::String>(arg7),
        };
        0x2::dynamic_field::add<AppKey<T0>, AppCap>(arg1, v0, v1);
    }

    public fun birth_location<T0>(arg0: &SuiFren<T0>) : 0x1::string::String {
        arg0.birth_location
    }

    public fun birthdate<T0>(arg0: &SuiFren<T0>) : u64 {
        arg0.birthdate
    }

    public fun burn<T0>(arg0: &mut 0x2::object::UID, arg1: SuiFren<T0>) : 0x2::object::UID {
        assert!(is_authorized<T0>(arg0), 0);
        let SuiFren {
            id             : v0,
            generation     : _,
            birthdate      : _,
            cohort         : _,
            genes          : _,
            attributes     : _,
            birth_location : _,
        } = arg1;
        v0
    }

    public fun cohort<T0>(arg0: &SuiFren<T0>) : u32 {
        arg0.cohort
    }

    public fun generation<T0>(arg0: &SuiFren<T0>) : u64 {
        arg0.generation
    }

    public fun genes<T0>(arg0: &SuiFren<T0>) : &vector<u8> {
        &arg0.genes
    }

    fun get_birth_location(arg0: &AppCap, arg1: vector<u8>) : 0x1::string::String {
        let v0 = 0x2::vec_set::into_keys<0x1::string::String>(arg0.allowed_country_codes);
        let v1 = (*0x1::vector::borrow<u8>(&arg1, 0) as u128);
        let v2 = 1;
        while (v2 < 16) {
            let v3 = v1 << 8;
            v1 = v3 + (*0x1::vector::borrow<u8>(&arg1, v2) as u128);
            v2 = v2 + 1;
        };
        *0x1::vector::borrow<0x1::string::String>(&v0, ((v1 % (0x1::vector::length<0x1::string::String>(&v0) as u128)) as u64))
    }

    fun init(arg0: SUIFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SUIFRENS>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_authorized<T0>(arg0: &0x2::object::UID) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<AppKey<T0>>(arg0, v0)
    }

    public fun mint<T0>(arg0: &mut 0x2::object::UID, arg1: u64, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : SuiFren<T0> {
        assert!(is_authorized<T0>(arg0), 0);
        let v0 = app_cap_mut<T0>(arg0);
        assert!(0x2::clock::timestamp_ms(arg4) <= v0.time_limit, 1);
        assert!(v0.minting_counter < v0.minting_limit, 2);
        assert!(!0x2::vec_set::is_empty<0x1::string::String>(&v0.allowed_country_codes), 5);
        v0.minting_counter = v0.minting_counter + 1;
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = 0x1::vector::empty<vector<u8>>();
        let v4 = &mut v3;
        0x1::vector::push_back<vector<u8>>(v4, 0x2::bcs::to_bytes<0x2::object::UID>(&v1));
        0x1::vector::push_back<vector<u8>>(v4, 0x2::bcs::to_bytes<vector<u8>>(&arg2));
        0x1::vector::push_back<vector<u8>>(v4, 0x2::bcs::to_bytes<u64>(&v2));
        let v5 = 0x2::bcs::to_bytes<vector<vector<u8>>>(&v3);
        let v6 = get_birth_location(v0, 0x2::hash::blake2b256(&v5));
        let v7 = SuiFrenMinted{
            id             : 0x2::object::uid_to_inner(&v1),
            app_name       : v0.app_name,
            generation     : arg1,
            cohort         : v0.cohort,
            genes          : arg2,
            attributes     : arg3,
            birth_location : v6,
            birthdate      : v2,
            created_by     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<SuiFrenMinted>(v7);
        SuiFren<T0>{
            id             : v1,
            generation     : arg1,
            birthdate      : v2,
            cohort         : v0.cohort,
            genes          : arg2,
            attributes     : arg3,
            birth_location : v6,
        }
    }

    public fun remove_country_code<T0>(arg0: &AdminCap, arg1: &mut 0x2::object::UID, arg2: 0x1::string::String) {
        let v0 = app_cap_mut<T0>(arg1);
        assert!(0x2::vec_set::contains<0x1::string::String>(&v0.allowed_country_codes, &arg2), 4);
        0x2::vec_set::remove<0x1::string::String>(&mut v0.allowed_country_codes, &arg2);
    }

    public fun revoke_auth<T0>(arg0: &AdminCap, arg1: &mut 0x2::object::UID) {
        let v0 = AppKey<T0>{dummy_field: false};
        let AppCap {
            app_name              : _,
            cohort                : _,
            cohort_name           : _,
            time_limit            : _,
            minting_limit         : _,
            minting_counter       : _,
            allowed_country_codes : _,
        } = 0x2::dynamic_field::remove<AppKey<T0>, AppCap>(arg1, v0);
    }

    public fun uid<T0>(arg0: &SuiFren<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut<T0>(arg0: &mut SuiFren<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun vec_to_set<T0: copy + drop + store>(arg0: vector<T0>) : 0x2::vec_set::VecSet<T0> {
        let v0 = 0x2::vec_set::empty<T0>();
        while (0x1::vector::length<T0>(&arg0) > 0) {
            0x2::vec_set::insert<T0>(&mut v0, 0x1::vector::pop_back<T0>(&mut arg0));
        };
        v0
    }

    // decompiled from Move bytecode v6
}

