module 0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3 {
    struct NFT<phantom T0> has store, key {
        id: 0x2::object::UID,
        index: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        properties: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct SharedPublisher has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct SOUFFL3 has drop {
        dummy_field: bool,
    }

    public fun burn<T0, T1: drop>(arg0: T1, arg1: NFT<T0>) {
        assert!(0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::utils::from_same_package<T0, T1>(), 1);
        let NFT {
            id         : v0,
            index      : _,
            name       : _,
            image_url  : _,
            properties : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun create_display<T0>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>, arg2: &SharedPublisher, arg3: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<NFT<T0>> {
        0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::utils::check_version(arg0);
        let v0 = 0x2::display::new<NFT<T0>>(&arg2.publisher, arg3);
        0x2::display::add<NFT<T0>>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFT<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<NFT<T0>>(&mut v0, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<NFT<T0>>(&mut v0);
        v0
    }

    public entry fun create_then_set_display_and_transfer_policy_then_royalty_rule<T0>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>, arg2: &SharedPublisher, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u16, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::utils::check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = create_display<T0>(arg0, arg1, arg2, arg7);
        0x2::display::add<NFT<T0>>(&mut v1, arg3, arg4);
        0x2::display::update_version<NFT<T0>>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<NFT<T0>>(&arg2.publisher, arg7);
        let v4 = v3;
        let v5 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<NFT<T0>>(&mut v5, &mut v4, arg5, arg6);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT<T0>>>(v5);
        0x2::transfer::public_transfer<0x2::display::Display<NFT<T0>>>(v1, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT<T0>>>(v4, v0);
    }

    public entry fun create_then_set_display_and_transfer_policy_then_royalty_rule_v1<T0>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>, arg2: &SharedPublisher, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: address, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u16, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::utils::check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = create_display<T0>(arg0, arg1, arg2, arg12);
        let v2 = &mut v1;
        set_collection_info<T0>(arg0, v2, arg3, arg4, arg5, arg6, arg7, arg12);
        0x2::display::add<NFT<T0>>(&mut v1, arg8, arg9);
        let (v3, v4) = 0x2::transfer_policy::new<NFT<T0>>(&arg2.publisher, arg12);
        let v5 = v4;
        let v6 = v3;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<NFT<T0>>(&mut v6, &mut v5, arg10, arg11);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT<T0>>>(v6);
        0x2::transfer::public_transfer<0x2::display::Display<NFT<T0>>>(v1, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT<T0>>>(v5, v0);
    }

    fun init(arg0: SOUFFL3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedPublisher{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<SOUFFL3>(arg0, arg1),
        };
        0x2::transfer::public_share_object<SharedPublisher>(v0);
    }

    public fun mint_nft_with_cap<T0>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) : NFT<T0> {
        0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::utils::check_version(arg0);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg5);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg6), 1);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v2 = 0;
        while (v2 < v0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::vector::pop_back<0x1::string::String>(&mut arg5), 0x1::vector::pop_back<0x1::string::String>(&mut arg6));
            v2 = v2 + 1;
        };
        NFT<T0>{
            id         : 0x2::object::new(arg7),
            index      : arg1,
            name       : arg2,
            image_url  : arg3,
            properties : v1,
        }
    }

    public fun mutate_name_and_image_url<T0, T1: drop>(arg0: T1, arg1: &mut NFT<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::utils::from_same_package<T0, T1>(), 2);
        arg1.name = arg2;
        arg1.image_url = arg3;
    }

    public fun new_version(arg0: &SharedPublisher, arg1: &mut 0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xff29c1854f97ddd25745959f692e5544f907cd974a3e249f0dabed21173acbed, 0);
        0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::add(publisher_borrow(arg0), arg1);
    }

    fun publisher_borrow(arg0: &SharedPublisher) : &0x2::package::Publisher {
        &arg0.publisher
    }

    public fun set_collection_info<T0>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut 0x2::display::Display<NFT<T0>>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::utils::check_version(arg0);
        0x2::display::add<NFT<T0>>(arg1, 0x1::string::utf8(b"collection_name"), arg2);
        0x2::display::add<NFT<T0>>(arg1, 0x1::string::utf8(b"collection_image"), arg3);
        0x2::display::add<NFT<T0>>(arg1, 0x1::string::utf8(b"symbol"), arg4);
        0x2::display::add<NFT<T0>>(arg1, 0x1::string::utf8(b"creator"), 0x2::address::to_string(arg6));
        0x2::display::add<NFT<T0>>(arg1, 0x1::string::utf8(b"description"), arg5);
        0x2::display::update_version<NFT<T0>>(arg1);
    }

    public fun set_version(arg0: &SharedPublisher, arg1: &mut 0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xff29c1854f97ddd25745959f692e5544f907cd974a3e249f0dabed21173acbed, 0);
        0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::set(publisher_borrow(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

