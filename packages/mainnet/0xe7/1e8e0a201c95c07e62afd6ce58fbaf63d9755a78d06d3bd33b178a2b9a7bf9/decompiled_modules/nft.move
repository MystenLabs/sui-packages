module 0xe71e8e0a201c95c07e62afd6ce58fbaf63d9755a78d06d3bd33b178a2b9a7bf9::nft {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        signer: vector<u8>,
        package: address,
        map: 0xe71e8e0a201c95c07e62afd6ce58fbaf63d9755a78d06d3bd33b178a2b9a7bf9::bitmap::Bitmap,
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
        class: u8,
        rarity: u8,
        proficiency: u8,
        luck: u8,
        seeding: u8,
        recovery: u8,
        image_url: 0x1::string::String,
        media_url: 0x1::string::String,
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

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun class(arg0: &Item) : u8 {
        arg0.class
    }

    public entry fun deposit(arg0: Item, arg1: u64, arg2: vector<u8>, arg3: &mut Storage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg4), 9223373054762614794);
        let v0 = 0x2::object::id<Item>(&arg0);
        assert!(verifyDepositSignature(arg3.package, 0x2::tx_context::sender(arg5), 0x2::hex::encode(0x2::object::id_to_bytes(&v0)), arg1, arg3.signer, arg2), 9223373067647647756);
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

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"media_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"class"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"proficiency"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"luck"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"seeding"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"recovery"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"attributes"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{media_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{class}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{proficiency}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{luck}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{seeding}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{recovery}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{attributes}"));
        let v6 = 0x2::package::claim<NFT>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<Item>(&v6, v2, v4, arg1);
        0x2::display::update_version<Item>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Item>>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun luck(arg0: &Item) : u8 {
        arg0.luck
    }

    public entry fun mint(arg0: u256, arg1: u64, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: u8, arg7: u8, arg8: vector<u8>, arg9: &mut Storage, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg10), 9223372844309217290);
        assert!(verifyMintSignature(arg9.package, 0x2::tx_context::sender(arg11), arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9.signer, arg8), 9223372848604315660);
        assert!(!0xe71e8e0a201c95c07e62afd6ce58fbaf63d9755a78d06d3bd33b178a2b9a7bf9::bitmap::get(&arg9.map, arg0), 9223372852899414030);
        0xe71e8e0a201c95c07e62afd6ce58fbaf63d9755a78d06d3bd33b178a2b9a7bf9::bitmap::set(&mut arg9.map, arg0);
        let v0 = 0x1::string::utf8(b"https://static.florence.seeddao.org/");
        0x1::string::append(&mut v0, 0x1::u256::to_string(arg0));
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"class"), 0x1::u8::to_string(arg2));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"rarity"), 0x1::u8::to_string(arg3));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"proficiency"), 0x1::u8::to_string(arg4));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"luck"), 0x1::u8::to_string(arg5));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"seeding"), 0x1::u8::to_string(arg6));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"recovery"), 0x1::u8::to_string(arg7));
        let v2 = Item{
            id          : 0x2::object::new(arg11),
            name        : 0x1::string::utf8(b"SEED Mon"),
            description : 0x1::string::utf8(b"SEED Mons are virtual companions at the core of the SEED Go - collectible, tradable, and game-enhancing! Each SEED Mon comes with unique abilities, rarity levels, and earning potential. By owning a SEED Mon NFT, you unlock the ability to earn $SLOVE, $SEED, and other valuable gems."),
            class       : arg2,
            rarity      : arg3,
            proficiency : arg4,
            luck        : arg5,
            seeding     : arg6,
            recovery    : arg7,
            image_url   : v0,
            media_url   : v0,
            project_url : 0x1::string::utf8(b"https://playseedgo.com/"),
            attributes  : v1,
        };
        let v3 = MintedEvent{
            object_id : 0x2::object::id<Item>(&v2),
            uuid      : arg0,
            owner     : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<MintedEvent>(v3);
        0x2::transfer::public_transfer<Item>(v2, 0x2::tx_context::sender(arg11));
    }

    public fun proficiency(arg0: &Item) : u8 {
        arg0.proficiency
    }

    public fun rarity(arg0: &Item) : u8 {
        arg0.rarity
    }

    public fun recovery(arg0: &Item) : u8 {
        arg0.recovery
    }

    public fun seeding(arg0: &Item) : u8 {
        arg0.seeding
    }

    public fun updateStorage(arg0: address, arg1: vector<u8>, arg2: &mut Storage, arg3: &AdminCap) {
        arg2.package = arg0;
        arg2.signer = arg1;
    }

    public fun verifyDepositSignature(arg0: address, arg1: address, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(b"deposit");
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

    public fun verifyMintSignature(arg0: address, arg1: address, arg2: u256, arg3: u64, arg4: u8, arg5: u8, arg6: u8, arg7: u8, arg8: u8, arg9: u8, arg10: vector<u8>, arg11: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(b"mint");
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
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u8::to_string(arg5));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u8::to_string(arg6));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u8::to_string(arg7));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u8::to_string(arg8));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::u8::to_string(arg9));
        0x2::ed25519::ed25519_verify(&arg11, &arg10, 0x1::string::as_bytes(&v0))
    }

    public fun verifyWithdrawSignature(arg0: address, arg1: address, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(b"withdraw");
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
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg4), 9223373166431764490);
        assert!(verifyWithdrawSignature(arg3.package, 0x2::tx_context::sender(arg5), 0x2::hex::encode(0x2::object::id_to_bytes(&arg0)), arg1, arg3.signer, arg2), 9223373179316797452);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg3.id, arg0), 9223373183612026896);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, ListingData>(&mut arg3.id, arg0);
        assert!(0x2::tx_context::sender(arg5) == v0.owner, 9223373196496404488);
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

