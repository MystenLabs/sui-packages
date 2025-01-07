module 0x8a1b7bf27a88e36602c373536a18c8bf2dde3633d91f5a070aa4b460e55e4868::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    struct SuiCat has store, key {
        id: 0x2::object::UID,
        index: u16,
        name: 0x1::string::String,
    }

    struct Vault has store {
        indexes: vector<u16>,
    }

    struct Global has key {
        id: 0x2::object::UID,
        creator: address,
        start_time: u64,
        supply: u16,
        team_reserve: u16,
        duration: u64,
        whitelist: 0x2::table::Table<address, bool>,
        team_vault: Vault,
        mint_vault: Vault,
        price_whitelist: u64,
        price_public: u64,
        minted_whitelist: u16,
        minted_public: u16,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        beneficiary: address,
    }

    fun bytes_to_u64(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u64) << ((8 * (7 - v1)) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    fun charge(arg0: &mut Global, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) >= arg2, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, arg2, arg3)));
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
    }

    public fun generate_name(arg0: u16) : 0x1::string::String {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, b"SuiCat#");
        0x1::vector::append<u8>(&mut v0, u16_to_decimal_string(arg0));
        0x1::string::utf8(v0)
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The DMENS NFT-Pass program has been launched to encourage community participation, contribution, and development by attracting more partners and expanding the community."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://dmens.coming.chat"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmUXzrqtqt5oahp1VBc8Jh5s4hts3tv7fuVxHEmjjmzTvP/dmens-cat.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://dmens.coming.chat"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ComingChat"));
        let v4 = 0x2::package::claim<SUICAT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuiCat>(&v4, v0, v2, arg1);
        0x2::display::update_version<SuiCat>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiCat>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Vault{indexes: 0x1::vector::empty<u16>()};
        let v7 = Vault{indexes: 0x1::vector::empty<u16>()};
        let v8 = Global{
            id               : 0x2::object::new(arg1),
            creator          : 0x2::tx_context::sender(arg1),
            start_time       : 1683637200000,
            supply           : 10000,
            team_reserve     : 3000,
            duration         : 259200000,
            whitelist        : 0x2::table::new<address, bool>(arg1),
            team_vault       : v6,
            mint_vault       : v7,
            price_whitelist  : 256000000000,
            price_public     : 1000000000000,
            minted_whitelist : 0,
            minted_public    : 0,
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            beneficiary      : @0x2c5476da42075b81416c8587d872e5952df2c784a0b1d9fd879abdb3881cac78,
        };
        let v9 = v8.team_reserve + 1;
        let v10 = 1;
        while (v10 <= v8.team_reserve) {
            0x1::vector::push_back<u16>(&mut v8.team_vault.indexes, v10);
            v10 = v10 + 1;
        };
        while (v9 <= v8.supply) {
            0x1::vector::push_back<u16>(&mut v8.mint_vault.indexes, v9);
            v9 = v9 + 1;
        };
        0x2::transfer::share_object<Global>(v8);
    }

    public fun is_in_whitelist(arg0: &Global, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    public entry fun mint(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = remain(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        assert!(v2 >= arg0.start_time, 2);
        let (v3, v4) = prices(arg0);
        if (v2 < arg0.start_time + arg0.duration) {
            assert!(0x2::table::contains<address, bool>(&arg0.whitelist, v0), 4);
            let v5 = select_nft(arg0, v1, arg3);
            charge(arg0, arg2, v3, arg3);
            0x2::transfer::public_transfer<SuiCat>(v5, v0);
            arg0.minted_whitelist = arg0.minted_whitelist + 1;
        } else {
            let v6 = select_nft(arg0, v1, arg3);
            charge(arg0, arg2, v4, arg3);
            0x2::transfer::public_transfer<SuiCat>(v6, v0);
            arg0.minted_public = arg0.minted_public + 1;
        };
    }

    public entry fun mint_reserve(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0x2::math::min(arg1, 0x1::vector::length<u16>(&arg0.team_vault.indexes));
        while (v0 > 0) {
            let v1 = 0x1::vector::pop_back<u16>(&mut arg0.team_vault.indexes);
            let v2 = SuiCat{
                id    : 0x2::object::new(arg2),
                index : v1,
                name  : generate_name(v1),
            };
            0x2::transfer::public_transfer<SuiCat>(v2, arg0.beneficiary);
            v0 = v0 - 1;
        };
    }

    public fun minted_count(arg0: &Global) : (u16, u16) {
        (arg0.minted_whitelist, arg0.minted_public)
    }

    public fun prices(arg0: &Global) : (u64, u64) {
        (arg0.price_whitelist, arg0.price_public)
    }

    public fun remain(arg0: &Global) : u64 {
        0x1::vector::length<u16>(&arg0.mint_vault.indexes)
    }

    fun seed(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::tx_context::TxContext>(arg0));
        0x1::vector::append<u8>(&mut v1, 0x2::object::uid_to_bytes(&v0));
        0x2::hash::keccak256(&v1)
    }

    fun select_nft(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SuiCat {
        assert!(arg1 > 0, 3);
        let v0 = seed(arg2);
        let v1 = 0x1::vector::swap_remove<u16>(&mut arg0.mint_vault.indexes, bytes_to_u64(v0) % arg1);
        SuiCat{
            id    : 0x2::object::new(arg2),
            index : v1,
            name  : generate_name(v1),
        }
    }

    public entry fun set_prices(arg0: &mut Global, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 1);
        arg0.price_whitelist = arg1;
        arg0.price_public = arg2;
    }

    public entry fun set_start_time(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.start_time = arg1;
    }

    public entry fun set_whitelist(arg0: &mut Global, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x2::table::add<address, bool>(&mut arg0.whitelist, 0x1::vector::pop_back<address>(&mut arg1), true);
            v0 = v0 + 1;
        };
    }

    public fun supply(arg0: &Global) : u16 {
        arg0.supply
    }

    public fun time(arg0: &Global) : (u64, u64) {
        (arg0.start_time, arg0.duration)
    }

    fun u16_to_decimal_string(arg0: u16) : vector<u8> {
        let v0 = b"";
        loop {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
            if (arg0 <= 0) {
                break
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun withdraw(arg0: &mut Global, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.beneficiary == v0 || arg0.creator == v0, 1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v1), arg1), arg0.beneficiary);
    }

    // decompiled from Move bytecode v6
}

