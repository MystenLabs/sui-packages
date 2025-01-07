module 0x838fe965ba2c11b940d7363f27b167823d18e34a05478d6e1fede45beeb52190::capybara_game_card {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasurerKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TreasurerCap has drop, store {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        checkin_fee: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        leagues: vector<0x1::string::String>,
        pk: vector<u8>,
        items: 0x2::table::Table<address, RegistryItem>,
        check_signature: bool,
    }

    struct RegistryItem has drop, store {
        id: 0x2::object::ID,
        nonce: u64,
    }

    struct NFTData has key {
        id: 0x2::object::UID,
        owner: address,
        league: 0x1::string::String,
        points: u64,
    }

    struct CheckinArgTBS has drop {
        nonce: u64,
        points: 0x1::option::Option<u64>,
        league: 0x1::option::Option<0x1::string::String>,
    }

    struct CapybaraNft has key {
        id: 0x2::object::UID,
    }

    struct NftAccessorie has store, key {
        id: 0x2::object::UID,
        type_field: u8,
    }

    struct CAPYBARA_GAME_CARD has drop {
        dummy_field: bool,
    }

    struct MintNFT has copy, drop {
        from: address,
        to: address,
        nft_id: 0x2::object::ID,
    }

    struct DailyCheckin has copy, drop {
        nft_id: 0x2::object::ID,
        new_points: 0x1::option::Option<u64>,
        new_league: 0x1::option::Option<0x1::string::String>,
    }

    struct SpentPoints has copy, drop {
        nft_id: 0x2::object::ID,
        amount: u64,
    }

    struct BurnNFT has copy, drop {
        nft_id: 0x2::object::ID,
    }

    struct UpdateFee has copy, drop {
        fee: u64,
    }

    struct UpdatePublicKey has copy, drop {
        pk: vector<u8>,
    }

    struct UpdateLeagues has copy, drop {
        leagues: vector<0x1::string::String>,
    }

    struct WithdrawAmount has copy, drop {
        amount: u64,
    }

    public entry fun burn(arg0: &mut Registry, arg1: NFTData) {
        assert!(1 == 1, 1);
        let NFTData {
            id     : v0,
            owner  : v1,
            league : _,
            points : _,
        } = arg1;
        let v4 = v0;
        0x2::table::remove<address, RegistryItem>(&mut arg0.items, v1);
        0x2::object::delete(v4);
        let v5 = BurnNFT{nft_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<BurnNFT>(v5);
    }

    public entry fun checkin(arg0: &mut NFTData, arg1: &mut Treasury, arg2: &mut Registry, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<0x1::string::String>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(1 == 1, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= arg1.checkin_fee, 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::split<0x2::sui::SUI>(arg3, arg1.checkin_fee, arg8));
        if (arg2.check_signature) {
            let v0 = serialize_checkin_args(arg4, arg5, arg6);
            assert!(0x2::ecdsa_k1::secp256k1_verify(&arg7, &arg2.pk, &v0, 1), 4);
            let v1 = 0x2::table::borrow_mut<address, RegistryItem>(&mut arg2.items, 0x2::tx_context::sender(arg8));
            assert!(v1.nonce == arg4, 5);
            v1.nonce = v1.nonce + 1;
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            arg0.points = *0x1::option::borrow<u64>(&arg5);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg6)) {
            let v2 = *0x1::option::borrow<0x1::string::String>(&arg6);
            assert!(0x1::vector::contains<0x1::string::String>(&arg2.leagues, &v2), 6);
            arg0.league = v2;
        };
        let v3 = DailyCheckin{
            nft_id     : 0x2::object::uid_to_inner(&mut arg0.id),
            new_points : arg5,
            new_league : arg6,
        };
        0x2::event::emit<DailyCheckin>(v3);
    }

    public fun get_user_checkin_nonce(arg0: &mut Registry, arg1: address) : u64 {
        0x2::table::borrow_mut<address, RegistryItem>(&mut arg0.items, arg1).nonce
    }

    public entry fun grant_treasurer_cap<T0>(arg0: &AdminCap, arg1: &mut Registry) {
        let v0 = TreasurerKey<T0>{dummy_field: false};
        let v1 = TreasurerCap{dummy_field: false};
        0x2::dynamic_field::add<TreasurerKey<T0>, TreasurerCap>(&mut arg1.id, v0, v1);
    }

    fun init(arg0: CAPYBARA_GAME_CARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = Treasury{
            id          : 0x2::object::new(arg1),
            version     : 1,
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            checkin_fee : 0,
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Starving"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Famished"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Hungry"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Full"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Nourished"));
        let v4 = Registry{
            id              : 0x2::object::new(arg1),
            version         : 1,
            leagues         : v2,
            pk              : x"035229dff81f3e3f5a1526b92908752395d96bf6b41cc253b2ad5bebe503149cf2",
            items           : 0x2::table::new<address, RegistryItem>(arg1),
            check_signature : false,
        };
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"league"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"points"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"thumbnail_url"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Player card"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"With {league} level and {points} points"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{league}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{points}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://capybara_static.8gen.team/{league}.png"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://capybara_static.8gen.team/{league}_preview.png"));
        let v9 = 0x2::package::claim<CAPYBARA_GAME_CARD>(arg0, arg1);
        let v10 = 0x2::display::new_with_fields<NFTData>(&v9, v5, v7, arg1);
        0x2::display::update_version<NFTData>(&mut v10);
        let v11 = 0x2::address::from_bytes(0x2::address::to_bytes(@0x3a1a0722453ff6da8a9695ef9588bd0ef57e60df8eee12f45cb792a170f179e1));
        0x2::transfer::public_transfer<AdminCap>(v0, v11);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v9, v11);
        0x2::transfer::public_transfer<0x2::display::Display<NFTData>>(v10, v11);
        0x2::transfer::share_object<Treasury>(v1);
        0x2::transfer::share_object<Registry>(v4);
    }

    public fun is_treasurer<T0>(arg0: &Registry) : bool {
        let v0 = TreasurerKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<TreasurerKey<T0>>(&arg0.id, v0)
    }

    public fun league(arg0: &NFTData) : 0x1::string::String {
        arg0.league
    }

    public entry fun mint(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(1 == 1, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, RegistryItem>(&arg0.items, arg1), 3);
        let v1 = new_nft(arg1, 0x1::string::utf8(b"Starving"), 0, arg2);
        let v2 = 0x2::object::id<NFTData>(&v1);
        let v3 = RegistryItem{
            id    : v2,
            nonce : 0,
        };
        0x2::table::add<address, RegistryItem>(&mut arg0.items, arg1, v3);
        let v4 = MintNFT{
            from   : v0,
            to     : arg1,
            nft_id : v2,
        };
        0x2::event::emit<MintNFT>(v4);
        0x2::transfer::transfer<NFTData>(v1, arg1);
    }

    fun new_nft(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : NFTData {
        NFTData{
            id     : 0x2::object::new(arg3),
            owner  : arg0,
            league : arg1,
            points : arg2,
        }
    }

    public fun owner(arg0: &NFTData) : address {
        arg0.owner
    }

    public fun points(arg0: &NFTData) : u64 {
        arg0.points
    }

    public entry fun revoke_treasurer_cap<T0>(arg0: &AdminCap, arg1: &mut Registry) {
        let v0 = TreasurerKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<TreasurerKey<T0>, TreasurerCap>(&mut arg1.id, v0);
    }

    public fun serialize_checkin_args(arg0: u64, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<0x1::string::String>) : vector<u8> {
        let v0 = CheckinArgTBS{
            nonce  : arg0,
            points : arg1,
            league : arg2,
        };
        0x1::bcs::to_bytes<CheckinArgTBS>(&v0)
    }

    public fun spend<T0: drop>(arg0: &mut Registry, arg1: &mut NFTData, arg2: u64) {
        assert!(is_treasurer<T0>(arg0), 2);
        let v0 = &mut arg1.owner;
        assert!(0x2::table::contains<address, RegistryItem>(&arg0.items, *v0), 2);
        let v1 = 0x2::table::borrow_mut<address, RegistryItem>(&mut arg0.items, *v0);
        v1.nonce = v1.nonce + 1;
        assert!(arg1.points >= arg2, 0);
        arg1.points = arg1.points - arg2;
        let v2 = SpentPoints{
            nft_id : 0x2::object::uid_to_inner(&mut arg1.id),
            amount : arg2,
        };
        0x2::event::emit<SpentPoints>(v2);
    }

    public entry fun update_check_sig(arg0: &mut Registry, arg1: &AdminCap, arg2: bool) {
        arg0.check_signature = arg2;
    }

    public entry fun update_checkin_fee(arg0: &mut Treasury, arg1: &AdminCap, arg2: u64) {
        let v0 = UpdateFee{fee: arg2};
        0x2::event::emit<UpdateFee>(v0);
        arg0.checkin_fee = arg2;
    }

    public entry fun update_leagues(arg0: &mut Registry, arg1: &AdminCap, arg2: vector<0x1::string::String>) {
        let v0 = UpdateLeagues{leagues: arg2};
        0x2::event::emit<UpdateLeagues>(v0);
        arg0.leagues = arg2;
    }

    public entry fun update_pk(arg0: &mut Registry, arg1: &AdminCap, arg2: vector<u8>) {
        let v0 = UpdatePublicKey{pk: arg2};
        0x2::event::emit<UpdatePublicKey>(v0);
        arg0.pk = arg2;
    }

    public entry fun withdraw(arg0: &mut Treasury, arg1: &AdminCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            let v1 = 0x1::option::destroy_some<u64>(arg2);
            assert!(v1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 0);
            v1
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
        };
        let v2 = WithdrawAmount{amount: v0};
        0x2::event::emit<WithdrawAmount>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

