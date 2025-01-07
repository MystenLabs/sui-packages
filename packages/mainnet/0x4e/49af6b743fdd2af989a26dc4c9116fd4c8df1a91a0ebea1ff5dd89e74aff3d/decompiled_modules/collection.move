module 0x4e49af6b743fdd2af989a26dc4c9116fd4c8df1a91a0ebea1ff5dd89e74aff3d::collection {
    struct Collection<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        mystery_box: bool,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        description: 0x1::string::String,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct CreateCollectionEvent has copy, drop {
        collection: 0x2::object::ID,
        fixer: 0x2::object::ID,
        mystery_box: bool,
        nft_type: 0x1::type_name::TypeName,
        name: 0x1::string::String,
        banner: 0x2::url::Url,
        image_url: 0x2::url::Url,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        link: 0x1::string::String,
    }

    struct ModifyCollectionEvent has copy, drop {
        collection: 0x2::object::ID,
        fixer: 0x2::object::ID,
        mystery_box: bool,
        nft_type: 0x1::type_name::TypeName,
        name: 0x1::string::String,
        banner: 0x2::url::Url,
        image_url: 0x2::url::Url,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        link: 0x1::string::String,
    }

    struct IncreaseSupplyEvent has copy, drop {
        nft_type: 0x1::type_name::TypeName,
        increase_value: u64,
        total_supply: u64,
    }

    struct DecreaseSupplyEvent has copy, drop {
        nft_type: 0x1::type_name::TypeName,
        decrease_value: u64,
        total_supply: u64,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    public entry fun batch_burn<T0>(arg0: &mut Collection<T0>, arg1: vector<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = &mut arg0.id;
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::decrease(borrow_mut_fixer(v0), 0x1::vector::length<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>(&arg1));
        let v1 = &mut arg0.id;
        0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::batch_burn<T0>(borrow_mut_nft_version(v1), arg1, arg2);
    }

    public entry fun batch_open<T0>(arg0: &mut Collection<T0>, arg1: vector<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = &mut arg0.id;
        let v1 = borrow_mut_fixer(v0);
        assert_nft_fixer<T0>(v1);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>>(&arg1)) {
            let (v5, v6) = 0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::distribute(v1, false);
            0x1::vector::push_back<u64>(&mut v2, v5);
            0x1::vector::push_back<0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>>(&mut v3, v6);
            v4 = v4 + 1;
        };
        let v7 = &mut arg0.id;
        0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::batch_open<T0>(borrow_mut_nft_version(v7), arg1, v2, v3, arg2);
    }

    public entry fun burn<T0>(arg0: &mut Collection<T0>, arg1: 0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = &mut arg0.id;
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::decrease(borrow_mut_fixer(v0), 1);
        let v1 = &mut arg0.id;
        0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::burn<T0>(borrow_mut_nft_version(v1), arg1, arg2);
    }

    public entry fun decorate<T0>(arg0: &mut Collection<T0>, arg1: &mut 0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: vector<address>) {
        assert_version<T0>(arg0);
        let v0 = &mut arg0.id;
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::assert_whitelist(borrow_mut_fixer(v0), *0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::borrow_token_id<T0>(arg1), arg2, arg3, arg4);
        let v1 = &mut arg0.id;
        0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::decorate<T0>(borrow_mut_nft_version(v1), arg1, 0x1::option::none<0x2::url::Url>(), arg2, arg3);
    }

    fun mint<T0>(arg0: &mut 0x2::object::UID, arg1: bool, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_fixer(arg0);
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::increase(v0, arg3);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<0x2::url::Url>();
        let v3 = 0x1::vector::empty<0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>>();
        let v4 = 0;
        while (v4 < arg3) {
            let (v5, v6) = 0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::distribute(v0, arg1);
            0x1::vector::push_back<u64>(&mut v1, v5);
            0x1::vector::push_back<0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>>(&mut v3, v6);
            0x1::vector::push_back<0x2::url::Url>(&mut v2, 0x2::url::new_unsafe(0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::to_url(*0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_image_url(v0), v5)));
            v4 = v4 + 1;
        };
        0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::batch_mint<T0>(borrow_mut_nft_version(arg0), arg2, *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_name(v0), *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_description(v0), *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_project_url(v0), *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_link(v0), &v1, &v2, &v3, arg3, arg4);
    }

    public entry fun open<T0>(arg0: &mut Collection<T0>, arg1: 0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = &mut arg0.id;
        let v1 = borrow_mut_fixer(v0);
        assert_nft_fixer<T0>(v1);
        let (v2, v3) = 0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::distribute(v1, false);
        let v4 = &mut arg0.id;
        0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::open<T0>(borrow_mut_nft_version(v4), arg1, v2, v3, arg2);
    }

    public entry fun add_attribute<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Collection<T0>, arg2: bool, arg3: 0x1::ascii::String, arg4: u8, arg5: vector<u64>, arg6: vector<0x1::ascii::String>, arg7: vector<0x1::ascii::String>, arg8: vector<0x1::ascii::String>, arg9: vector<u64>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"attribute_role"));
        assert_anyone_match_for_sender(arg0, v0, arg11);
        assert_version<T0>(arg1);
        let v2 = &mut arg1.id;
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::add_attribute(borrow_mut_fixer(v2), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun add_fixer_whitelist<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Collection<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"whitelist_role"));
        assert_anyone_match_for_sender(arg0, v0, arg3);
        assert_version<T0>(arg1);
        let v2 = &mut arg1.id;
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::add_whitelist(borrow_mut_fixer(v2), arg2);
    }

    public entry fun add_limit_for_composition<T0, T1: store + key>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Collection<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"composition_role"));
        assert_anyone_match_for_sender(arg0, v0, arg3);
        assert_version<T0>(arg1);
        let v2 = &mut arg1.id;
        0x76cbbe5427a01e2cd8548c158d333bb451d73eec74937abd65a2afa6dd8d2401::composition::add_limit<T0, T1>(borrow_mut_composition<T0>(v2), arg2);
    }

    public entry fun add_phaser_whitelists(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"phaser_role"));
        assert_anyone_match_for_sender(arg0, v0, arg3);
        let v2 = Witness{dummy_field: false};
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::add_phaser_whitelists(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_mut_publisher<Witness, 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::PHASER>(&v2, arg0), arg1, arg2);
    }

    public entry fun airdrop<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Collection<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"airdrop_role"));
        assert_anyone_match_for_sender(arg0, v0, arg4);
        assert_version<T0>(arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v3 = &mut arg1.id;
            mint<T0>(v3, arg1.mystery_box, *0x1::vector::borrow<address>(&arg2, v2), *0x1::vector::borrow<u64>(&arg3, v2), arg4);
            v2 = v2 + 1;
        };
    }

    fun assert_anyone_match_for_sender(arg0: &0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) {
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_anyone_match_for_sender(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg0), 0x2::tx_context::sender(arg2), arg1);
    }

    fun assert_nft_fixer<T0>(arg0: &0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Fixer) {
        assert!(0x1::option::is_some<0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::TokenField>(0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_token_id(arg0)), 10004);
    }

    fun assert_version<T0>(arg0: &Collection<T0>) {
        assert!(arg0.version == 1, 10001);
    }

    fun assert_whitelist_mint_count(arg0: &0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser, arg1: address, arg2: u64, arg3: u64) {
        assert!(0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::get_user_minted_amount(arg0, arg1) + arg2 <= arg3, 10003);
    }

    public fun balance<T0>(arg0: &0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad) : u64 {
        0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::balance<T0>(borrow_wallet(arg0))
    }

    public fun balance_of<T0>(arg0: &Collection<T0>) : u64 {
        *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_balance(borrow_fixer(&arg0.id))
    }

    public fun batch_mint_with_witness<T0: drop, T1>(arg0: T0, arg1: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg2: &mut Collection<T1>, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_only_role_for_witness(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg1), 0x1::type_name::get<T0>(), 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"witness_mint_role"));
        assert_version<T1>(arg2);
        let v0 = &mut arg2.id;
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::increase(borrow_mut_fixer(v0), sum(&arg4));
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            let v2 = &mut arg2.id;
            mint<T1>(v2, arg2.mystery_box, *0x1::vector::borrow<address>(&arg3, v1), *0x1::vector::borrow<u64>(&arg4, v1), arg5);
            v1 = v1 + 1;
        };
    }

    public fun borrow_attribute<T0>(arg0: &Collection<T0>, arg1: bool, arg2: 0x1::ascii::String) : &0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Field {
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_attribute(borrow_fixer(&arg0.id), arg1, arg2)
    }

    fun borrow_composition<T0>(arg0: &0x2::object::UID) : &0x76cbbe5427a01e2cd8548c158d333bb451d73eec74937abd65a2afa6dd8d2401::composition::Composition<T0> {
        0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::borrow_object_by_index<0x76cbbe5427a01e2cd8548c158d333bb451d73eec74937abd65a2afa6dd8d2401::composition::Composition<T0>>(arg0, 0)
    }

    fun borrow_fixer(arg0: &0x2::object::UID) : &0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Fixer {
        0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::borrow_object_by_index<0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Fixer>(arg0, 0)
    }

    fun borrow_mut_composition<T0>(arg0: &mut 0x2::object::UID) : &mut 0x76cbbe5427a01e2cd8548c158d333bb451d73eec74937abd65a2afa6dd8d2401::composition::Composition<T0> {
        0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::borrow_mut_object_by_index<0x76cbbe5427a01e2cd8548c158d333bb451d73eec74937abd65a2afa6dd8d2401::composition::Composition<T0>>(arg0, 0)
    }

    fun borrow_mut_fixer(arg0: &mut 0x2::object::UID) : &mut 0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Fixer {
        0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::borrow_mut_object_by_index<0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Fixer>(arg0, 0)
    }

    fun borrow_mut_nft_version(arg0: &mut 0x2::object::UID) : &mut 0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Version {
        0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::borrow_mut_object_by_index<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Version>(arg0, 0)
    }

    fun borrow_mut_wallet(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad) : &mut 0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::Wallet {
        let v0 = Witness{dummy_field: false};
        0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_mut_bind<Witness, 0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::Wallet>(&v0, arg0)
    }

    fun borrow_nft_version(arg0: &0x2::object::UID) : &0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Version {
        0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::borrow_object_by_index<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Version>(arg0, 0)
    }

    fun borrow_wallet(arg0: &0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad) : &0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::Wallet {
        0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_bind<0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::Wallet>(arg0)
    }

    public entry fun compose_nft<T0, T1: store + key>(arg0: &mut Collection<T0>, arg1: &mut 0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>, arg2: vector<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::take<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Version>(&mut arg0.id, *0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::borrow_mut_object_id<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Version>(&mut arg0.id, 0), arg3);
        let v1 = 0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::borrow_mut_id<T0>(&mut v0, arg1);
        let v2 = borrow_composition<T0>(&arg0.id);
        let v3 = 0;
        while (v3 < 0x1::vector::length<T1>(&arg2)) {
            0x76cbbe5427a01e2cd8548c158d333bb451d73eec74937abd65a2afa6dd8d2401::composition::compose<T0, T1>(v2, v1, 0x1::vector::remove<T1>(&mut arg2, v3), arg3);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<T1>(arg2);
        0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::put<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Version>(&mut arg0.id, v0, arg3);
    }

    public fun contains_attribute<T0>(arg0: &Collection<T0>, arg1: bool, arg2: 0x1::ascii::String) : bool {
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::contains_attribute(borrow_fixer(&arg0.id), arg1, arg2)
    }

    public fun contains_fixer_whitelist<T0>(arg0: &Collection<T0>, arg1: address) : bool {
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::contains_whitelist(borrow_fixer(&arg0.id), arg1)
    }

    public fun contains_phaser_whitelist(arg0: &0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser, arg1: address) : bool {
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::contains_whitelist(arg0, arg1)
    }

    public entry fun create_collection<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: bool, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"collection_role"));
        assert_anyone_match_for_sender(arg0, v0, arg9);
        let v2 = Collection<T0>{
            id          : 0x2::object::new(arg9),
            version     : 1,
            mystery_box : arg1,
            name        : 0x1::string::utf8(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
            description : 0x1::string::utf8(arg5),
        };
        let v3 = 0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::init_fixer(arg2, arg5, arg4, arg6, arg7, 0x1::option::none<u8>(), arg8, arg9);
        let v4 = CreateCollectionEvent{
            collection  : 0x2::object::uid_to_inner(&v2.id),
            fixer       : 0x2::object::id<0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Fixer>(&v3),
            mystery_box : arg1,
            nft_type    : 0x1::type_name::get<T0>(),
            name        : 0x1::string::utf8(arg2),
            banner      : 0x2::url::new_unsafe_from_bytes(arg3),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg4),
            description : 0x1::string::utf8(arg5),
            project_url : 0x1::string::utf8(arg6),
            link        : 0x1::string::utf8(arg7),
        };
        0x2::event::emit<CreateCollectionEvent>(v4);
        let v5 = Witness{dummy_field: false};
        let v6 = 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_mut_publisher<Witness, COLLECTION>(&v5, arg0);
        init_display<T0>(v6, arg9);
        let v7 = Witness{dummy_field: false};
        0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::put<0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Fixer>(&mut v2.id, v3, arg9);
        0x76cbbe5427a01e2cd8548c158d333bb451d73eec74937abd65a2afa6dd8d2401::composition::init_composition<T0>(&mut v2.id, arg9);
        0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::put<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Version>(&mut v2.id, 0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::init_collection<T0>(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_mut_publisher<Witness, 0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::NFT>(&v7, arg0), arg9), arg9);
        let v8 = IncreaseSupplyEvent{
            nft_type       : 0x1::type_name::get<T0>(),
            increase_value : arg8,
            total_supply   : arg8,
        };
        0x2::event::emit<IncreaseSupplyEvent>(v8);
        0x2::transfer::public_share_object<Collection<T0>>(v2);
    }

    public entry fun create_phaser<T0, T1>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: vector<address>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"phaser_role"));
        assert_anyone_match_for_sender(arg0, v0, arg9);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_phaser_status(arg7);
        let v2 = Witness{dummy_field: false};
        0x2::transfer::public_share_object<0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser>(0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::create_phaser(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_mut_publisher<Witness, 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::PHASER>(&v2, arg0), 0x1::type_name::get<Collection<T1>>(), 0x1::type_name::get<T0>(), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public entry fun decompose_nft<T0, T1: store + key>(arg0: &mut Collection<T0>, arg1: &mut 0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T0>, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::take<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Version>(&mut arg0.id, *0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::borrow_mut_object_id<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Version>(&mut arg0.id, 0), arg3);
        let v1 = 0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::borrow_mut_id<T0>(&mut v0, arg1);
        let v2 = borrow_composition<T0>(&arg0.id);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            0x2::transfer::public_transfer<T1>(0x76cbbe5427a01e2cd8548c158d333bb451d73eec74937abd65a2afa6dd8d2401::composition::decompose<T0, T1>(v2, v1, 0x1::vector::remove<0x2::object::ID>(&mut arg2, v3), arg3), 0x2::tx_context::sender(arg3));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
        0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::put<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Version>(&mut arg0.id, v0, arg3);
    }

    public fun decorate_with_witness<T0: drop, T1>(arg0: T0, arg1: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg2: &mut Collection<T1>, arg3: &mut 0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::Nft<T1>, arg4: 0x1::option::Option<bool>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: vector<0x1::ascii::String>, arg7: vector<0x1::ascii::String>) {
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_only_role_for_witness(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg1), 0x1::type_name::get<T0>(), 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"witness_decorate_role"));
        assert_version<T1>(arg2);
        let v0 = &mut arg2.id;
        let v1 = borrow_mut_nft_version(v0);
        if (0x1::option::is_some<bool>(&arg4)) {
            *0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::borrow_mut_betted<T1>(v1, arg3) = *0x1::option::borrow<bool>(&arg4);
        };
        0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::decorate<T1>(v1, arg3, arg5, arg6, arg7);
    }

    public entry fun decrease_supply<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Collection<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"collection_role"));
        assert_anyone_match_for_sender(arg0, v0, arg3);
        assert_version<T0>(arg1);
        0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::assert_not_empty_bucket<0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Fixer>(&arg1.id);
        let v2 = &mut arg1.id;
        let v3 = borrow_mut_fixer(v2);
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::decrease_supply(v3, arg2);
        let v4 = DecreaseSupplyEvent{
            nft_type       : 0x1::type_name::get<T0>(),
            decrease_value : arg2,
            total_supply   : *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_supply(v3),
        };
        0x2::event::emit<DecreaseSupplyEvent>(v4);
    }

    public entry fun deposit<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::deposit<T0>(borrow_mut_wallet(arg0), arg1, arg2);
    }

    public entry fun drop_limit_for_composition<T0, T1: store + key>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Collection<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"composition_role"));
        assert_anyone_match_for_sender(arg0, v0, arg2);
        assert_version<T0>(arg1);
        let v2 = &mut arg1.id;
        0x76cbbe5427a01e2cd8548c158d333bb451d73eec74937abd65a2afa6dd8d2401::composition::drop_limit<T0, T1>(borrow_mut_composition<T0>(v2));
    }

    public entry fun free_mint<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg2: &mut Collection<T0>, arg3: &mut 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg2);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_phaser_opened(arg3);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_free_price(arg3);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_mint_timestamp(arg3, 0x2::clock::timestamp_ms(arg0));
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_phaser_mint_count(arg3, 0x2::tx_context::sender(arg5), arg4);
        let v0 = Witness{dummy_field: false};
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::increment(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_mut_publisher<Witness, 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::PHASER>(&v0, arg1), arg3, 0x2::tx_context::sender(arg5), arg4);
        let v1 = &mut arg2.id;
        let v2 = 0x2::tx_context::sender(arg5);
        mint<T0>(v1, arg2.mystery_box, v2, arg4, arg5);
    }

    public entry fun free_whitelist_mint<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg2: &mut Collection<T0>, arg3: &mut 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser, arg4: u64, arg5: u64, arg6: vector<address>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg2);
        assert_whitelist_mint_count(arg3, 0x2::tx_context::sender(arg7), arg4, arg5);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_phaser_whitelist_opened(arg3);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_collection_type<Collection<T0>>(arg3);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_free_price(arg3);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_mint_timestamp(arg3, 0x2::clock::timestamp_ms(arg0));
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_phaser_mint_count(arg3, 0x2::tx_context::sender(arg7), arg4);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_whitelist_merkle_root(arg3, 0x2::tx_context::sender(arg7), arg5, arg6);
        let v0 = Witness{dummy_field: false};
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::increment(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_mut_publisher<Witness, 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::PHASER>(&v0, arg1), arg3, 0x2::tx_context::sender(arg7), arg4);
        let v1 = &mut arg2.id;
        let v2 = 0x2::tx_context::sender(arg7);
        mint<T0>(v1, arg2.mystery_box, v2, arg4, arg7);
    }

    public fun get_attributes<T0>(arg0: &Collection<T0>) : &0x2::table::Table<0x1::ascii::String, 0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Field> {
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_attributes(borrow_fixer(&arg0.id))
    }

    public fun get_attributes_names<T0>(arg0: &Collection<T0>) : vector<0x1::ascii::String> {
        *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_attributes_names(borrow_fixer(&arg0.id))
    }

    public fun get_fixer<T0>(arg0: &Collection<T0>) : &0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Fixer {
        borrow_fixer(&arg0.id)
    }

    public fun get_fixer_whitelists<T0>(arg0: &Collection<T0>) : &0x2::table::Table<address, bool> {
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_whitelists(borrow_fixer(&arg0.id))
    }

    public fun get_mystery_box_attributes<T0>(arg0: &Collection<T0>) : &0x2::table::Table<0x1::ascii::String, 0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Field> {
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_mystery_box_attributes(borrow_fixer(&arg0.id))
    }

    public fun get_mystery_box_attributes_names<T0>(arg0: &Collection<T0>) : vector<0x1::ascii::String> {
        *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_mystery_box_attributes_names(borrow_fixer(&arg0.id))
    }

    public fun get_phaser_whitelists(arg0: &0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser) : &0x2::table::Table<address, bool> {
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::borrow_whitelist_merkle_roots(arg0)
    }

    public fun get_token_mode<T0>(arg0: &Collection<T0>) : 0x1::option::Option<u8> {
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_token_mode(borrow_fixer(&arg0.id))
    }

    public fun get_user_minted_amount(arg0: &0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser, arg1: address) : u64 {
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::get_user_minted_amount(arg0, arg1)
    }

    public entry fun increase_supply<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Collection<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"collection_role"));
        assert_anyone_match_for_sender(arg0, v0, arg3);
        assert_version<T0>(arg1);
        0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::assert_not_empty_bucket<0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Fixer>(&arg1.id);
        let v2 = &mut arg1.id;
        let v3 = borrow_mut_fixer(v2);
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::increase_supply(v3, arg2);
        let v4 = IncreaseSupplyEvent{
            nft_type       : 0x1::type_name::get<T0>(),
            increase_value : arg2,
            total_supply   : *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_supply(v3),
        };
        0x2::event::emit<IncreaseSupplyEvent>(v4);
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<COLLECTION>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun init_(arg0: &mut 0x2::package::Publisher, arg1: 0x2::package::Publisher, arg2: 0x2::package::Publisher, arg3: 0x2::package::Publisher, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::init_launchpad<Witness>(arg0, v0, arg4);
        0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::bind<0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::Wallet>(&mut v1, 0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::init_wallet(arg4), arg4);
        0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::put_publisher<COLLECTION>(&mut v1, arg1, arg4);
        0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::put_publisher<0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::NFT>(&mut v1, arg2, arg4);
        0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::put_publisher<0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::PHASER>(&mut v1, arg3, arg4);
        0x2::transfer::public_share_object<0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad>(v1);
    }

    fun init_display<T0>(arg0: &mut 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::from_module<Collection<T0>>(arg0);
        let v0 = 0x2::display::new<Collection<T0>>(arg0, arg1);
        0x2::display::add<Collection<T0>>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Collection<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Collection<T0>>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::update_version<Collection<T0>>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<Collection<T0>>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun limits_for_composition<T0>(arg0: &Collection<T0>) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        *0x76cbbe5427a01e2cd8548c158d333bb451d73eec74937abd65a2afa6dd8d2401::composition::borrow_limits<T0>(borrow_composition<T0>(&arg0.id))
    }

    public entry fun migrate<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Collection<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_only_role_for_sender(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg0), 0x2::tx_context::sender(arg2), 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        assert!(arg1.version < 1, 10002);
        arg1.version = 1;
    }

    public fun mint_with_witness<T0: drop, T1>(arg0: T0, arg1: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg2: &mut Collection<T1>, arg3: address, arg4: u64, arg5: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>, arg6: &mut 0x2::tx_context::TxContext) {
        0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::assert_only_role_for_witness(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_access(arg1), 0x1::type_name::get<T0>(), 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"witness_mint_role"));
        assert_version<T1>(arg2);
        let v0 = &mut arg2.id;
        let v1 = borrow_mut_fixer(v0);
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::increase(v1, 1);
        let v2 = &mut arg2.id;
        0x49c4d10c2780cbcccb7e19e56a9b150958f465b375648e70c42222a34dfe95d9::nft::mint<T1>(borrow_mut_nft_version(v2), arg4, *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_name(v1), *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_description(v1), 0x2::url::new_unsafe(0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::to_url(*0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_image_url(v1), arg4)), *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_project_url(v1), *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_link(v1), arg5, arg3, arg6);
    }

    public fun modify_collection<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Collection<T0>, arg2: bool, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"collection_role"));
        assert_anyone_match_for_sender(arg0, v0, arg9);
        assert_version<T0>(arg1);
        0xab9edab4fccba0c1411f477aac6d5a82ddf2f3b53f99e7db439a3bade426b85f::bucket::assert_not_empty_bucket<0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Fixer>(&arg1.id);
        arg1.mystery_box = arg2;
        arg1.name = 0x1::string::utf8(arg3);
        arg1.description = 0x1::string::utf8(arg5);
        arg1.image_url = 0x2::url::new_unsafe_from_bytes(arg4);
        let v2 = &mut arg1.id;
        let v3 = borrow_mut_fixer(v2);
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::modify_fixer(v3, arg3, arg5, arg6, arg7, arg8);
        let v4 = ModifyCollectionEvent{
            collection  : 0x2::object::id<Collection<T0>>(arg1),
            fixer       : 0x2::object::id<0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::Fixer>(v3),
            mystery_box : arg1.mystery_box,
            nft_type    : 0x1::type_name::get<T0>(),
            name        : arg1.name,
            banner      : arg1.image_url,
            image_url   : 0x2::url::new_unsafe_from_bytes(arg6),
            description : arg1.description,
            project_url : 0x1::string::utf8(arg7),
            link        : 0x1::string::utf8(arg8),
        };
        0x2::event::emit<ModifyCollectionEvent>(v4);
    }

    public entry fun modify_phaser(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"phaser_role"));
        assert_anyone_match_for_sender(arg0, v0, arg8);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_total_supply(arg1, arg5);
        let v2 = Witness{dummy_field: false};
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::modify_phaser(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_mut_publisher<Witness, 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::PHASER>(&v2, arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun pay<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::deposit_with_amount<T0>(borrow_mut_wallet(arg0), arg2, arg1, arg3);
    }

    public entry fun payment_mint<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg2: &mut Collection<T1>, arg3: &mut 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version<T1>(arg2);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_collection_type<Collection<T1>>(arg3);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_coin_type<T0>(arg3);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_phaser_opened(arg3);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_payment_price(arg3);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_mint_timestamp(arg3, 0x2::clock::timestamp_ms(arg0));
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_phaser_mint_count(arg3, 0x2::tx_context::sender(arg6), arg4);
        let v0 = Witness{dummy_field: false};
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::increment(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_mut_publisher<Witness, 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::PHASER>(&v0, arg1), arg3, 0x2::tx_context::sender(arg6), arg4);
        let v1 = &mut arg2.id;
        let v2 = 0x2::tx_context::sender(arg6);
        mint<T1>(v1, arg2.mystery_box, v2, arg4, arg6);
        pay<T0>(arg1, total_amount(arg3, arg4), arg5, arg6);
    }

    public entry fun payment_whitelist_mint<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg2: &mut Collection<T1>, arg3: &mut 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: vector<address>, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version<T1>(arg2);
        assert_whitelist_mint_count(arg3, 0x2::tx_context::sender(arg8), arg4, arg6);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_coin_type<T0>(arg3);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_collection_type<Collection<T1>>(arg3);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_phaser_whitelist_opened(arg3);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_payment_price(arg3);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_mint_timestamp(arg3, 0x2::clock::timestamp_ms(arg0));
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_phaser_mint_count(arg3, 0x2::tx_context::sender(arg8), arg4);
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::assert_whitelist_merkle_root(arg3, 0x2::tx_context::sender(arg8), arg6, arg7);
        let v0 = Witness{dummy_field: false};
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::increment(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_mut_publisher<Witness, 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::PHASER>(&v0, arg1), arg3, 0x2::tx_context::sender(arg8), arg4);
        let v1 = &mut arg2.id;
        let v2 = 0x2::tx_context::sender(arg8);
        mint<T1>(v1, arg2.mystery_box, v2, arg4, arg8);
        pay<T0>(arg1, total_amount(arg3, arg4), arg5, arg8);
    }

    public entry fun remove_attribute<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Collection<T0>, arg2: bool, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"attribute_role"));
        assert_anyone_match_for_sender(arg0, v0, arg4);
        assert_version<T0>(arg1);
        let v2 = &mut arg1.id;
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::remove_attribute(borrow_mut_fixer(v2), arg2, arg3);
    }

    public entry fun remove_composition_from_collection<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Collection<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"composition_role"));
        assert_anyone_match_for_sender(arg0, v0, arg2);
        assert_version<T0>(arg1);
        0x2::transfer::public_transfer<0x76cbbe5427a01e2cd8548c158d333bb451d73eec74937abd65a2afa6dd8d2401::composition::Composition<T0>>(0x76cbbe5427a01e2cd8548c158d333bb451d73eec74937abd65a2afa6dd8d2401::composition::remove_composition<T0>(&mut arg1.id, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_fixer_whitelist<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Collection<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"whitelist_role"));
        assert_anyone_match_for_sender(arg0, v0, arg3);
        assert_version<T0>(arg1);
        let v2 = &mut arg1.id;
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::remove_whitelist(borrow_mut_fixer(v2), arg2);
    }

    public entry fun remove_phaser_whitelists(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"phaser_role"));
        assert_anyone_match_for_sender(arg0, v0, arg3);
        let v2 = Witness{dummy_field: false};
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::remove_phaser_whitelists(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_mut_publisher<Witness, 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::PHASER>(&v2, arg0), arg1, arg2);
    }

    public entry fun set_phaser_status(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"phaser_role"));
        assert_anyone_match_for_sender(arg0, v0, arg3);
        let v2 = Witness{dummy_field: false};
        0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::set_phaser_status(0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::borrow_mut_publisher<Witness, 0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::PHASER>(&v2, arg0), arg1, arg2);
    }

    public entry fun set_token_field<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: &mut Collection<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"attribute_role"));
        assert_anyone_match_for_sender(arg0, v0, arg3);
        assert_version<T0>(arg1);
        let v2 = &mut arg1.id;
        0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::set_token_field(borrow_mut_fixer(v2), arg2, arg3);
    }

    fun sum(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    fun total_amount(arg0: &0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::Phaser, arg1: u64) : u64 {
        *0x5968c3e1d952e1683f77b8557ed21254628b979c67897afcc2169db61940c660::phaser::borrow_price(arg0) * arg1
    }

    public fun total_supply<T0>(arg0: &Collection<T0>) : u64 {
        *0x71fd9c8f89450592bd3198bb4c902771fe6b984a2abc062ed2defe166452844c::fixer::borrow_supply(borrow_fixer(&arg0.id))
    }

    public fun version() : u64 {
        1
    }

    public entry fun withdraw<T0>(arg0: &mut 0xcee13a64a0344b8768313aea9faa59aafd0d80b356d3a29d77f51e229d3147b9::launchpad::Launchpad, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x82041ef7e60f0ce619e206637c8d63c0dd22461f51d57988bdfb6cae9672bd86::access::to_role(b"withdraw_role"));
        assert_anyone_match_for_sender(arg0, v0, arg3);
        0x60b0cbc2fc67ad6c86fd3e5d99a7e58e7458360c5a0657501fb47baea6f30460::wallet::withdraw<T0>(borrow_mut_wallet(arg0), arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

