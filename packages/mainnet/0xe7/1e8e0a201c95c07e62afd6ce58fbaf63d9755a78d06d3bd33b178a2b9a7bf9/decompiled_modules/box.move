module 0xe71e8e0a201c95c07e62afd6ce58fbaf63d9755a78d06d3bd33b178a2b9a7bf9::box {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        signer: vector<u8>,
        package: address,
        map: 0xe71e8e0a201c95c07e62afd6ce58fbaf63d9755a78d06d3bd33b178a2b9a7bf9::bitmap::Bitmap,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
    }

    struct ListingData has store, key {
        id: 0x2::object::UID,
        item: Item,
        owner: address,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        rarity: u8,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct MintedEvent has copy, drop {
        object_id: 0x2::object::ID,
        uuid: u256,
        owner: address,
    }

    struct DepositedEvent has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
    }

    struct WithdrawEvent has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
    }

    struct BOX has drop {
        dummy_field: bool,
    }

    public entry fun deposit(arg0: Item, arg1: u64, arg2: vector<u8>, arg3: &mut Storage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg4), 9223372822834380810);
        let v0 = 0x2::object::id<Item>(&arg0);
        assert!(verifyDepositSignature(arg3.package, 0x2::tx_context::sender(arg5), 0x2::hex::encode(0x2::object::id_to_bytes(&v0)), arg1, arg3.signer, arg2), 9223372835719413772);
        let v1 = ListingData{
            id    : 0x2::object::new(arg5),
            item  : arg0,
            owner : 0x2::tx_context::sender(arg5),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, ListingData>(&mut arg3.id, v0, v1);
        let v2 = DepositedEvent{
            nft_id : v0,
            owner  : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<DepositedEvent>(v2);
    }

    fun init(arg0: BOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Storage{
            id      : 0x2::object::new(arg1),
            signer  : 0x1::vector::empty<u8>(),
            package : @0x0,
            map     : 0xe71e8e0a201c95c07e62afd6ce58fbaf63d9755a78d06d3bd33b178a2b9a7bf9::bitmap::new(arg1),
        };
        0x2::transfer::share_object<Storage>(v1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"attributes"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{attributes}"));
        let v6 = 0x2::package::claim<BOX>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<Item>(&v6, v2, v4, arg1);
        0x2::display::update_version<Item>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Item>>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: u256, arg1: u64, arg2: u8, arg3: vector<u8>, arg4: &mut Storage, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg5), 9223372655330656266);
        assert!(verifyMintSignature(arg4.package, 0x2::tx_context::sender(arg6), arg0, arg1, arg2, arg4.signer, arg3), 9223372659625754636);
        assert!(!0xe71e8e0a201c95c07e62afd6ce58fbaf63d9755a78d06d3bd33b178a2b9a7bf9::bitmap::get(&arg4.map, arg0), 9223372663920853006);
        0xe71e8e0a201c95c07e62afd6ce58fbaf63d9755a78d06d3bd33b178a2b9a7bf9::bitmap::set(&mut arg4.map, arg0);
        let v0 = 0x1::string::utf8(b"https://static.florence.seeddao.org/box-");
        0x1::string::append(&mut v0, 0x1::u8::to_string(arg2));
        0x1::string::append(&mut v0, 0x1::string::utf8(b".png"));
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"rarity"), 0x1::u8::to_string(arg2));
        let v2 = Item{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(b"SEED Mon Box"),
            description : 0x1::string::utf8(b"Users will receive SEED Mon Box at random rates, each Box holds a mystery Mon inside. You can mint your own Mon Box in app. When opening box, you'll receive a new SEED Mon, with its quality determined by the Mon Box tier."),
            rarity      : arg2,
            image_url   : v0,
            project_url : 0x1::string::utf8(b"https://playseedgo.com/"),
            attributes  : v1,
        };
        let v3 = MintedEvent{
            object_id : 0x2::object::id<Item>(&v2),
            uuid      : arg0,
            owner     : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<MintedEvent>(v3);
        0x2::transfer::public_transfer<Item>(v2, 0x2::tx_context::sender(arg6));
    }

    public fun updateStorage(arg0: address, arg1: vector<u8>, arg2: &mut Storage, arg3: &AdminCap) {
        arg2.package = arg0;
        arg2.signer = arg1;
    }

    fun verifyDepositSignature(arg0: address, arg1: address, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(b"deposit-box");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::address::to_bytes(arg0))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::address::to_bytes(arg1))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(arg2));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg3));
        0x2::ed25519::ed25519_verify(&arg5, &arg4, 0x1::string::as_bytes(&v0))
    }

    fun verifyMintSignature(arg0: address, arg1: address, arg2: u256, arg3: u64, arg4: u8, arg5: vector<u8>, arg6: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(b"mint-box");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::address::to_bytes(arg0))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::address::to_bytes(arg1))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u256::to_string(arg2));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg3));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u8::to_string(arg4));
        0x2::ed25519::ed25519_verify(&arg6, &arg5, 0x1::string::as_bytes(&v0))
    }

    fun verifyWithdrawSignature(arg0: address, arg1: address, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(b"withdraw-box");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::address::to_bytes(arg0))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::address::to_bytes(arg1))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(arg2));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg3));
        0x2::ed25519::ed25519_verify(&arg5, &arg4, 0x1::string::as_bytes(&v0))
    }

    public entry fun withdraw(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: &mut Storage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg4), 9223372934503530506);
        assert!(verifyWithdrawSignature(arg3.package, 0x2::tx_context::sender(arg5), 0x2::hex::encode(0x2::object::id_to_bytes(&arg0)), arg1, arg3.signer, arg2), 9223372947388563468);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg3.id, arg0), 9223372951683792912);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, ListingData>(&mut arg3.id, arg0);
        assert!(0x2::tx_context::sender(arg5) == v0.owner, 9223372964568170504);
        let ListingData {
            id    : v1,
            item  : v2,
            owner : _,
        } = v0;
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<Item>(v2, 0x2::tx_context::sender(arg5));
        let v4 = WithdrawEvent{
            nft_id : arg0,
            owner  : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<WithdrawEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

