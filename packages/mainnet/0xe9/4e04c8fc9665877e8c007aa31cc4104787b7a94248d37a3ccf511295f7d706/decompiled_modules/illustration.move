module 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::illustration {
    struct ILLUSTRATION has drop {
        dummy_field: bool,
    }

    struct Illustration has store, key {
        id: 0x2::object::UID,
        number: u64,
        gangstabet_number: u64,
        name: 0x1::string::String,
        is_gangster: bool,
        character_class: 0x1::string::String,
        image_url: 0x1::string::String,
        token_uri: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun get_attributes(arg0: &Illustration) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun get_character_class(arg0: &Illustration) : 0x1::string::String {
        arg0.character_class
    }

    public fun get_gangstabet_number(arg0: &Illustration) : u64 {
        arg0.gangstabet_number
    }

    public fun get_is_gangster(arg0: &Illustration) : bool {
        arg0.is_gangster
    }

    public fun get_name(arg0: &Illustration) : 0x1::string::String {
        arg0.name
    }

    public fun get_number(arg0: &Illustration) : u64 {
        arg0.number
    }

    fun init(arg0: ILLUSTRATION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::new_admin<ILLUSTRATION>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::unique_nft::create_and_share<ILLUSTRATION>(&arg0, 20, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::create_and_share_receipts<ILLUSTRATION>(&arg0, arg1);
        let v1 = 0x2::package::claim<ILLUSTRATION>(arg0, arg1);
        let v2 = 0x2::display::new<Illustration>(&v1, arg1);
        0x2::display::add<Illustration>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Illustration>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Illustration>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Illustration of GangstaBet #{gangstabet_number}"));
        0x2::display::add<Illustration>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://gangstabet.io"));
        0x2::display::update_version<Illustration>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<Illustration>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<ILLUSTRATION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<ILLUSTRATION>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::issue_minter<ILLUSTRATION>(&v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint_migrated(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<ILLUSTRATION>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::Receipts<ILLUSTRATION>, arg2: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::unique_nft::Collection<ILLUSTRATION>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: bool, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: vector<0x1::string::String>, arg12: vector<0x1::string::String>, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::record<ILLUSTRATION>(arg0, arg1, arg3);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::unique_nft::account_migrated<ILLUSTRATION>(arg0, arg2, arg4, arg13);
        let v0 = Illustration{
            id                : 0x2::object::new(arg14),
            number            : arg4,
            gangstabet_number : arg5,
            name              : arg6,
            is_gangster       : arg7,
            character_class   : arg8,
            image_url         : arg9,
            token_uri         : arg10,
            attributes        : to_str_map(arg11, arg12),
        };
        0x2::transfer::public_transfer<Illustration>(v0, arg13);
    }

    fun to_str_map(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<0x1::string::String>(&arg1), 13906834741279129602);
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

