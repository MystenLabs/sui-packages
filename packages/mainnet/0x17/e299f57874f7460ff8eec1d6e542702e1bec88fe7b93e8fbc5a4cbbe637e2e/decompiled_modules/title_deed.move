module 0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::title_deed {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TITLE_DEED has drop {
        dummy_field: bool,
    }

    struct DeedConfig has store, key {
        id: 0x2::object::UID,
        pack_minted: u16,
        version: 0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::version::Version,
    }

    struct DeedPack has key {
        id: 0x2::object::UID,
        seq_id: u16,
    }

    struct TitleDeed has key {
        id: 0x2::object::UID,
        seq_id: u16,
    }

    struct PackGranted has copy, drop {
        to: address,
        seq_id: u16,
        timestamp: u64,
    }

    struct PackOpened has copy, drop {
        owner: address,
        seq_id: u16,
        timestamp: u64,
    }

    struct VersionUpgraded has copy, drop {
        old_version: u64,
        new_version: u64,
        timestamp: u64,
    }

    struct VersionSet has copy, drop {
        old_version: u64,
        new_version: u64,
        timestamp: u64,
    }

    public entry fun grant_pack(arg0: &AdminCap, arg1: &mut DeedConfig, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::version::assert_supported_version(&arg1.version);
        arg1.pack_minted = arg1.pack_minted + 1;
        let v0 = arg1.pack_minted;
        let v1 = DeedPack{
            id     : 0x2::object::new(arg4),
            seq_id : v0,
        };
        0x2::transfer::transfer<DeedPack>(v1, arg3);
        let v2 = PackGranted{
            to        : arg3,
            seq_id    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PackGranted>(v2);
    }

    fun init(arg0: TITLE_DEED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TITLE_DEED>(arg0, arg1);
        let v1 = 0x2::display::new<DeedPack>(&v0, arg1);
        0x2::display::add<DeedPack>(&mut v1, 0x1::string::utf8(b"seq_id"), 0x1::string::utf8(b"{seq_id}"));
        0x2::display::add<DeedPack>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://deed-assets.s3.us-west-1.amazonaws.com/pack.png"));
        0x2::display::update_version<DeedPack>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<DeedPack>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x2::display::new<TitleDeed>(&v0, arg1);
        0x2::display::add<TitleDeed>(&mut v2, 0x1::string::utf8(b"seq_id"), 0x1::string::utf8(b"{seq_id}"));
        0x2::display::add<TitleDeed>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"MMT Title Deed NFT"));
        0x2::display::add<TitleDeed>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"MMT Title Deed NFTs are designed to recognize, reward, and empower the most active builders and contributors shaping the Sui ecosystem."));
        0x2::display::add<TitleDeed>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://deed-assets.s3.us-west-1.amazonaws.com/images/{seq_id}.png"));
        0x2::display::add<TitleDeed>(&mut v2, 0x1::string::utf8(b"info_url"), 0x1::string::utf8(b"https://deed-assets.s3.us-west-1.amazonaws.com/info/{seq_id}.json"));
        0x2::display::update_version<TitleDeed>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<TitleDeed>>(v2, 0x2::tx_context::sender(arg1));
        let v3 = DeedConfig{
            id          : 0x2::object::new(arg1),
            pack_minted : 0,
            version     : 0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::version::create(arg1),
        };
        0x2::transfer::share_object<DeedConfig>(v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public entry fun open(arg0: &DeedConfig, arg1: DeedPack, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::version::assert_supported_version(&arg0.version);
        let v0 = 0x2::tx_context::sender(arg3);
        let DeedPack {
            id     : v1,
            seq_id : v2,
        } = arg1;
        0x2::object::delete(v1);
        let v3 = TitleDeed{
            id     : 0x2::object::new(arg3),
            seq_id : v2,
        };
        0x2::transfer::transfer<TitleDeed>(v3, v0);
        let v4 = PackOpened{
            owner     : v0,
            seq_id    : v2,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PackOpened>(v4);
    }

    public fun seq_id(arg0: &TitleDeed) : u16 {
        arg0.seq_id
    }

    public entry fun set_version(arg0: &AdminCap, arg1: &mut DeedConfig, arg2: &0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::version::VersionCap, arg3: u64, arg4: &0x2::clock::Clock) {
        0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::version::set_version(&mut arg1.version, arg2, arg3);
        let v0 = VersionSet{
            old_version : 0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::version::value(&arg1.version),
            new_version : arg3,
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<VersionSet>(v0);
    }

    public entry fun upgrade_version(arg0: &AdminCap, arg1: &mut DeedConfig, arg2: &0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::version::VersionCap, arg3: &0x2::clock::Clock) {
        0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::version::upgrade(&mut arg1.version, arg2);
        let v0 = VersionUpgraded{
            old_version : 0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::version::value(&arg1.version),
            new_version : 0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::version::value(&arg1.version),
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VersionUpgraded>(v0);
    }

    // decompiled from Move bytecode v6
}

