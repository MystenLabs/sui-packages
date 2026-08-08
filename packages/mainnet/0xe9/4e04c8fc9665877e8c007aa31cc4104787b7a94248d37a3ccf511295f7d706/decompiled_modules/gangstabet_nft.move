module 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft {
    struct GANGSTABET_NFT has drop {
        dummy_field: bool,
    }

    struct Gangstabet has store, key {
        id: 0x2::object::UID,
        number: u64,
        is_gangster: bool,
        character_class: 0x1::string::String,
        nft_library_id: u64,
        creation_date: u64,
        image_url: 0x1::string::String,
        token_uri: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        name: 0x1::string::String,
        skills: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    public fun get_character_class(arg0: &Gangstabet) : 0x1::string::String {
        arg0.character_class
    }

    public fun get_is_gangster(arg0: &Gangstabet) : bool {
        arg0.is_gangster
    }

    public fun get_name(arg0: &Gangstabet) : 0x1::string::String {
        arg0.name
    }

    public fun get_number(arg0: &Gangstabet) : u64 {
        arg0.number
    }

    public(friend) fun get_skill_at(arg0: &Gangstabet, arg1: u64) : (0x1::string::String, u64) {
        let (v0, v1) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, u64>(&arg0.skills, arg1);
        (*v0, *v1)
    }

    public fun get_skills(arg0: &Gangstabet) : &0x2::vec_map::VecMap<0x1::string::String, u64> {
        &arg0.skills
    }

    public(friend) fun get_skills_len(arg0: &Gangstabet) : u64 {
        0x2::vec_map::length<0x1::string::String, u64>(&arg0.skills)
    }

    fun init(arg0: GANGSTABET_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::new_admin<GANGSTABET_NFT>(&arg0, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::unique_nft::create_and_share<GANGSTABET_NFT>(&arg0, 5555, arg1);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::create_and_share_receipts<GANGSTABET_NFT>(&arg0, arg1);
        let v1 = 0x2::package::claim<GANGSTABET_NFT>(arg0, arg1);
        let v2 = 0x2::display::new<Gangstabet>(&v1, arg1);
        0x2::display::add<Gangstabet>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Gangstabet>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Gangstabet>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"GangstaBet #{number}"));
        0x2::display::add<Gangstabet>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://gangstabet.io"));
        0x2::display::update_version<Gangstabet>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<Gangstabet>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<GANGSTABET_NFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<GANGSTABET_NFT>>(0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::issue_minter<GANGSTABET_NFT>(&v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint_migrated(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<GANGSTABET_NFT>, arg1: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::Receipts<GANGSTABET_NFT>, arg2: &mut 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::unique_nft::Collection<GANGSTABET_NFT>, arg3: vector<u8>, arg4: u64, arg5: bool, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: vector<0x1::string::String>, arg12: vector<0x1::string::String>, arg13: 0x1::string::String, arg14: vector<0x1::string::String>, arg15: vector<u64>, arg16: address, arg17: &mut 0x2::tx_context::TxContext) {
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration::record<GANGSTABET_NFT>(arg0, arg1, arg3);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::unique_nft::account_migrated<GANGSTABET_NFT>(arg0, arg2, arg4, arg16);
        let v0 = Gangstabet{
            id              : 0x2::object::new(arg17),
            number          : arg4,
            is_gangster     : arg5,
            character_class : arg6,
            nft_library_id  : arg7,
            creation_date   : arg8,
            image_url       : arg9,
            token_uri       : arg10,
            attributes      : to_str_map(arg11, arg12),
            name            : arg13,
            skills          : to_u64_map(arg14, arg15),
        };
        0x2::transfer::public_transfer<Gangstabet>(v0, arg16);
    }

    public(friend) fun set_name_internal(arg0: &mut Gangstabet, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public(friend) fun set_skill_at(arg0: &mut Gangstabet, arg1: u64, arg2: u64) {
        let (_, v1) = 0x2::vec_map::get_entry_by_idx_mut<0x1::string::String, u64>(&mut arg0.skills, arg1);
        *v1 = arg2;
    }

    fun to_str_map(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<0x1::string::String>(&arg1), 13906834822883508226);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0, v1), *0x1::vector::borrow<0x1::string::String>(&arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun to_u64_map(arg0: vector<0x1::string::String>, arg1: vector<u64>) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<u64>(&arg1), 13906834874423115778);
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0, v1), *0x1::vector::borrow<u64>(&arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

