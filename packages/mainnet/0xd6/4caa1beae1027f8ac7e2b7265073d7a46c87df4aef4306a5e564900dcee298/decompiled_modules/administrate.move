module 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::administrate {
    struct Launchpad<phantom T0> has store, key {
        id: 0x2::object::UID,
        mint_cap: NFTMintCap<T0>,
        collection_max: u64,
        reserve: u64,
        reserve_index: u64,
        mint_index: u64,
        warehouse: 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::Warehouse<T0>,
        paper: 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::computing_room::Maze,
    }

    struct NFTMintCap<phantom T0> has store {
        mint_type: u8,
        mint_cap: 0x1::option::Option<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>>,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun create_launchpad_with_mint_cap<T0>(arg0: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>, arg1: u64, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : AdminCap<T0> {
        let v0 = NFTMintCap<T0>{
            mint_type : 1,
            mint_cap  : 0x1::option::some<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>>(arg0),
        };
        let v1 = if (arg2 == 0) {
            0
        } else {
            1
        };
        let v2 = Launchpad<T0>{
            id             : 0x2::object::new(arg4),
            mint_cap       : v0,
            collection_max : arg1,
            reserve        : arg2,
            reserve_index  : v1,
            mint_index     : arg2 + 1,
            warehouse      : 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::create_warehouse<T0>(arg4),
            paper          : 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::computing_room::create_maze(arg3, arg1),
        };
        0x2::transfer::share_object<Launchpad<T0>>(v2);
        AdminCap<T0>{id: 0x2::object::new(arg4)}
    }

    entry fun create_launchpad_with_mint_cap_entry<T0>(arg0: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>, arg1: u64, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = create_launchpad_with_mint_cap<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<AdminCap<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun deposit_mint_cap<T0>(arg0: &mut Launchpad<T0>, arg1: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : AdminCap<T0> {
        0x1::option::fill<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>>(&mut arg0.mint_cap.mint_cap, arg1);
        AdminCap<T0>{id: 0x2::object::new(arg2)}
    }

    public entry fun filling_warehouse_by_admin<T0>(arg0: &mut Launchpad<T0>, arg1: vector<u64>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<vector<0x1::string::String>>, arg6: vector<vector<0x1::string::String>>, arg7: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::Permission, arg8: &mut 0x2::tx_context::TxContext) {
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::check_permission(arg7, 0x2::tx_context::sender(arg8));
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::add_token_info<T0>(&mut arg0.warehouse, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun filling_warehouse_by_creator<T0>(arg0: &AdminCap<T0>, arg1: &mut Launchpad<T0>, arg2: vector<u64>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<vector<0x1::string::String>>, arg7: vector<vector<0x1::string::String>>) {
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::add_token_info<T0>(&mut arg1.warehouse, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun get_remaining(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 == 0) {
            arg0 - arg3 - 1
        } else {
            arg0 - arg2 - 1 - arg3 - arg1 - 1
        }
    }

    public entry fun mint_reserve_by_admin<T0: key>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut Launchpad<T0>, arg2: u64, arg3: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::Permission, arg4: &mut 0x2::tx_context::TxContext) {
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::check_permission(arg3, 0x2::tx_context::sender(arg4));
        let v0 = arg1.reserve_index;
        let v1 = v0;
        assert!(v0 + arg2 - 1 <= arg1.reserve, 0);
        let v2 = 0;
        while (v2 < arg2) {
            let v3 = 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::computing_room::get_mint_index(&mut arg1.paper, get_remaining(arg1.collection_max, arg1.reserve, arg1.reserve_index, arg1.mint_index), v1, 0x2::tx_context::sender(arg4));
            let v4 = 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::borrow_nft_content_mut<T0>(&mut arg1.warehouse, v3);
            let v5 = &mut arg1.mint_cap;
            let v6 = mint_token<T0>(arg0, v3, v4, v5, arg4);
            0x2::transfer::public_transfer<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(v6, 0x2::tx_context::sender(arg4));
            0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::nft_mark_as_used(v4);
            v1 = v1 + 1;
            v2 = v2 + 1;
        };
        arg1.reserve_index = v1;
    }

    public entry fun mint_reserve_by_creator<T0: key>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &AdminCap<T0>, arg2: &mut Launchpad<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2.reserve_index;
        let v1 = v0;
        assert!(v0 + arg3 - 1 <= arg2.reserve, 0);
        let v2 = 0;
        while (v2 < arg3) {
            let v3 = 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::computing_room::get_mint_index(&mut arg2.paper, get_remaining(arg2.collection_max, arg2.reserve, arg2.reserve_index, arg2.mint_index), v1, 0x2::tx_context::sender(arg4));
            let v4 = 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::borrow_nft_content_mut<T0>(&mut arg2.warehouse, v3);
            let v5 = &mut arg2.mint_cap;
            let v6 = mint_token<T0>(arg0, v3, v4, v5, arg4);
            0x2::transfer::public_transfer<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(v6, 0x2::tx_context::sender(arg4));
            0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::nft_mark_as_used(v4);
            v1 = v1 + 1;
            v2 = v2 + 1;
        };
        arg2.reserve_index = v1;
    }

    fun mint_token<T0: key>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: u64, arg2: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::NFTContent, arg3: &mut NFTMintCap<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0> {
        assert!(arg3.mint_type < 2, 1);
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::workshop::mint_token_with_mint_cap<T0>(arg0, arg1, arg2, 0x1::option::borrow_mut<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>>(&mut arg3.mint_cap), arg4)
    }

    public fun post_sale_mint_by_admin<T0: key>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::Permission, arg2: &mut Launchpad<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : vector<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>> {
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::check_permission(arg1, 0x2::tx_context::sender(arg4));
        sale_mint<T0>(arg0, arg2, arg3, arg4)
    }

    public fun post_sale_mint_by_creator<T0: key>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &AdminCap<T0>, arg2: &mut Launchpad<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : vector<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>> {
        sale_mint<T0>(arg0, arg2, arg3, arg4)
    }

    public(friend) fun sale_mint<T0: key>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut Launchpad<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : vector<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>> {
        let v0 = arg1.mint_index;
        let v1 = v0;
        assert!(v0 + arg2 - 1 <= arg1.collection_max, 0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>();
        while (v2 < arg2) {
            let v4 = 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::computing_room::get_mint_index(&mut arg1.paper, get_remaining(arg1.collection_max, arg1.reserve, arg1.reserve_index, v1), v1, 0x2::tx_context::sender(arg3));
            let v5 = 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::borrow_nft_content_mut<T0>(&mut arg1.warehouse, v4);
            let v6 = &mut arg1.mint_cap;
            0x1::vector::push_back<0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::souffl3::NFT<T0>>(&mut v3, mint_token<T0>(arg0, v4, v5, v6, arg3));
            0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::warehouse::nft_mark_as_used(v5);
            v1 = v1 + 1;
            v2 = v2 + 1;
        };
        arg1.mint_index = v1;
        v3
    }

    public fun update_collection_max_by_admin<T0>(arg0: &0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::Permission, arg1: &mut Launchpad<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission::check_permission(arg0, 0x2::tx_context::sender(arg3));
        arg1.collection_max = arg2;
    }

    public fun withdraw_mint_cap<T0>(arg0: AdminCap<T0>, arg1: &mut Launchpad<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0> {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x1::option::extract<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>>(&mut arg1.mint_cap.mint_cap)
    }

    // decompiled from Move bytecode v6
}

