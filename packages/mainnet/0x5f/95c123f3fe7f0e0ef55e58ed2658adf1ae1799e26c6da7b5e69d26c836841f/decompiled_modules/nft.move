module 0x5f95c123f3fe7f0e0ef55e58ed2658adf1ae1799e26c6da7b5e69d26c836841f::nft {
    struct Attributes has drop, store {
        map: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct Nft<phantom T0> has store, key {
        id: 0x2::object::UID,
        type: 0x1::type_name::TypeName,
        token_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        project_url: 0x1::string::String,
        link: 0x1::string::String,
        attributes: Attributes,
        betted: bool,
        version: u64,
    }

    struct MintNft has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
    }

    struct MintEvent has copy, drop {
        nft_type: 0x1::type_name::TypeName,
        account: address,
        amount: u64,
        nfts: vector<MintNft>,
    }

    struct BurnNft has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
    }

    struct BurnEvent has copy, drop {
        nft_type: 0x1::type_name::TypeName,
        account: address,
        amount: u64,
        nfts: vector<BurnNft>,
    }

    struct OpenNft has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
    }

    struct OpenEvent has copy, drop {
        nft_type: 0x1::type_name::TypeName,
        account: address,
        amount: u64,
        nfts: vector<OpenNft>,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    fun assert_not_open<T0>(arg0: &Nft<T0>) {
        assert!(arg0.token_id == 0, 10003);
    }

    fun assert_owner<T0>(arg0: &mut 0x2::package::Publisher) {
        assert!(0x2::package::from_module<Nft<T0>>(arg0), 10005);
    }

    fun assert_version(arg0: &Version) {
        assert!(arg0.version == 1, 10001);
    }

    public fun batch_burn<T0>(arg0: &mut Version, arg1: vector<Nft<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::length<Nft<T0>>(&arg1);
        let v1 = BurnEvent{
            nft_type : 0x1::type_name::get<T0>(),
            account  : 0x2::tx_context::sender(arg2),
            amount   : v0,
            nfts     : 0x1::vector::empty<BurnNft>(),
        };
        let v2 = 0;
        0x1::vector::reverse<Nft<T0>>(&mut arg1);
        while (v2 < v0) {
            let v3 = 0x1::vector::pop_back<Nft<T0>>(&mut arg1);
            let v4 = BurnNft{
                nft_id   : 0x2::object::id<Nft<T0>>(&v3),
                token_id : v3.token_id,
            };
            0x1::vector::push_back<BurnNft>(&mut v1.nfts, v4);
            burn_nft<T0>(v3);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<Nft<T0>>(arg1);
        0x2::event::emit<BurnEvent>(v1);
    }

    public fun batch_mint<T0>(arg0: &mut Version, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &vector<u64>, arg7: &vector<0x2::url::Url>, arg8: &vector<0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = MintEvent{
            nft_type : 0x1::type_name::get<T0>(),
            account  : arg1,
            amount   : arg9,
            nfts     : 0x1::vector::empty<MintNft>(),
        };
        let v1 = 0;
        while (v1 < arg9) {
            let v2 = mint_nft<T0>(*0x1::vector::borrow<u64>(arg6, v1), arg2, arg3, *0x1::vector::borrow<0x2::url::Url>(arg7, v1), arg4, arg5, *0x1::vector::borrow<0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>>(arg8, v1), arg10);
            let v3 = MintNft{
                nft_id   : 0x2::object::id<Nft<T0>>(&v2),
                token_id : v2.token_id,
            };
            0x1::vector::push_back<MintNft>(&mut v0.nfts, v3);
            0x2::transfer::public_transfer<Nft<T0>>(v2, arg1);
            v1 = v1 + 1;
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public fun batch_open<T0>(arg0: &mut Version, arg1: vector<Nft<T0>>, arg2: vector<u64>, arg3: vector<0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::length<Nft<T0>>(&arg1);
        let v1 = 0;
        let v2 = OpenEvent{
            nft_type : 0x1::type_name::get<T0>(),
            account  : 0x2::tx_context::sender(arg4),
            amount   : v0,
            nfts     : 0x1::vector::empty<OpenNft>(),
        };
        0x1::vector::reverse<Nft<T0>>(&mut arg1);
        while (v1 < v0) {
            let v3 = 0x1::vector::pop_back<Nft<T0>>(&mut arg1);
            let v4 = &mut v3;
            open_nft<T0>(v4, *0x1::vector::borrow<u64>(&arg2, v1), *0x1::vector::borrow<0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>>(&arg3, v1));
            let v5 = OpenNft{
                nft_id   : 0x2::object::id<Nft<T0>>(&v3),
                token_id : v3.token_id,
            };
            0x1::vector::push_back<OpenNft>(&mut v2.nfts, v5);
            0x2::transfer::public_transfer<Nft<T0>>(v3, 0x2::tx_context::sender(arg4));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<Nft<T0>>(arg1);
        0x2::event::emit<OpenEvent>(v2);
    }

    public fun borrow_attributes<T0>(arg0: &Nft<T0>) : &0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String> {
        &arg0.attributes.map
    }

    public fun borrow_betted<T0>(arg0: &Nft<T0>) : &bool {
        &arg0.betted
    }

    public fun borrow_description<T0>(arg0: &Nft<T0>) : &0x1::string::String {
        &arg0.description
    }

    public fun borrow_id<T0>(arg0: &Nft<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun borrow_image_url<T0>(arg0: &Nft<T0>) : &0x2::url::Url {
        &arg0.image_url
    }

    public fun borrow_link<T0>(arg0: &Nft<T0>) : &0x1::string::String {
        &arg0.link
    }

    public fun borrow_mut_attributes<T0>(arg0: &mut Version, arg1: &mut Nft<T0>) : &mut 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String> {
        assert_version(arg0);
        &mut arg1.attributes.map
    }

    public fun borrow_mut_betted<T0>(arg0: &mut Version, arg1: &mut Nft<T0>) : &mut bool {
        assert_version(arg0);
        &mut arg1.betted
    }

    public fun borrow_mut_description<T0>(arg0: &mut Version, arg1: &mut Nft<T0>) : &mut 0x1::string::String {
        assert_version(arg0);
        &mut arg1.description
    }

    public fun borrow_mut_id<T0>(arg0: &mut Version, arg1: &mut Nft<T0>) : &mut 0x2::object::UID {
        assert_version(arg0);
        &mut arg1.id
    }

    public fun borrow_mut_image_url<T0>(arg0: &mut Version, arg1: &mut Nft<T0>) : &mut 0x2::url::Url {
        assert_version(arg0);
        &mut arg1.image_url
    }

    public fun borrow_mut_link<T0>(arg0: &mut Version, arg1: &mut Nft<T0>) : &mut 0x1::string::String {
        assert_version(arg0);
        &mut arg1.link
    }

    public fun borrow_mut_name<T0>(arg0: &mut Version, arg1: &mut Nft<T0>) : &mut 0x1::string::String {
        assert_version(arg0);
        &mut arg1.name
    }

    public fun borrow_mut_project_url<T0>(arg0: &mut Version, arg1: &mut Nft<T0>) : &mut 0x1::string::String {
        assert_version(arg0);
        &mut arg1.project_url
    }

    public fun borrow_mut_token_id<T0>(arg0: &mut Version, arg1: &mut Nft<T0>) : &mut u64 {
        assert_version(arg0);
        &mut arg1.token_id
    }

    public fun borrow_mut_type<T0>(arg0: &mut Version, arg1: &mut Nft<T0>) : &mut 0x1::type_name::TypeName {
        assert_version(arg0);
        &mut arg1.type
    }

    public fun borrow_mut_version<T0>(arg0: &mut Version, arg1: &mut Nft<T0>) : &mut u64 {
        assert_version(arg0);
        &mut arg1.version
    }

    public fun borrow_name<T0>(arg0: &Nft<T0>) : &0x1::string::String {
        &arg0.name
    }

    public fun borrow_project_url<T0>(arg0: &Nft<T0>) : &0x1::string::String {
        &arg0.project_url
    }

    public fun borrow_token_id<T0>(arg0: &Nft<T0>) : &u64 {
        &arg0.token_id
    }

    public fun borrow_type<T0>(arg0: &Nft<T0>) : &0x1::type_name::TypeName {
        &arg0.type
    }

    public fun borrow_version<T0>(arg0: &Nft<T0>) : &u64 {
        &arg0.version
    }

    public fun burn<T0>(arg0: &mut Version, arg1: Nft<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = BurnEvent{
            nft_type : 0x1::type_name::get<T0>(),
            account  : 0x2::tx_context::sender(arg2),
            amount   : 1,
            nfts     : 0x1::vector::empty<BurnNft>(),
        };
        let v1 = BurnNft{
            nft_id   : 0x2::object::id<Nft<T0>>(&arg1),
            token_id : arg1.token_id,
        };
        0x1::vector::push_back<BurnNft>(&mut v0.nfts, v1);
        burn_nft<T0>(arg1);
        0x2::event::emit<BurnEvent>(v0);
    }

    fun burn_nft<T0>(arg0: Nft<T0>) {
        let Nft {
            id          : v0,
            type        : _,
            token_id    : _,
            name        : _,
            description : _,
            image_url   : _,
            project_url : _,
            link        : _,
            attributes  : _,
            betted      : _,
            version     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun decorate<T0>(arg0: &mut Version, arg1: &mut Nft<T0>, arg2: 0x1::option::Option<0x2::url::Url>, arg3: vector<0x1::ascii::String>, arg4: vector<0x1::ascii::String>) {
        assert_version(arg0);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg3) == 0x1::vector::length<0x1::ascii::String>(&arg4), 10004);
        if (0x1::option::is_some<0x2::url::Url>(&arg2)) {
            arg1.image_url = *0x1::option::borrow<0x2::url::Url>(&arg2);
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::ascii::String>(&arg3)) {
            let v1 = 0x1::vector::borrow<0x1::ascii::String>(&arg3, v0);
            if (0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(&arg1.attributes.map, v1)) {
                *0x2::vec_map::get_mut<0x1::ascii::String, 0x1::ascii::String>(&mut arg1.attributes.map, v1) = *0x1::vector::borrow<0x1::ascii::String>(&arg4, v0);
            } else {
                0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut arg1.attributes.map, *v1, *0x1::vector::borrow<0x1::ascii::String>(&arg4, v0));
            };
            v0 = v0 + 1;
        };
    }

    public fun from_vec_map(arg0: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>) : Attributes {
        Attributes{map: arg0}
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<NFT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun init_collection<T0>(arg0: &mut 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : Version {
        assert_owner<T0>(arg0);
        init_display<T0>(arg0, arg1);
        Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        }
    }

    fun init_display<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new<Nft<T0>>(arg0, arg1);
        0x2::display::add<Nft<T0>>(&mut v0, 0x1::string::utf8(b"collection_test"), 0x1::string::utf8(b"{collection_test}"));
        0x2::display::add<Nft<T0>>(&mut v0, 0x1::string::utf8(b"token_id"), 0x1::string::utf8(b"{token_id}"));
        0x2::display::add<Nft<T0>>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Nft<T0>>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft<T0>>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"{project_url}"));
        0x2::display::add<Nft<T0>>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"{link}"));
        0x2::display::add<Nft<T0>>(&mut v0, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<Nft<T0>>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<Nft<T0>>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun migrate(arg0: &mut Version) {
        assert!(arg0.version < 1, 10002);
        arg0.version = 1;
    }

    public fun mint<T0>(arg0: &mut Version, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::url::Url, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = MintEvent{
            nft_type : 0x1::type_name::get<T0>(),
            account  : arg8,
            amount   : 1,
            nfts     : 0x1::vector::empty<MintNft>(),
        };
        let v1 = mint_nft<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9);
        let v2 = MintNft{
            nft_id   : 0x2::object::id<Nft<T0>>(&v1),
            token_id : v1.token_id,
        };
        0x1::vector::push_back<MintNft>(&mut v0.nfts, v2);
        0x2::transfer::public_transfer<Nft<T0>>(v1, arg8);
        0x2::event::emit<MintEvent>(v0);
    }

    fun mint_nft<T0>(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::url::Url, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>, arg7: &mut 0x2::tx_context::TxContext) : Nft<T0> {
        Nft<T0>{
            id          : 0x2::object::new(arg7),
            type        : 0x1::type_name::get<T0>(),
            token_id    : arg0,
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            project_url : arg4,
            link        : arg5,
            attributes  : from_vec_map(arg6),
            betted      : false,
            version     : 1,
        }
    }

    public fun open<T0>(arg0: &mut Version, arg1: Nft<T0>, arg2: u64, arg3: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = &mut arg1;
        open_nft<T0>(v0, arg2, arg3);
        let v1 = OpenEvent{
            nft_type : 0x1::type_name::get<T0>(),
            account  : 0x2::tx_context::sender(arg4),
            amount   : 1,
            nfts     : 0x1::vector::empty<OpenNft>(),
        };
        let v2 = OpenNft{
            nft_id   : 0x2::object::id<Nft<T0>>(&arg1),
            token_id : arg1.token_id,
        };
        0x1::vector::push_back<OpenNft>(&mut v1.nfts, v2);
        0x2::transfer::public_transfer<Nft<T0>>(arg1, 0x2::tx_context::sender(arg4));
        0x2::event::emit<OpenEvent>(v1);
    }

    fun open_nft<T0>(arg0: &mut Nft<T0>, arg1: u64, arg2: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>) {
        assert_not_open<T0>(arg0);
        arg0.token_id = arg1;
        let v0 = &mut arg0.attributes.map;
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x1::ascii::String, 0x1::ascii::String>(&mut arg2)) {
            let (v2, v3) = 0x2::vec_map::pop<0x1::ascii::String, 0x1::ascii::String>(&mut arg2);
            let v4 = v2;
            if (0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(v0, &v4)) {
                *0x2::vec_map::get_mut<0x1::ascii::String, 0x1::ascii::String>(v0, &v4) = v3;
            } else {
                0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(v0, v4, v3);
            };
            v1 = v1 + 1;
        };
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

