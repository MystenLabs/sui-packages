module 0xfbd3c37486d336aaba01aecc0c3a471f3ee8efefea5a9474d4b4b8c8bc9b9f5e::token_monster {
    struct TokenMonster has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        species: 0x1::string::String,
        attribute: 0x1::string::String,
        rarity: 0x1::string::String,
        token_number: u64,
        creator: address,
        minted_at: u64,
    }

    struct SupplyManager has key {
        id: 0x2::object::UID,
        minted_addresses: 0x2::table::Table<address, bool>,
        total_minted: u64,
        supply: vector<vector<u8>>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        creator: address,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        species: 0x1::string::String,
        attribute: 0x1::string::String,
        rarity: 0x1::string::String,
        token_number: u64,
    }

    public fun attribute(arg0: &TokenMonster) : &0x1::string::String {
        &arg0.attribute
    }

    public entry fun burn_nft(arg0: TokenMonster, arg1: &mut 0x2::tx_context::TxContext) {
        let TokenMonster {
            id           : v0,
            name         : _,
            description  : _,
            image_url    : _,
            species      : _,
            attribute    : _,
            rarity       : _,
            token_number : _,
            creator      : _,
            minted_at    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun creator(arg0: &TokenMonster) : address {
        arg0.creator
    }

    public fun description(arg0: &TokenMonster) : &0x1::string::String {
        &arg0.description
    }

    fun find_random_available_token(arg0: &mut SupplyManager, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : (u8, u8) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0;
        while (v1 < 3) {
            let v2 = 0;
            while (v2 < 10) {
                if (*0x1::vector::borrow<u8>(0x1::vector::borrow<vector<u8>>(&arg0.supply, v1), v2) > 0) {
                    let v3 = 0x1::vector::empty<u8>();
                    0x1::vector::push_back<u8>(&mut v3, (v1 as u8));
                    0x1::vector::push_back<u8>(&mut v3, (v2 as u8));
                    0x1::vector::push_back<vector<u8>>(&mut v0, v3);
                };
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        let v4 = 0x1::vector::length<vector<u8>>(&v0);
        assert!(v4 > 0, 3);
        let v5 = 0x2::random::new_generator(arg1, arg2);
        let v6 = 0x1::vector::borrow<vector<u8>>(&v0, 0x2::random::generate_u64_in_range(&mut v5, 0, v4 - 1));
        let v7 = *0x1::vector::borrow<u8>(v6, 0);
        let v8 = *0x1::vector::borrow<u8>(v6, 1);
        let v9 = 0x1::vector::borrow_mut<u8>(0x1::vector::borrow_mut<vector<u8>>(&mut arg0.supply, (v7 as u64)), (v8 as u64));
        *v9 = *v9 - 1;
        (v7, v8)
    }

    fun get_attribute_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Fire")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Water")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Electric")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Grass")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Earth")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Light")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Dark")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Dragon")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Cosmic")
        } else {
            0x1::string::utf8(b"Bug")
        }
    }

    fun get_attribute_name_lowercase(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"fire")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"water")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"electric")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"grass")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"earth")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"light")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"dark")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"dragon")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"cosmic")
        } else {
            0x1::string::utf8(b"bug")
        }
    }

    public fun get_creator(arg0: &SupplyManager) : address {
        arg0.creator
    }

    fun get_image_url(arg0: u8, arg1: u8) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"https://black-definite-snipe-125.mypinata.cloud/ipfs/bafybeia3ba47lxc7lteqcavuxe2g5gh6zqx7fnthhdd2nxqvbj5nohlilq/");
        0x1::string::append(&mut v0, get_species_name_lowercase(arg0));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, get_attribute_name_lowercase(arg1));
        0x1::string::append_utf8(&mut v0, b".png");
        v0
    }

    public fun get_mint_price() : u64 {
        100000000
    }

    fun get_rarity(arg0: u8) : 0x1::string::String {
        if (arg0 <= 4) {
            0x1::string::utf8(b"Common")
        } else if (arg0 <= 6) {
            0x1::string::utf8(b"Rare")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Epic")
        } else {
            0x1::string::utf8(b"Legendary")
        }
    }

    fun get_species_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Puppy")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Slime")
        } else {
            0x1::string::utf8(b"Magician")
        }
    }

    fun get_species_name_lowercase(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"puppy")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"slime")
        } else {
            0x1::string::utf8(b"magician")
        }
    }

    public fun get_treasury_balance(arg0: &SupplyManager) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun get_type_supply(arg0: &SupplyManager, arg1: u8, arg2: u8) : u8 {
        assert!(arg1 < 3, 2);
        assert!(arg2 < 10, 2);
        *0x1::vector::borrow<u8>(0x1::vector::borrow<vector<u8>>(&arg0.supply, (arg1 as u64)), (arg2 as u64))
    }

    public fun has_minted(arg0: &SupplyManager, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.minted_addresses, arg1)
    }

    public fun image_url(arg0: &TokenMonster) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0;
        while (v1 < 3) {
            let v2 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v2, 17);
            0x1::vector::push_back<u8>(&mut v2, 17);
            0x1::vector::push_back<u8>(&mut v2, 17);
            0x1::vector::push_back<u8>(&mut v2, 17);
            0x1::vector::push_back<u8>(&mut v2, 17);
            0x1::vector::push_back<u8>(&mut v2, 4);
            0x1::vector::push_back<u8>(&mut v2, 4);
            0x1::vector::push_back<u8>(&mut v2, 5);
            0x1::vector::push_back<u8>(&mut v2, 1);
            0x1::vector::push_back<u8>(&mut v2, 1);
            0x1::vector::push_back<vector<u8>>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = SupplyManager{
            id               : 0x2::object::new(arg0),
            minted_addresses : 0x2::table::new<address, bool>(arg0),
            total_minted     : 0,
            supply           : v0,
            treasury         : 0x2::balance::zero<0x2::sui::SUI>(),
            creator          : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<SupplyManager>(v3);
    }

    public entry fun mint_token_monster(arg0: &mut SupplyManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 100000000, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        assert!(!0x2::table::contains<address, bool>(&arg0.minted_addresses, v0), 0);
        assert!(arg0.total_minted < 300, 1);
        let (v1, v2) = find_random_available_token(arg0, arg2, arg4);
        let v3 = arg0.total_minted + 1;
        let v4 = get_species_name(v1);
        let v5 = get_attribute_name(v2);
        let v6 = get_rarity(v2);
        let v7 = get_image_url(v1, v2);
        let v8 = 0x1::string::utf8(b"Token Monster #");
        0x1::string::append(&mut v8, u64_to_string(v3));
        let v9 = 0x1::string::utf8(b"[");
        0x1::string::append(&mut v9, v6);
        0x1::string::append_utf8(&mut v9, b"] ");
        0x1::string::append(&mut v9, v5);
        0x1::string::append_utf8(&mut v9, b" ");
        0x1::string::append(&mut v9, v4);
        0x1::string::append_utf8(&mut v9, b" of Token Monster");
        let v10 = TokenMonster{
            id           : 0x2::object::new(arg4),
            name         : v8,
            description  : v9,
            image_url    : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v7)),
            species      : v4,
            attribute    : v5,
            rarity       : v6,
            token_number : v3,
            creator      : v0,
            minted_at    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<address, bool>(&mut arg0.minted_addresses, v0, true);
        arg0.total_minted = arg0.total_minted + 1;
        let v11 = NFTMinted{
            object_id    : 0x2::object::id<TokenMonster>(&v10),
            creator      : v0,
            name         : v10.name,
            species      : v10.species,
            attribute    : v10.attribute,
            rarity       : v10.rarity,
            token_number : v3,
        };
        0x2::event::emit<NFTMinted>(v11);
        0x2::transfer::public_transfer<TokenMonster>(v10, v0);
        if (arg0.total_minted == 300) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.treasury), arg4), arg0.creator);
        };
    }

    public fun minted_at(arg0: &TokenMonster) : u64 {
        arg0.minted_at
    }

    public fun name(arg0: &TokenMonster) : &0x1::string::String {
        &arg0.name
    }

    public fun rarity(arg0: &TokenMonster) : &0x1::string::String {
        &arg0.rarity
    }

    public fun remaining_supply(arg0: &SupplyManager) : u64 {
        300 - arg0.total_minted
    }

    public fun species(arg0: &TokenMonster) : &0x1::string::String {
        &arg0.species
    }

    public fun token_number(arg0: &TokenMonster) : u64 {
        arg0.token_number
    }

    public fun total_minted(arg0: &SupplyManager) : u64 {
        arg0.total_minted
    }

    public entry fun transfer_nft(arg0: TokenMonster, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<TokenMonster>(arg0, arg1);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

