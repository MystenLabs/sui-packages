module 0x971dce112708c3f8ee73fcb101b51acb93b99bbe6ab93bfcdcf1b0d1bf83f28e::bet {
    struct Registry has store, key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        allowlist: vector<0x1::type_name::TypeName>,
        betted_image_url: 0x2::url::Url,
        betted_attributes: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
        rounds: vector<BetRound>,
        winners: 0x2::vec_map::VecMap<u64, u64>,
        status: bool,
    }

    struct BetRound has drop, store {
        start_time: u64,
        end_time: u64,
    }

    struct CreateRegistryEvent has copy, drop {
        registry: 0x2::object::ID,
        name: 0x1::string::String,
        allowlist: vector<0x1::type_name::TypeName>,
        betted_image_url: 0x2::url::Url,
        attributes_names: vector<0x1::ascii::String>,
        attributes_values: vector<0x1::ascii::String>,
        start_times: vector<u64>,
        end_times: vector<u64>,
        status: bool,
    }

    struct RemoveAllowlistEvent has copy, drop, store {
        registry: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
    }

    struct SetStatusEvent has copy, drop, store {
        registry: 0x2::object::ID,
        status: bool,
    }

    struct SetNameEvent has copy, drop, store {
        registry: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct SetBettedImageUrlEvent has copy, drop, store {
        registry: 0x2::object::ID,
        betted_image_url: 0x2::url::Url,
    }

    struct SetWinnerEvent has copy, drop, store {
        registry: 0x2::object::ID,
        round: u64,
        winner: u64,
    }

    struct SetAttributesEvent has copy, drop, store {
        registry: 0x2::object::ID,
        attributes_names: vector<0x1::ascii::String>,
        attributes_values: vector<0x1::ascii::String>,
    }

    struct SetRoundsEvent has copy, drop, store {
        registry: 0x2::object::ID,
        start_times: vector<u64>,
        end_times: vector<u64>,
    }

    struct AddAllowlistEvent has copy, drop, store {
        registry: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
    }

    struct BetEvent has copy, drop {
        registry: 0x2::object::ID,
        user_addr: address,
        nft_ids: vector<0x2::object::ID>,
        elector: u64,
        bet_time: u64,
        round: u64,
    }

    struct TotalKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ElectorKey has copy, drop, store {
        elector: u64,
    }

    struct BetKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct RoundKey has copy, drop, store {
        round: u64,
    }

    struct OwnerKey has copy, drop, store {
        owner: address,
    }

    struct RoundOwnerKey has copy, drop, store {
        round: u64,
        owner: address,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct BET has drop {
        dummy_field: bool,
    }

    fun get<T0: copy + drop + store>(arg0: &0x2::object::UID, arg1: T0) : u64 {
        if (0x2::dynamic_field::exists_<T0>(arg0, arg1)) {
            *0x2::dynamic_field::borrow<T0, u64>(arg0, arg1)
        } else {
            0
        }
    }

    public entry fun bet<T0: drop>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut 0x4e49af6b743fdd2af989a26dc4c9116fd4c8df1a91a0ebea1ff5dd89e74aff3d::collection::Collection<T0>, arg2: &mut Registry, arg3: &0x2::clock::Clock, arg4: vector<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status, 10008);
        let v0 = 0x1::type_name::get<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg2.allowlist, &v0), 10007);
        let (v1, v2) = current_bet_round_index(arg3, arg2);
        assert!(v1, 10004);
        let v3 = 0;
        0x1::vector::reverse<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>(&mut arg4);
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        while (v3 < 0x1::vector::length<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>(&arg4)) {
            let v5 = 0x1::vector::pop_back<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>(&mut arg4);
            let v6 = 0x1::option::none<0x2::url::Url>();
            if (arg2.betted_image_url != 0x2::url::new_unsafe_from_bytes(b"")) {
                v6 = 0x1::option::some<0x2::url::Url>(arg2.betted_image_url);
            };
            let (v7, v8) = handle_attributes<T0>(arg2, &v5);
            let v9 = Witness{dummy_field: false};
            0x4e49af6b743fdd2af989a26dc4c9116fd4c8df1a91a0ebea1ff5dd89e74aff3d::collection::decorate_with_witness<Witness, T0>(v9, arg0, arg1, &mut v5, 0x1::option::some<bool>(true), v6, v7, v8);
            0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x2::object::id<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>(&v5));
            bet_<T0>(arg2, v5, v2, arg5, arg6);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>(arg4);
        let v10 = BetEvent{
            registry  : 0x2::object::id<Registry>(arg2),
            user_addr : 0x2::tx_context::sender(arg6),
            nft_ids   : v4,
            elector   : arg5,
            bet_time  : 0x2::clock::timestamp_ms(arg3),
            round     : v2,
        };
        0x2::event::emit<BetEvent>(v10);
    }

    public entry fun add_allowlist<T0: drop>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Registry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"bet_admin_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg0), 0x2::tx_context::sender(arg2), v0);
        let v1 = 0x1::type_name::get<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.allowlist, &v1), 10005);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.allowlist, v1);
        let v2 = AddAllowlistEvent{
            registry : 0x2::object::id<Registry>(arg1),
            nft_type : v1,
        };
        0x2::event::emit<AddAllowlistEvent>(v2);
    }

    fun attributes_to(arg0: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>) : (vector<0x1::ascii::String>, vector<0x1::ascii::String>) {
        0x2::vec_map::into_keys_values<0x1::ascii::String, 0x1::ascii::String>(arg0)
    }

    fun bet_<T0>(arg0: &mut Registry, arg1: 0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = BetKey{id: 0x2::object::id<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>(&arg1)};
        assert!(!0x2::dynamic_field::exists_<BetKey>(&mut arg0.id, v0), 10001);
        let v1 = BetKey{id: 0x2::object::id<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>(&arg1)};
        0x2::dynamic_field::add<BetKey, u64>(&mut arg0.id, v1, arg3);
        let v2 = &mut arg0.id;
        let v3 = ElectorKey{elector: arg3};
        hand<ElectorKey>(v2, v3);
        let v4 = &mut arg0.id;
        let v5 = RoundKey{round: arg2};
        hand<RoundKey>(v4, v5);
        let v6 = &mut arg0.id;
        let v7 = OwnerKey{owner: 0x2::tx_context::sender(arg4)};
        hand<OwnerKey>(v6, v7);
        let v8 = &mut arg0.id;
        let v9 = RoundOwnerKey{
            round : arg2,
            owner : 0x2::tx_context::sender(arg4),
        };
        hand<RoundOwnerKey>(v8, v9);
        let v10 = &mut arg0.id;
        let v11 = TotalKey{dummy_field: false};
        hand<TotalKey>(v10, v11);
        0x2::transfer::public_transfer<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>(arg1, 0x2::tx_context::sender(arg4));
    }

    public fun bet_count_for_elector(arg0: &mut Registry, arg1: u64) : u64 {
        let v0 = ElectorKey{elector: arg1};
        get<ElectorKey>(&arg0.id, v0)
    }

    public fun bet_count_for_owner(arg0: &mut Registry, arg1: address) : u64 {
        let v0 = OwnerKey{owner: arg1};
        get<OwnerKey>(&arg0.id, v0)
    }

    public fun bet_count_for_round(arg0: &mut Registry, arg1: u64) : u64 {
        let v0 = RoundKey{round: arg1};
        get<RoundKey>(&arg0.id, v0)
    }

    public fun bet_count_for_round_owner(arg0: &mut Registry, arg1: u64, arg2: address) : u64 {
        let v0 = RoundOwnerKey{
            round : arg1,
            owner : arg2,
        };
        get<RoundOwnerKey>(&arg0.id, v0)
    }

    public fun bet_total_count(arg0: &mut Registry) : u64 {
        let v0 = TotalKey{dummy_field: false};
        get<TotalKey>(&arg0.id, v0)
    }

    public entry fun create_registry<T0: drop>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>, arg5: bool, arg6: vector<u64>, arg7: vector<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"bet_admin_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg0), 0x2::tx_context::sender(arg8), v0);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1::type_name::get<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>());
        let v2 = Registry{
            id                : 0x2::object::new(arg8),
            version           : 1,
            name              : 0x1::string::utf8(arg1),
            allowlist         : v1,
            betted_image_url  : 0x2::url::new_unsafe_from_bytes(arg2),
            betted_attributes : get_attributes(arg3, arg4),
            rounds            : get_rounds(arg6, arg7),
            winners           : 0x2::vec_map::empty<u64, u64>(),
            status            : arg5,
        };
        let v3 = CreateRegistryEvent{
            registry          : 0x2::object::id<Registry>(&v2),
            name              : v2.name,
            allowlist         : v2.allowlist,
            betted_image_url  : v2.betted_image_url,
            attributes_names  : arg3,
            attributes_values : arg4,
            start_times       : arg6,
            end_times         : arg7,
            status            : v2.status,
        };
        0x2::event::emit<CreateRegistryEvent>(v3);
        0x2::transfer::public_share_object<Registry>(v2);
    }

    fun current_bet_round_index(arg0: &0x2::clock::Clock, arg1: &mut Registry) : (bool, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x1::vector::length<BetRound>(&arg1.rounds);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x1::vector::borrow<BetRound>(&arg1.rounds, v2);
            if (v3.start_time <= v0 && v0 < v3.end_time) {
                return (true, v2)
            };
            v2 = v2 + 1;
        };
        (false, v1)
    }

    fun get_attributes(arg0: vector<0x1::ascii::String>, arg1: vector<0x1::ascii::String>) : 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String> {
        assert!(0x1::vector::length<0x1::ascii::String>(&arg0) == 0x1::vector::length<0x1::ascii::String>(&arg1), 10003);
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>();
        while (v0 < 0x1::vector::length<0x1::ascii::String>(&arg0)) {
            0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v1, *0x1::vector::borrow<0x1::ascii::String>(&arg0, v0), *0x1::vector::borrow<0x1::ascii::String>(&arg1, v0));
            v0 = v0 + 1;
        };
        v1
    }

    fun get_rounds(arg0: vector<u64>, arg1: vector<u64>) : vector<BetRound> {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 10002);
        let v0 = 0x1::vector::empty<BetRound>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            let v2 = BetRound{
                start_time : *0x1::vector::borrow<u64>(&arg0, v1),
                end_time   : *0x1::vector::borrow<u64>(&arg1, v1),
            };
            0x1::vector::push_back<BetRound>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun hand<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0) {
        if (0x2::dynamic_field::exists_<T0>(arg0, arg1)) {
            let v0 = 0x2::dynamic_field::borrow_mut<T0, u64>(arg0, arg1);
            *v0 = *v0 + 1;
        } else {
            0x2::dynamic_field::add<T0, u64>(arg0, arg1, 1);
        };
    }

    public fun handle_attributes<T0>(arg0: &mut Registry, arg1: &0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>) : (vector<0x1::ascii::String>, vector<0x1::ascii::String>) {
        attributes_to(arg0.betted_attributes)
    }

    fun init(arg0: BET, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BET>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun init_(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<BET>(&arg1), 10010);
        0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::put_publisher<BET>(arg0, arg1, arg2);
    }

    public entry fun remove_allowlist<T0: drop>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Registry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"bet_admin_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg0), 0x2::tx_context::sender(arg2), v0);
        let v1 = 0x1::type_name::get<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>();
        let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.allowlist, &v1);
        assert!(v2, 10006);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut arg1.allowlist, v3);
        let v4 = RemoveAllowlistEvent{
            registry : 0x2::object::id<Registry>(arg1),
            nft_type : v1,
        };
        0x2::event::emit<RemoveAllowlistEvent>(v4);
    }

    public entry fun set_attributes(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Registry, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"bet_admin_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg0), 0x2::tx_context::sender(arg4), v0);
        arg1.betted_attributes = get_attributes(arg2, arg3);
        let v1 = SetAttributesEvent{
            registry          : 0x2::object::id<Registry>(arg1),
            attributes_names  : arg2,
            attributes_values : arg3,
        };
        0x2::event::emit<SetAttributesEvent>(v1);
    }

    public entry fun set_betted_image_url(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Registry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"bet_admin_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg0), 0x2::tx_context::sender(arg3), v0);
        arg1.betted_image_url = 0x2::url::new_unsafe_from_bytes(arg2);
        let v1 = SetBettedImageUrlEvent{
            registry         : 0x2::object::id<Registry>(arg1),
            betted_image_url : arg1.betted_image_url,
        };
        0x2::event::emit<SetBettedImageUrlEvent>(v1);
    }

    public entry fun set_name(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Registry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"bet_admin_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg0), 0x2::tx_context::sender(arg3), v0);
        arg1.name = 0x1::string::utf8(arg2);
        let v1 = SetNameEvent{
            registry : 0x2::object::id<Registry>(arg1),
            name     : arg1.name,
        };
        0x2::event::emit<SetNameEvent>(v1);
    }

    public entry fun set_rounds(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Registry, arg2: vector<u64>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"bet_admin_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg0), 0x2::tx_context::sender(arg4), v0);
        arg1.rounds = get_rounds(arg2, arg3);
        let v1 = SetRoundsEvent{
            registry    : 0x2::object::id<Registry>(arg1),
            start_times : arg2,
            end_times   : arg3,
        };
        0x2::event::emit<SetRoundsEvent>(v1);
    }

    public entry fun set_status(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Registry, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"bet_admin_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg0), 0x2::tx_context::sender(arg3), v0);
        arg1.status = arg2;
        let v1 = SetStatusEvent{
            registry : 0x2::object::id<Registry>(arg1),
            status   : arg2,
        };
        0x2::event::emit<SetStatusEvent>(v1);
    }

    public entry fun set_winner(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"bet_admin_role"));
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg0), 0x2::tx_context::sender(arg4), v0);
        if (0x2::vec_map::contains<u64, u64>(&arg1.winners, &arg2)) {
            *0x2::vec_map::get_mut<u64, u64>(&mut arg1.winners, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<u64, u64>(&mut arg1.winners, arg2, arg3);
        };
        let v1 = SetWinnerEvent{
            registry : 0x2::object::id<Registry>(arg1),
            round    : arg2,
            winner   : arg3,
        };
        0x2::event::emit<SetWinnerEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

