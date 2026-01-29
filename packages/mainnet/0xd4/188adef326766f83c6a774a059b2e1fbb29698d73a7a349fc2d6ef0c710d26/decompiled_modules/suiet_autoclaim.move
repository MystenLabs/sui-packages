module 0xd4188adef326766f83c6a774a059b2e1fbb29698d73a7a349fc2d6ef0c710d26::suiet_autoclaim {
    struct SUIET_AUTOCLAIM has drop {
        dummy_field: bool,
    }

    struct AutoclaimNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        minted_at: u64,
        modify_count: u64,
        last_modified_at: u64,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        receiver: address,
    }

    struct NFTModified has copy, drop {
        nft_id: 0x2::object::ID,
        modify_count: u64,
        timestamp: u64,
    }

    public fun description(arg0: &AutoclaimNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &AutoclaimNFT) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: SUIET_AUTOCLAIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIET_AUTOCLAIM>(arg0, arg1);
        let v1 = 0x2::display::new<AutoclaimNFT>(&v0, arg1);
        0x2::display::add<AutoclaimNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<AutoclaimNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<AutoclaimNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<AutoclaimNFT>(&mut v1, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<AutoclaimNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suilend.fi"));
        0x2::display::add<AutoclaimNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Suilend Protocol"));
        0x2::display::update_version<AutoclaimNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AutoclaimNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun last_modified_at(arg0: &AutoclaimNFT) : u64 {
        arg0.last_modified_at
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AutoclaimNFT{
            id               : 0x2::object::new(arg5),
            name             : 0x1::string::utf8(arg0),
            description      : 0x1::string::utf8(arg1),
            image_url        : 0x1::string::utf8(arg2),
            minted_at        : 0x2::clock::timestamp_ms(arg4),
            modify_count     : 0,
            last_modified_at : 0,
        };
        let v1 = NFTMinted{
            nft_id   : 0x2::object::id<AutoclaimNFT>(&v0),
            name     : v0.name,
            receiver : arg3,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<AutoclaimNFT>(v0, arg3);
    }

    public fun minted_at(arg0: &AutoclaimNFT) : u64 {
        arg0.minted_at
    }

    public entry fun modify(arg0: &mut AutoclaimNFT, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.modify_count = arg0.modify_count + 1;
        arg0.last_modified_at = v0;
        let v1 = NFTModified{
            nft_id       : 0x2::object::id<AutoclaimNFT>(arg0),
            modify_count : arg0.modify_count,
            timestamp    : v0,
        };
        0x2::event::emit<NFTModified>(v1);
    }

    public fun modify_count(arg0: &AutoclaimNFT) : u64 {
        arg0.modify_count
    }

    public fun name(arg0: &AutoclaimNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

