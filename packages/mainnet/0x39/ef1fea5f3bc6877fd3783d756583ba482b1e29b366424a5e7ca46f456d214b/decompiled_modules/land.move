module 0x39ef1fea5f3bc6877fd3783d756583ba482b1e29b366424a5e7ca46f456d214b::land {
    struct LAND has drop {
        dummy_field: bool,
    }

    struct Land has store, key {
        id: 0x2::object::UID,
        number: u64,
        zone_id: u8,
        x_coord: u64,
        y_coord: u64,
        meta_id: u64,
        creation_date: u64,
        minted_via: 0x1::string::String,
        image_url: 0x1::string::String,
        token_uri: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        name: 0x1::string::String,
    }

    struct LandNameChanged has copy, drop {
        number: u64,
        name: 0x1::string::String,
    }

    public fun get_minted_via(arg0: &Land) : 0x1::string::String {
        arg0.minted_via
    }

    public fun get_name(arg0: &Land) : 0x1::string::String {
        arg0.name
    }

    public fun get_number(arg0: &Land) : u64 {
        arg0.number
    }

    public fun get_zone_id(arg0: &Land) : u8 {
        arg0.zone_id
    }

    fun init(arg0: LAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::new_admin<LAND>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::unique_nft::create_and_share<LAND>(&arg0, 6942, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::create_and_share_receipts<LAND>(&arg0, arg1);
        let v1 = 0x2::package::claim<LAND>(arg0, arg1);
        let v2 = 0x2::display::new<Land>(&v1, arg1);
        0x2::display::add<Land>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Land>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Land>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Emerald City Land #{number}"));
        0x2::display::add<Land>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://gangstabet.io"));
        0x2::display::update_version<Land>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<Land>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<LAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<LAND>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::issue_minter<LAND>(&v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint_migrated(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<LAND>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::Receipts<LAND>, arg2: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::unique_nft::Collection<LAND>, arg3: vector<u8>, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::string::String, arg10: u64, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: vector<0x1::string::String>, arg15: vector<0x1::string::String>, arg16: address, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg9) <= 30, 13906834599545405445);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::record<LAND>(arg0, arg1, arg3);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::unique_nft::account_migrated<LAND>(arg0, arg2, arg4, arg16);
        let v0 = Land{
            id            : 0x2::object::new(arg17),
            number        : arg4,
            zone_id       : arg5,
            x_coord       : arg6,
            y_coord       : arg7,
            meta_id       : arg8,
            creation_date : arg10,
            minted_via    : arg11,
            image_url     : arg12,
            token_uri     : arg13,
            attributes    : to_str_map(arg14, arg15),
            name          : arg9,
        };
        0x2::transfer::public_transfer<Land>(v0, arg16);
    }

    public fun set_name(arg0: &mut Land, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) <= 30, 13906834698329653253);
        arg0.name = arg1;
        let v0 = LandNameChanged{
            number : arg0.number,
            name   : arg1,
        };
        0x2::event::emit<LandNameChanged>(v0);
    }

    fun to_str_map(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<0x1::string::String>(&arg1), 13906834762754031619);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0, v1), *0x1::vector::borrow<0x1::string::String>(&arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

