module 0xb596c32f94e20cfbe01077940257d0800b0506756808650815632c4172cade29::whalepunk_nft {
    struct MinterData has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        collection_name: 0x1::string::String,
        collection_description: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        next_token_id: u64,
        current_round_index: u64,
        rounds: 0x2::vec_map::VecMap<u64, Round>,
    }

    struct Round has store {
        price_mint: u64,
        start_time: u64,
        end_time: u64,
        whitelist: vector<address>,
        whitelist_minted: vector<address>,
    }

    struct InfoNFT has store {
        tier: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct WhalepunkNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
        created_at: u64,
    }

    struct MintNFTEvent has copy, drop {
        id: 0x2::object::ID,
        buyer: address,
        id_nft: 0x2::object::ID,
        name_nft: 0x1::string::String,
    }

    struct WHALEPUNK_NFT has drop {
        dummy_field: bool,
    }

    public entry fun add_whitelist(arg0: &mut MinterData, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xbdd4d4021977b2e0d7c7047d9c0f3137b1148ef147b7e7c79a570b2fba111d68 || 0x2::tx_context::sender(arg2) == arg0.owner, 3);
        let v0 = 0x2::vec_map::get_mut<u64, Round>(&mut arg0.rounds, &arg0.current_round_index);
        let v1 = 0;
        loop {
            0x1::vector::push_back<address>(&mut v0.whitelist, *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
            if (v1 >= 0x1::vector::length<address>(&arg1)) {
                break
            };
        };
    }

    public entry fun burn(arg0: WhalepunkNft, arg1: &mut 0x2::tx_context::TxContext) {
        let WhalepunkNft {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            project_url : _,
            created_at  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun config_price_mint(arg0: &mut MinterData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xbdd4d4021977b2e0d7c7047d9c0f3137b1148ef147b7e7c79a570b2fba111d68 || 0x2::tx_context::sender(arg2) == arg0.owner, 3);
        0x2::vec_map::get_mut<u64, Round>(&mut arg0.rounds, &arg0.current_round_index).price_mint = arg1;
    }

    public entry fun deposit(arg0: &mut MinterData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xbdd4d4021977b2e0d7c7047d9c0f3137b1148ef147b7e7c79a570b2fba111d68 || 0x2::tx_context::sender(arg3) == arg0.owner, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(give_change(arg1, arg2, arg3)));
    }

    public entry fun free_mint(arg0: &mut MinterData, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::vec_map::get_mut<u64, Round>(&mut arg0.rounds, &arg0.current_round_index);
        assert!(0x2::clock::timestamp_ms(arg1) >= v1.start_time, 6);
        assert!(0x2::clock::timestamp_ms(arg1) <= v1.end_time, 7);
        assert!(0x1::vector::contains<address>(&v1.whitelist, &v0), 2);
        assert!(!0x1::vector::contains<address>(&v1.whitelist_minted, &v0), 8);
        let v2 = arg0.collection_name;
        0x1::string::append(&mut v2, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v2, num_str(arg0.next_token_id));
        let v3 = WhalepunkNft{
            id          : 0x2::object::new(arg2),
            name        : v2,
            description : arg0.collection_description,
            image_url   : 0x2::url::new_unsafe(0x1::string::to_ascii(arg0.image_url)),
            project_url : 0x2::url::new_unsafe(0x1::string::to_ascii(arg0.project_url)),
            created_at  : 0x2::clock::timestamp_ms(arg1),
        };
        let v4 = MintNFTEvent{
            id       : 0x2::object::uid_to_inner(&v3.id),
            buyer    : 0x2::tx_context::sender(arg2),
            id_nft   : 0x2::object::uid_to_inner(&v3.id),
            name_nft : v2,
        };
        0x2::event::emit<MintNFTEvent>(v4);
        0x2::transfer::public_transfer<WhalepunkNft>(v3, v0);
        0x1::vector::push_back<address>(&mut v1.whitelist_minted, v0);
        arg0.next_token_id = arg0.next_token_id + 1;
    }

    public fun get_time_current_round(arg0: &MinterData) : (u64, u64) {
        let v0 = 0x2::vec_map::get<u64, Round>(&arg0.rounds, &arg0.current_round_index);
        (v0.start_time, v0.end_time)
    }

    fun give_change(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 1);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1) {
            return arg0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg2)
    }

    fun init(arg0: WHALEPUNK_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        let v4 = 0x2::package::claim<WHALEPUNK_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<WhalepunkNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<WhalepunkNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WhalepunkNft>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Round{
            price_mint       : 8000000000,
            start_time       : 1684767600000,
            end_time         : 1685286000000,
            whitelist        : 0x1::vector::empty<address>(),
            whitelist_minted : 0x1::vector::empty<address>(),
        };
        let v7 = MinterData{
            id                     : 0x2::object::new(arg1),
            owner                  : 0x2::tx_context::sender(arg1),
            balance                : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::zero<0x2::sui::SUI>(arg1)),
            collection_name        : 0x1::string::utf8(b"WhalePunk Atlantic Myth"),
            collection_description : 0x1::string::utf8(x"4173206120706563756c696172206469676974616c20636f6c6c65637469626c652c205768616c6550756e6b2041746c616e746963204d797468204e46542064656c69766572732061206c696d697465642065646974696f6e20657870657269656e63652c206665617475726573207370656369616c206162696c69746965732c20616e64206973206f6e6c7920617661696c61626c6520666f722061206c696d697465642074696d652e0a4f776e657273206f662074686973204e46542068617665206578636c75736976652061636365737320746f20746865207265776172647320616e642062656e656669747320617272617920617661696c61626c652077697468696e20746865205768616c6550756e6b2065636f73797374656d2e20546865736520616476616e746167657320696e636c756465206265636f6d696e6720656c696769626c6520666f722061697264726f70732c206a6f696e696e672057504b2046692070726f746f636f6c732c20696d6d657273696f6e20696e20746865206361707469766174696e67205768616c6550756e6b2047616d65466920766572736520616e64207072697661746520636f6d6d756e69746965732c20616e6420746865206f70706f7274756e69747920746f20756e6c6f636b2065787472616f7264696e617279206162696c6974696573207468726f756768204d79746820467573696f6e2e0a546865205768616c6550756e6b2041746c616e746963204d797468204e46542773206d696e74696e672063686172676520736572766573206475616c20707572706f7365732e2046697273746c792c2069742068656c70732065737461626c6973682074726164696e67206c69717569646974792c2070726573657276696e6720612076696272616e74206d61726b6574706c61636520666f722062757965727320616e642073656c6c6572732e20496e206164646974696f6e2c206974207265776172647320616c6c205768616c6550756e6b204e465420686f6c646572732c206675727468657220656e68616e63696e67207468652065636f73797374656d27732076616c75652070726f706f736974696f6e2e"),
            image_url              : 0x1::string::utf8(b"https://ipfs.io/ipfs/QmYHByaz91UFcWy8obXUo7k3cg65WtCoYzDBy2tAA9YkE3/"),
            project_url            : 0x1::string::utf8(b"https://whalepunk.xyz/"),
            next_token_id          : 1,
            current_round_index    : 1,
            rounds                 : 0x2::vec_map::empty<u64, Round>(),
        };
        0x2::vec_map::insert<u64, Round>(&mut v7.rounds, v7.current_round_index, v6);
        0x2::transfer::share_object<MinterData>(v7);
    }

    public fun is_whitelist_and_minted(arg0: &MinterData, arg1: address) : (bool, bool) {
        let v0 = 0x2::vec_map::get<u64, Round>(&arg0.rounds, &arg0.current_round_index);
        (0x1::vector::contains<address>(&v0.whitelist, &arg1), 0x1::vector::contains<address>(&v0.whitelist_minted, &arg1))
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun paid_mint(arg0: &mut MinterData, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::vec_map::get_mut<u64, Round>(&mut arg0.rounds, &arg0.current_round_index);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1.start_time, 6);
        assert!(0x2::clock::timestamp_ms(arg2) <= v1.end_time, 7);
        let v2 = give_change(arg3, v1.price_mint * arg1, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, @0xbdd4d4021977b2e0d7c7047d9c0f3137b1148ef147b7e7c79a570b2fba111d68);
        let v3 = 0;
        loop {
            let v4 = arg0.collection_name;
            0x1::string::append(&mut v4, 0x1::string::utf8(b" #"));
            0x1::string::append(&mut v4, num_str(arg0.next_token_id));
            let v5 = WhalepunkNft{
                id          : 0x2::object::new(arg4),
                name        : v4,
                description : arg0.collection_description,
                image_url   : 0x2::url::new_unsafe(0x1::string::to_ascii(arg0.image_url)),
                project_url : 0x2::url::new_unsafe(0x1::string::to_ascii(arg0.project_url)),
                created_at  : 0x2::clock::timestamp_ms(arg2),
            };
            let v6 = MintNFTEvent{
                id       : 0x2::object::uid_to_inner(&v5.id),
                buyer    : 0x2::tx_context::sender(arg4),
                id_nft   : 0x2::object::uid_to_inner(&v5.id),
                name_nft : v4,
            };
            0x2::event::emit<MintNFTEvent>(v6);
            0x2::transfer::public_transfer<WhalepunkNft>(v5, v0);
            arg0.next_token_id = arg0.next_token_id + 1;
            v3 = v3 + 1;
            if (v3 >= arg1) {
                break
            };
        };
    }

    public entry fun setup_time_round(arg0: &mut MinterData, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xbdd4d4021977b2e0d7c7047d9c0f3137b1148ef147b7e7c79a570b2fba111d68 || 0x2::tx_context::sender(arg3) == arg0.owner, 3);
        let v0 = 0x2::vec_map::get_mut<u64, Round>(&mut arg0.rounds, &arg0.current_round_index);
        v0.start_time = arg1;
        v0.end_time = arg2;
    }

    public entry fun start_next_round(arg0: &mut MinterData, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0xbdd4d4021977b2e0d7c7047d9c0f3137b1148ef147b7e7c79a570b2fba111d68 || 0x2::tx_context::sender(arg4) == arg0.owner, 3);
        arg0.current_round_index = arg0.current_round_index + 1;
        let v0 = Round{
            price_mint       : arg1,
            start_time       : arg2,
            end_time         : arg3,
            whitelist        : 0x1::vector::empty<address>(),
            whitelist_minted : 0x1::vector::empty<address>(),
        };
        0x2::vec_map::insert<u64, Round>(&mut arg0.rounds, arg0.current_round_index, v0);
    }

    public entry fun withdraw(arg0: &mut MinterData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xbdd4d4021977b2e0d7c7047d9c0f3137b1148ef147b7e7c79a570b2fba111d68 || 0x2::tx_context::sender(arg2) == arg0.owner, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

