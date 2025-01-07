module 0x9d3ed8ea86d8b76a87ed9ac17953844018a2a5fcf14eacb27842a641b4f9b792::pet3 {
    struct Pet3Pool has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0x9d3ed8ea86d8b76a87ed9ac17953844018a2a5fcf14eacb27842a641b4f9b792::pet3_token::PET3_TOKEN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pet3NFT has store, key {
        id: 0x2::object::UID,
        nft_id: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        recipient: address,
    }

    struct MintRecord has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<address, u64>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct PET3 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut MintRecord, arg1: Pet3NFT) {
        0x2::table::remove<address, u64>(&mut arg0.record, arg1.recipient);
        let Pet3NFT {
            id        : v0,
            nft_id    : _,
            name      : _,
            image_url : _,
            creator   : _,
            recipient : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    entry fun claim_box(arg0: &AdminCap, arg1: &mut Pet3Pool, arg2: address, arg3: u64, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            if (arg3 == 0) {
                break
            };
            arg3 = arg3 - 1;
            let v1 = getRandomPoints(arg4, arg5);
            v0 = v0 + v1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9d3ed8ea86d8b76a87ed9ac17953844018a2a5fcf14eacb27842a641b4f9b792::pet3_token::PET3_TOKEN>>(0x2::coin::from_balance<0x9d3ed8ea86d8b76a87ed9ac17953844018a2a5fcf14eacb27842a641b4f9b792::pet3_token::PET3_TOKEN>(0x2::balance::split<0x9d3ed8ea86d8b76a87ed9ac17953844018a2a5fcf14eacb27842a641b4f9b792::pet3_token::PET3_TOKEN>(&mut arg1.pool, v0), arg5), arg2);
    }

    public entry fun deposit(arg0: &mut Pet3Pool, arg1: 0x2::coin::Coin<0x9d3ed8ea86d8b76a87ed9ac17953844018a2a5fcf14eacb27842a641b4f9b792::pet3_token::PET3_TOKEN>) {
        0x2::balance::join<0x9d3ed8ea86d8b76a87ed9ac17953844018a2a5fcf14eacb27842a641b4f9b792::pet3_token::PET3_TOKEN>(&mut arg0.pool, 0x2::coin::into_balance<0x9d3ed8ea86d8b76a87ed9ac17953844018a2a5fcf14eacb27842a641b4f9b792::pet3_token::PET3_TOKEN>(arg1));
    }

    fun getRandomPoints(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64_in_range(&mut v0, 1000000, 10000000)
    }

    fun init(arg0: PET3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{nft_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A NFT for Pet3"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = MintRecord{
            id     : 0x2::object::new(arg1),
            record : 0x2::table::new<address, u64>(arg1),
        };
        let v5 = 0x2::package::claim<PET3>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<Pet3NFT>(&v5, v0, v2, arg1);
        let v7 = Pet3Pool{
            id   : 0x2::object::new(arg1),
            pool : 0x2::balance::zero<0x9d3ed8ea86d8b76a87ed9ac17953844018a2a5fcf14eacb27842a641b4f9b792::pet3_token::PET3_TOKEN>(),
        };
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::display::update_version<Pet3NFT>(&mut v6);
        0x2::transfer::transfer<AdminCap>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Pet3Pool>(v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Pet3NFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintRecord>(v4);
    }

    public entry fun mint(arg0: &mut MintRecord, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, u64>(&arg0.record, arg2), 1);
        let v0 = 0x2::table::length<address, u64>(&arg0.record) + 1;
        assert!(v0 <= 10, 0);
        0x2::table::add<address, u64>(&mut arg0.record, arg2, v0);
        let v1 = Pet3NFT{
            id        : 0x2::object::new(arg3),
            nft_id    : v0,
            name      : 0x1::string::utf8(b"Pet3"),
            image_url : arg1,
            creator   : 0x2::tx_context::sender(arg3),
            recipient : arg2,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<Pet3NFT>(&v1),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<Pet3NFT>(v1, arg2);
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Pet3Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9d3ed8ea86d8b76a87ed9ac17953844018a2a5fcf14eacb27842a641b4f9b792::pet3_token::PET3_TOKEN>>(0x2::coin::from_balance<0x9d3ed8ea86d8b76a87ed9ac17953844018a2a5fcf14eacb27842a641b4f9b792::pet3_token::PET3_TOKEN>(0x2::balance::split<0x9d3ed8ea86d8b76a87ed9ac17953844018a2a5fcf14eacb27842a641b4f9b792::pet3_token::PET3_TOKEN>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

