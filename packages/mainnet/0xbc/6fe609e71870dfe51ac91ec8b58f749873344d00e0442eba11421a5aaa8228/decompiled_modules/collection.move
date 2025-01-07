module 0xbc6fe609e71870dfe51ac91ec8b58f749873344d00e0442eba11421a5aaa8228::collection {
    struct HMS has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        properties: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    public fun burn_by_creator(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<HMS>, arg1: 0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<HMS>) {
        assert!(false, 0);
        let v0 = Witness{dummy_field: false};
        0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::burn<HMS, Witness>(v0, arg1);
    }

    public fun burn_by_owner(arg0: 0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<HMS>) {
        assert!(false, 0);
        let v0 = Witness{dummy_field: false};
        0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::burn<HMS, Witness>(v0, arg0);
    }

    public fun create_collection_display(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::SharedPublisher, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<HMS>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<HMS>> {
        0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::create_display<HMS>(arg0, arg2, arg1, arg3)
    }

    public entry fun create_collection_display_entry(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::SharedPublisher, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<HMS>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_collection_display(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::display::Display<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<HMS>>>(v0, 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<COLLECTION, HMS>(&arg0, 0x1::option::none<u64>(), arg1);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<HMS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<HMS>>(v0);
    }

    public fun mutate_name_image_by_creator(arg0: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<HMS>, arg1: &mut 0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<HMS>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(false, 1);
        let v0 = Witness{dummy_field: false};
        0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::mutate_name_and_image_url<HMS, Witness>(v0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

