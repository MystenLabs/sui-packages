module 0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::gop {
    struct GOPNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        user_detials: 0x2::vec_map::VecMap<0x2::object::ID, Attributes>,
        count: 0x2::vec_map::VecMap<address, u64>,
    }

    struct Attributes has copy, drop, store {
        claimed: bool,
        airdrop: bool,
        ieo: bool,
    }

    struct BuyInfo<phantom T0> has key {
        id: 0x2::object::UID,
        price: u64,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct BuyInfoCreated has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        price: u64,
    }

    struct BuyGop has copy, drop {
        user: address,
        fees_paid: u64,
        number_of_token_mint: u64,
    }

    struct WithdrawFees has copy, drop {
        buy_info_id: 0x2::object::ID,
        owner: address,
        value: u64,
    }

    struct GOP has drop {
        dummy_field: bool,
    }

    public fun id(arg0: &GOPNFT) : 0x2::object::ID {
        0x2::object::id<GOPNFT>(arg0)
    }

    public fun url(arg0: &GOPNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun update_attribute(arg0: &AdminCap, arg1: &mut NFTInfo, arg2: 0x2::object::ID, arg3: bool, arg4: bool, arg5: bool) {
        let v0 = Attributes{
            claimed : arg3,
            airdrop : arg4,
            ieo     : arg5,
        };
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::update_attribute<0x2::object::ID, Attributes>(&mut arg1.user_detials, arg2, v0);
    }

    public fun airdrop(arg0: &GOPNFT, arg1: &NFTInfo) : bool {
        let v0 = 0x2::object::id<GOPNFT>(arg0);
        0x2::vec_map::get<0x2::object::ID, Attributes>(&arg1.user_detials, &v0).airdrop
    }

    public fun attributes(arg0: &GOPNFT, arg1: &NFTInfo) : Attributes {
        let v0 = 0x2::object::id<GOPNFT>(arg0);
        *0x2::vec_map::get<0x2::object::ID, Attributes>(&arg1.user_detials, &v0)
    }

    public fun balance_of_buy_info<T0>(arg0: &BuyInfo<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun burn(arg0: GOPNFT, arg1: &mut NFTInfo, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<GOPNFT>(&arg0);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, Attributes>(&mut arg1.user_detials, &v0);
        let GOPNFT {
            id   : v3,
            name : _,
            url  : _,
        } = arg0;
        0x2::object::delete(v3);
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::emit_burn_nft<GOPNFT>(v0);
    }

    entry fun buy_gop<T0>(arg0: &mut BuyInfo<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut NFTInfo, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 % arg0.price == 0, 2);
        let v1 = v0 / arg0.price;
        check_mint_limit(arg2, 0x2::tx_context::sender(arg4), v1);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x2::tx_context::sender(arg4);
            mint_nft(arg2, v3, arg3, arg4);
            v2 = v2 + 1;
        };
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        let v4 = BuyGop{
            user                 : 0x2::tx_context::sender(arg4),
            fees_paid            : v0,
            number_of_token_mint : v1,
        };
        0x2::event::emit<BuyGop>(v4);
    }

    fun check_mint_limit(arg0: &mut NFTInfo, arg1: address, arg2: u64) {
        if (0x2::vec_map::contains<address, u64>(&arg0.count, &arg1)) {
            assert!(*0x2::vec_map::get<address, u64>(&arg0.count, &arg1) + arg2 <= 50, 1);
            let v0 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.count, &arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.count, arg1, arg2);
        };
    }

    public fun claimed(arg0: &GOPNFT, arg1: &NFTInfo) : bool {
        let v0 = 0x2::object::id<GOPNFT>(arg0);
        0x2::vec_map::get<0x2::object::ID, Attributes>(&arg1.user_detials, &v0).claimed
    }

    public fun fees_owner<T0>(arg0: &BuyInfo<T0>) : address {
        arg0.owner
    }

    public fun ieo(arg0: &GOPNFT, arg1: &NFTInfo) : bool {
        let v0 = 0x2::object::id<GOPNFT>(arg0);
        0x2::vec_map::get<0x2::object::ID, Attributes>(&arg1.user_detials, &v0).ieo
    }

    fun init(arg0: GOP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Artfi"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Artfi NFT"));
        let v4 = 0x2::package::claim<GOP>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GOPNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<GOPNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GOPNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = NFTInfo{
            id           : 0x2::object::new(arg1),
            name         : 0x1::string::utf8(b"Artfi"),
            user_detials : 0x2::vec_map::empty<0x2::object::ID, Attributes>(),
            count        : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<NFTInfo>(v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun init_buy_info<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BuyInfo<T0>{
            id      : 0x2::object::new(arg2),
            price   : arg1,
            owner   : 0x2::tx_context::sender(arg2),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<BuyInfo<T0>>(v0);
        let v1 = BuyInfoCreated{
            id    : 0x2::object::id<BuyInfo<T0>>(&v0),
            owner : 0x2::tx_context::sender(arg2),
            price : arg1,
        };
        0x2::event::emit<BuyInfoCreated>(v1);
    }

    fun mint_func(arg0: &mut NFTInfo, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = GOPNFT{
            id   : 0x2::object::new(arg3),
            name : arg0.name,
            url  : 0x2::url::new_unsafe_from_bytes(arg1),
        };
        let v1 = 0x2::object::id<GOPNFT>(&v0);
        let v2 = Attributes{
            claimed : false,
            airdrop : false,
            ieo     : false,
        };
        0x2::vec_map::insert<0x2::object::ID, Attributes>(&mut arg0.user_detials, v1, v2);
        0x2::transfer::public_transfer<GOPNFT>(v0, arg2);
        v1
    }

    fun mint_nft(arg0: &mut NFTInfo, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_func(arg0, arg2, arg1, arg3);
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::emit_mint_nft(v0, 0x2::tx_context::sender(arg3), arg0.name);
    }

    public fun mint_nft_batch(arg0: &AdminCap, arg1: &mut NFTInfo, arg2: &vector<vector<u8>>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(arg2);
        check_mint_limit(arg1, arg3, v0);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = mint_func(arg1, *0x1::vector::borrow<vector<u8>>(arg2, v2), arg3, arg4);
            v2 = v2 + 1;
            0x1::vector::push_back<0x2::object::ID>(&mut v1, v3);
        };
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::emit_batch_mint_nft(v1, v0, 0x2::tx_context::sender(arg4), arg1.name);
    }

    public fun name(arg0: &GOPNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun nft_mint_count(arg0: &NFTInfo, arg1: address) : u64 {
        *0x2::vec_map::get<address, u64>(&arg0.count, &arg1)
    }

    public fun price<T0>(arg0: &BuyInfo<T0>) : u64 {
        arg0.price
    }

    public entry fun take_fees<T0>(arg0: &mut BuyInfo<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v0, arg1), arg0.owner);
        let v1 = WithdrawFees{
            buy_info_id : 0x2::object::id<BuyInfo<T0>>(arg0),
            owner       : arg0.owner,
            value       : v0,
        };
        0x2::event::emit<WithdrawFees>(v1);
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::emit_transfer_object<AdminCap>(0x2::object::id<AdminCap>(&arg0), arg1);
    }

    public entry fun transfer_nft(arg0: GOPNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<GOPNFT>(arg0, arg1);
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::emit_transfer_object<GOPNFT>(0x2::object::id<GOPNFT>(&arg0), arg1);
    }

    public entry fun update_buy_info_owner<T0>(arg0: &AdminCap, arg1: &mut BuyInfo<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        arg1.owner = arg2;
    }

    public entry fun update_buy_info_price<T0>(arg0: &AdminCap, arg1: &mut BuyInfo<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg1.price = arg2;
    }

    public fun update_metadata(arg0: &AdminCap, arg1: &mut 0x2::display::Display<GOPNFT>, arg2: &mut NFTInfo, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        0x2::display::edit<GOPNFT>(arg1, 0x1::string::utf8(b"name"), arg4);
        0x2::display::edit<GOPNFT>(arg1, 0x1::string::utf8(b"description"), arg3);
        arg2.name = arg4;
        0x2::display::update_version<GOPNFT>(arg1);
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::emit_metadat_update(arg4, arg3);
    }

    // decompiled from Move bytecode v6
}

