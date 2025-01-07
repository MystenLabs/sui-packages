module 0xa6decb2504c10fdd45aa0fb0056423237d198939197e67bca1e467260b321a33::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct Nft<T0: drop + store> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        properties: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        meta: 0x1::option::Option<T0>,
        inscriptions: vector<vector<u8>>,
    }

    struct NftCap<phantom T0: drop + store> has store, key {
        id: 0x2::object::UID,
        publisher_id: 0x2::object::ID,
        max_supply: u64,
        minted: u64,
    }

    struct UpdateNftCap<phantom T0: drop + store> has store, key {
        id: 0x2::object::UID,
        token_id: 0x2::object::ID,
    }

    struct BurnNftCap<phantom T0: drop + store> has store, key {
        id: 0x2::object::UID,
        token_id: 0x2::object::ID,
    }

    struct MintNftEvent has copy, drop {
        id: 0x2::object::ID,
        type: 0x1::type_name::TypeName,
        price: u64,
    }

    struct BurnNftEvent has copy, drop {
        id: 0x2::object::ID,
        type: 0x1::type_name::TypeName,
    }

    struct UpdateNftEvent has copy, drop {
        id: 0x2::object::ID,
        type: 0x1::type_name::TypeName,
    }

    public fun burn<T0: drop + store>(arg0: BurnNftCap<T0>, arg1: Nft<T0>) {
        let BurnNftCap {
            id       : v0,
            token_id : v1,
        } = arg0;
        let v2 = 0x2::object::id<Nft<T0>>(&arg1);
        let Nft {
            id           : v3,
            name         : _,
            description  : _,
            image_url    : _,
            properties   : _,
            meta         : _,
            inscriptions : _,
        } = arg1;
        assert!(v1 == v2, 4);
        0x2::object::delete(v3);
        0x2::object::delete(v0);
        let v10 = BurnNftEvent{
            id   : v2,
            type : 0x1::type_name::get<Nft<T0>>(),
        };
        0x2::event::emit<BurnNftEvent>(v10);
    }

    public(friend) fun create_update_ntf_cap<T0: drop + store>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<UpdateNftCap<T0>> {
        let v0 = UpdateNftCap<T0>{
            id       : 0x2::object::new(arg1),
            token_id : arg0,
        };
        0x1::option::some<UpdateNftCap<T0>>(v0)
    }

    fun format_properties(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg1), 3);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v2 = 0;
        while (v2 < v0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, *0x1::vector::borrow<0x1::string::String>(&arg0, v2), *0x1::vector::borrow<0x1::string::String>(&arg1, v2));
            v2 = v2 + 1;
        };
        v1
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<NFT>(arg0, arg1);
    }

    public fun mint<T0: drop + store>(arg0: &mut NftCap<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: 0x1::option::Option<T0>, arg7: 0x1::option::Option<address>, arg8: vector<vector<u8>>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.max_supply == 0 || arg0.max_supply > arg0.minted, 2);
        let v0 = Nft<T0>{
            id           : 0x2::object::new(arg10),
            name         : arg1,
            description  : arg2,
            image_url    : arg3,
            properties   : format_properties(arg4, arg5),
            meta         : arg6,
            inscriptions : arg8,
        };
        let v1 = 0x2::object::id<Nft<T0>>(&v0);
        arg0.minted = arg0.minted + 1;
        let v2 = if (0x1::option::is_none<address>(&arg7)) {
            0x2::tx_context::sender(arg10)
        } else {
            *0x1::option::borrow<address>(&arg7)
        };
        let v3 = BurnNftCap<T0>{
            id       : 0x2::object::new(arg10),
            token_id : v1,
        };
        0x2::transfer::public_transfer<Nft<T0>>(v0, v2);
        0x2::transfer::public_transfer<BurnNftCap<T0>>(v3, v2);
        let v4 = MintNftEvent{
            id    : v1,
            type  : 0x1::type_name::get<Nft<T0>>(),
            price : arg9,
        };
        0x2::event::emit<MintNftEvent>(v4);
        v1
    }

    public fun mint_into_kiosk<T0: drop + store>(arg0: &mut NftCap<T0>, arg1: &0x2::transfer_policy::TransferPolicy<Nft<T0>>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: 0x1::option::Option<T0>, arg8: 0x1::option::Option<address>, arg9: vector<vector<u8>>, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.max_supply == 0 || arg0.max_supply > arg0.minted, 2);
        let v0 = Nft<T0>{
            id           : 0x2::object::new(arg11),
            name         : arg2,
            description  : arg3,
            image_url    : arg4,
            properties   : format_properties(arg5, arg6),
            meta         : arg7,
            inscriptions : arg9,
        };
        let v1 = 0x2::object::id<Nft<T0>>(&v0);
        arg0.minted = arg0.minted + 1;
        let v2 = if (0x1::option::is_none<address>(&arg8)) {
            0x2::tx_context::sender(arg11)
        } else {
            *0x1::option::borrow<address>(&arg8)
        };
        let (v3, v4) = 0x2::kiosk::new(arg11);
        let v5 = v4;
        let v6 = v3;
        0x2::kiosk::set_owner_custom(&mut v6, &v5, v2);
        0x2::kiosk::lock<Nft<T0>>(&mut v6, &v5, arg1, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v6);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v5, v2);
        let v7 = MintNftEvent{
            id    : v1,
            type  : 0x1::type_name::get<Nft<T0>>(),
            price : arg10,
        };
        0x2::event::emit<MintNftEvent>(v7);
        v1
    }

    public fun register_nft_type<T0: drop + store>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u16, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (NftCap<T0>, 0x2::display::Display<Nft<T0>>, 0x2::transfer_policy::TransferPolicy<Nft<T0>>, 0x2::transfer_policy::TransferPolicyCap<Nft<T0>>) {
        let v0 = 0x2::display::new<Nft<T0>>(arg0, arg4);
        0x2::display::add<Nft<T0>>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft<T0>>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Nft<T0>>(&mut v0, 0x1::string::utf8(b"properties"), 0x1::string::utf8(b"{properties}"));
        0x2::display::update_version<Nft<T0>>(&mut v0);
        let (v1, v2) = 0x2::transfer_policy::new<Nft<T0>>(arg0, arg4);
        let v3 = v2;
        let v4 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Nft<T0>>(&mut v4, &v3);
        if (arg2 > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft<T0>>(&mut v4, &v3, arg2, arg3);
        };
        let v5 = NftCap<T0>{
            id           : 0x2::object::new(arg4),
            publisher_id : 0x2::object::id<0x2::package::Publisher>(arg0),
            max_supply   : arg1,
            minted       : 0,
        };
        (v5, v0, v4, v3)
    }

    public fun update<T0: drop + store>(arg0: UpdateNftCap<T0>, arg1: &mut Nft<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>) {
        let UpdateNftCap {
            id       : v0,
            token_id : v1,
        } = arg0;
        assert!(0x2::object::id<Nft<T0>>(arg1) == v1, 4);
        0x2::object::delete(v0);
        if (!0x1::string::is_empty(&arg2)) {
            arg1.name = arg2;
        };
        if (!0x1::string::is_empty(&arg3)) {
            arg1.description = arg3;
        };
        if (!0x1::string::is_empty(&arg4)) {
            arg1.image_url = arg4;
        };
        if (!0x1::vector::is_empty<0x1::string::String>(&arg5) && !0x1::vector::is_empty<0x1::string::String>(&arg6)) {
            arg1.properties = format_properties(arg5, arg6);
        };
        let v2 = UpdateNftEvent{
            id   : v1,
            type : 0x1::type_name::get<Nft<T0>>(),
        };
        0x2::event::emit<UpdateNftEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

