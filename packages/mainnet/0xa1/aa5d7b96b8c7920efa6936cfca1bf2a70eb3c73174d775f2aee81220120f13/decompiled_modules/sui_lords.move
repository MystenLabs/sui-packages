module 0xa1aa5d7b96b8c7920efa6936cfca1bf2a70eb3c73174d775f2aee81220120f13::sui_lords {
    struct SUI_LORDS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintControl has key {
        id: 0x2::object::UID,
        minted: u64,
        max_supply: u64,
        used_numbers: 0x2::vec_set::VecSet<u64>,
    }

    struct SuiLord has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        number: u64,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct MintEvent has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        recipient: address,
    }

    fun build_attributes(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg1), 1);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v2 = 0;
        while (v2 < v0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, *0x1::vector::borrow<0x1::string::String>(&arg0, v2), *0x1::vector::borrow<0x1::string::String>(&arg1, v2));
            v2 = v2 + 1;
        };
        v1
    }

    fun init(arg0: SUI_LORDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<SUI_LORDS>(arg0, arg1);
        let v2 = 0x2::display::new<SuiLord>(&v1, arg1);
        0x2::display::add<SuiLord>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SuiLord>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SuiLord>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<SuiLord>(&mut v2, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<SuiLord>(&mut v2, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"Sui Lords"));
        0x2::display::update_version<SuiLord>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<SuiLord>(&v1, arg1);
        let v5 = MintControl{
            id           : 0x2::object::new(arg1),
            minted       : 0,
            max_supply   : 341,
            used_numbers : 0x2::vec_set::empty<u64>(),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<SuiLord>>(v2, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SuiLord>>(v4, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SuiLord>>(v3);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, v0);
        0x2::transfer::share_object<MintControl>(v5);
    }

    public fun max_supply(arg0: &MintControl) : u64 {
        arg0.max_supply
    }

    public fun mint(arg0: &AdminCap, arg1: &mut MintControl, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.minted < arg1.max_supply, 0);
        assert!(arg2 >= 1 && arg2 <= arg1.max_supply, 2);
        assert!(!0x2::vec_set::contains<u64>(&arg1.used_numbers, &arg2), 3);
        arg1.minted = arg1.minted + 1;
        0x2::vec_set::insert<u64>(&mut arg1.used_numbers, arg2);
        let v0 = SuiLord{
            id          : 0x2::object::new(arg9),
            name        : 0x1::string::utf8(arg3),
            number      : arg2,
            description : 0x1::string::utf8(arg4),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg5),
            attributes  : build_attributes(arg6, arg7),
        };
        let v1 = MintEvent{
            object_id : 0x2::object::id<SuiLord>(&v0),
            number    : arg2,
            recipient : arg8,
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<SuiLord>(v0, arg8);
    }

    public fun remaining(arg0: &MintControl) : u64 {
        arg0.max_supply - arg0.minted
    }

    public fun total_minted(arg0: &MintControl) : u64 {
        arg0.minted
    }

    // decompiled from Move bytecode v6
}

