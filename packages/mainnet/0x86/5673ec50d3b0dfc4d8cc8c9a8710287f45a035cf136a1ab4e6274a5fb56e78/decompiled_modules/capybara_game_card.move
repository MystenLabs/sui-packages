module 0x99a1800ce832f92814fac7f0b5ed1e98317a33d5325b2498d6c62356b08a39f4::capybara_game_card {
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
        leagues: vector<u64>,
        pk: vector<u8>,
        items: 0x2::table::Table<address, RegistryItem>,
        check_signature: bool,
    }

    struct RegistryItem has drop, store {
        id: 0x2::object::ID,
    }

    struct NFTData has key {
        id: 0x2::object::UID,
        owner: address,
        league: u64,
        points: u64,
    }

    struct CheckinArgTBS has drop {
        valid_until: u64,
        points: 0x1::option::Option<u64>,
        league: 0x1::option::Option<u64>,
        user: 0x1::string::String,
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
        points: u64,
        league: u64,
        nft_id: 0x2::object::ID,
    }

    struct DailyCheckin has copy, drop {
        nft_id: 0x2::object::ID,
        new_points: 0x1::option::Option<u64>,
        new_league: 0x1::option::Option<u64>,
        fee: u64,
    }

    struct UserEvt has copy, drop {
        user: 0x1::string::String,
        signature: vector<u8>,
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
        leagues: vector<u64>,
    }

    struct WithdrawAmount has copy, drop {
        amount: u64,
    }

    public entry fun burn(arg0: &mut Registry, arg1: NFTData) {
        assert!(2 == arg0.version, 1);
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

    public entry fun checkin(arg0: &mut NFTData, arg1: &mut Treasury, arg2: &mut Registry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(2 == arg2.version, 1);
        assert!(2 == arg1.version, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg4) >= arg1.checkin_fee, 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::split<0x2::sui::SUI>(arg4, arg1.checkin_fee, arg9));
        enforce_signature(arg2, arg3, arg5, arg6, arg7, 0x2::tx_context::sender(arg9), arg8);
        if (0x1::option::is_some<u64>(&arg6)) {
            arg0.points = *0x1::option::borrow<u64>(&arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            let v0 = *0x1::option::borrow<u64>(&arg7);
            assert!(0x1::vector::contains<u64>(&arg2.leagues, &v0), 6);
            arg0.league = v0;
        };
        let v1 = DailyCheckin{
            nft_id     : 0x2::object::uid_to_inner(&mut arg0.id),
            new_points : arg6,
            new_league : arg7,
            fee        : arg1.checkin_fee,
        };
        0x2::event::emit<DailyCheckin>(v1);
    }

    fun enforce_signature(arg0: &mut Registry, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: address, arg6: vector<u8>) {
        if (arg0.check_signature) {
            assert!(arg2 >= 0x2::clock::timestamp_ms(arg1) / 1000, 5);
            let v0 = serialize_checkin_args(arg2, arg3, arg4, arg5);
            assert!(0x2::ecdsa_k1::secp256k1_verify(&arg6, &arg0.pk, &v0, 1), 4);
        };
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
            version     : 2,
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            checkin_fee : 0,
        };
        let v2 = Registry{
            id              : 0x2::object::new(arg1),
            version         : 2,
            leagues         : vector[0, 1, 2, 3, 4],
            pk              : x"031d9cd3748b019a247773cae4c6e34abba70ba9fd25f86fff1595b012337d3150",
            items           : 0x2::table::new<address, RegistryItem>(arg1),
            check_signature : true,
        };
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"coins earned"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"league"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"thumbnail_url"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Capybara player card"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(x"54686520506c617965722043617264204e46542073746f72657320796f75722070726f677265737320696e20746865204361707962617261206d696e692d67616d652061732064796e616d6963204e465420617474726962757465732e2055706461746520796f75722061747472696275746573206461696c7920746f2073686f776361736520796f757220616368696576656d656e747320616e6420756e6c6f636b206576656e206d6f726520726577617264732120547261636b2c2067726f772c20616e642072656170207468652062656e6566697473e28094796f7572206a6f75726e657920737461727473206865726521"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{points}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{league}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://api.capybara.vip/api/nft/card/{league}.png"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://api.capybara.vip/api/nft/card/{league}_preview.png"));
        let v7 = 0x2::package::claim<CAPYBARA_GAME_CARD>(arg0, arg1);
        let v8 = 0x2::display::new_with_fields<NFTData>(&v7, v3, v5, arg1);
        0x2::display::update_version<NFTData>(&mut v8);
        let v9 = 0x2::address::from_bytes(0x2::address::to_bytes(@0xf322f525e7370de05cf773b522c4611b483c94533b61f2da4cb9d4f81d3ff2d));
        0x2::transfer::public_transfer<AdminCap>(v0, v9);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, v9);
        0x2::transfer::public_transfer<0x2::display::Display<NFTData>>(v8, v9);
        0x2::transfer::share_object<Treasury>(v1);
        0x2::transfer::share_object<Registry>(v2);
    }

    public fun is_treasurer<T0>(arg0: &Registry) : bool {
        let v0 = TreasurerKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<TreasurerKey<T0>>(&arg0.id, v0)
    }

    public fun league(arg0: &NFTData) : u64 {
        arg0.league
    }

    entry fun migrate(arg0: &mut Treasury, arg1: &mut Registry, arg2: &AdminCap) {
        arg0.version = 2;
        arg1.version = 2;
    }

    public entry fun mint(arg0: &mut Registry, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(2 == arg0.version, 1);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::table::contains<address, RegistryItem>(&arg0.items, v0), 3);
        enforce_signature(arg0, arg1, arg2, arg3, arg4, v0, arg5);
        let v1 = if (0x1::option::is_some<u64>(&arg4)) {
            *0x1::option::borrow<u64>(&arg4)
        } else {
            0
        };
        let v2 = if (0x1::option::is_some<u64>(&arg3)) {
            *0x1::option::borrow<u64>(&arg3)
        } else {
            0
        };
        let v3 = new_nft(v0, v1, v2, arg6);
        let v4 = 0x2::object::id<NFTData>(&v3);
        let v5 = RegistryItem{id: v4};
        0x2::table::add<address, RegistryItem>(&mut arg0.items, v0, v5);
        let v6 = MintNFT{
            from   : v0,
            to     : v0,
            points : v2,
            league : v1,
            nft_id : v4,
        };
        0x2::event::emit<MintNFT>(v6);
        0x2::transfer::transfer<NFTData>(v3, v0);
    }

    fun new_nft(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : NFTData {
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

    public fun serialize_checkin_args(arg0: u64, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: address) : vector<u8> {
        let v0 = CheckinArgTBS{
            valid_until : arg0,
            points      : arg1,
            league      : arg2,
            user        : 0x2::address::to_string(arg3),
        };
        0x1::bcs::to_bytes<CheckinArgTBS>(&v0)
    }

    public entry fun transfer_ownerchip(arg0: 0x2::package::Publisher, arg1: AdminCap, arg2: 0x2::display::Display<NFTData>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(arg0, arg3);
        0x2::transfer::public_transfer<0x2::display::Display<NFTData>>(arg2, arg3);
        0x2::transfer::public_transfer<AdminCap>(arg1, arg3);
    }

    public entry fun update_check_sig(arg0: &mut Registry, arg1: &AdminCap, arg2: bool) {
        arg0.check_signature = arg2;
    }

    public entry fun update_checkin_fee(arg0: &mut Treasury, arg1: &AdminCap, arg2: u64) {
        let v0 = UpdateFee{fee: arg2};
        0x2::event::emit<UpdateFee>(v0);
        arg0.checkin_fee = arg2;
    }

    public entry fun update_leagues(arg0: &mut Registry, arg1: &AdminCap, arg2: vector<u64>) {
        let v0 = UpdateLeagues{leagues: arg2};
        0x2::event::emit<UpdateLeagues>(v0);
        arg0.leagues = arg2;
    }

    public entry fun update_nft_data_display(arg0: &mut 0x2::display::Display<NFTData>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::display::add_multiple<NFTData>(arg0, arg1, arg2);
        0x2::display::update_version<NFTData>(arg0);
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

