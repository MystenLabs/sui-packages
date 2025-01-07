module 0xb68785fe12f8fd68602cc7e7a88c2ef7ee8c333ed5fd6018677a2ac66fceeabe::trophy {
    struct TrophyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        id_detials: 0x2::vec_map::VecMap<0x2::object::ID, Attributes>,
        fraction_exist: 0x2::vec_map::VecMap<u64, 0x2::object::ID>,
    }

    struct Attributes has copy, drop, store {
        fraction_id: u64,
        shipment_status: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TROPHY has drop {
        dummy_field: bool,
    }

    public fun id(arg0: &TrophyNFT) : 0x2::object::ID {
        0x2::object::id<TrophyNFT>(arg0)
    }

    public fun url(arg0: &TrophyNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun fraction_id(arg0: &TrophyNFT, arg1: &NFTInfo) : u64 {
        let v0 = 0x2::object::id<TrophyNFT>(arg0);
        0x2::vec_map::get<0x2::object::ID, Attributes>(&arg1.id_detials, &v0).fraction_id
    }

    public fun attributes(arg0: &TrophyNFT, arg1: &NFTInfo) : Attributes {
        let v0 = 0x2::object::id<TrophyNFT>(arg0);
        *0x2::vec_map::get<0x2::object::ID, Attributes>(&arg1.id_detials, &v0)
    }

    public entry fun burn(arg0: TrophyNFT, arg1: &mut NFTInfo, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<TrophyNFT>(&arg0);
        let (_, v2) = 0x2::vec_map::remove<0x2::object::ID, Attributes>(&mut arg1.id_detials, &v0);
        let v3 = v2;
        let (_, _) = 0x2::vec_map::remove<u64, 0x2::object::ID>(&mut arg1.fraction_exist, &v3.fraction_id);
        let TrophyNFT {
            id   : v6,
            name : _,
            url  : _,
        } = arg0;
        0x2::object::delete(v6);
        0xb68785fe12f8fd68602cc7e7a88c2ef7ee8c333ed5fd6018677a2ac66fceeabe::base_nft::emit_burn_nft<TrophyNFT>(v0);
    }

    fun check_fraction_exist(arg0: &NFTInfo, arg1: u64) : bool {
        0x2::vec_map::contains<u64, 0x2::object::ID>(&arg0.fraction_exist, &arg1)
    }

    public fun fraction_to_nft_id(arg0: u64, arg1: &NFTInfo) : 0x2::object::ID {
        *0x2::vec_map::get<u64, 0x2::object::ID>(&arg1.fraction_exist, &arg0)
    }

    fun init(arg0: TROPHY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Artfi"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Artfi NFT"));
        let v4 = 0x2::package::claim<TROPHY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TrophyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<TrophyNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TrophyNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = NFTInfo{
            id             : 0x2::object::new(arg1),
            name           : 0x1::string::utf8(b"Artfi"),
            id_detials     : 0x2::vec_map::empty<0x2::object::ID, Attributes>(),
            fraction_exist : 0x2::vec_map::empty<u64, 0x2::object::ID>(),
        };
        0x2::transfer::share_object<NFTInfo>(v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
    }

    fun mint_func(arg0: &mut NFTInfo, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : TrophyNFT {
        let v0 = TrophyNFT{
            id   : 0x2::object::new(arg3),
            name : arg0.name,
            url  : 0x2::url::new_unsafe_from_bytes(arg1),
        };
        let v1 = 0x2::object::id<TrophyNFT>(&v0);
        let v2 = Attributes{
            fraction_id     : arg2,
            shipment_status : 0x1::string::utf8(b""),
        };
        0x2::vec_map::insert<0x2::object::ID, Attributes>(&mut arg0.id_detials, v1, v2);
        0x2::vec_map::insert<u64, 0x2::object::ID>(&mut arg0.fraction_exist, arg2, v1);
        v0
    }

    public entry fun mint_nft(arg0: &mut NFTInfo, arg1: &0xb68785fe12f8fd68602cc7e7a88c2ef7ee8c333ed5fd6018677a2ac66fceeabe::nft::ArtfiNFT, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb68785fe12f8fd68602cc7e7a88c2ef7ee8c333ed5fd6018677a2ac66fceeabe::nft::fraction_id(arg1);
        assert!(check_fraction_exist(arg0, v0) == false, 1);
        let v1 = mint_func(arg0, arg2, v0, arg3);
        0xb68785fe12f8fd68602cc7e7a88c2ef7ee8c333ed5fd6018677a2ac66fceeabe::base_nft::emit_mint_nft(0x2::object::id<TrophyNFT>(&v1), 0x2::tx_context::sender(arg3), arg0.name);
        0x2::transfer::public_transfer<TrophyNFT>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &TrophyNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun shipment_status(arg0: &TrophyNFT, arg1: &NFTInfo) : 0x1::string::String {
        let v0 = 0x2::object::id<TrophyNFT>(arg0);
        0x2::vec_map::get<0x2::object::ID, Attributes>(&arg1.id_detials, &v0).shipment_status
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        0xb68785fe12f8fd68602cc7e7a88c2ef7ee8c333ed5fd6018677a2ac66fceeabe::base_nft::emit_transfer_object<AdminCap>(0x2::object::id<AdminCap>(&arg0), arg1);
    }

    public entry fun transfer_nft(arg0: TrophyNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<TrophyNFT>(arg0, arg1);
        0xb68785fe12f8fd68602cc7e7a88c2ef7ee8c333ed5fd6018677a2ac66fceeabe::base_nft::emit_transfer_object<TrophyNFT>(0x2::object::id<TrophyNFT>(&arg0), arg1);
    }

    public entry fun update_attribute(arg0: &AdminCap, arg1: &mut NFTInfo, arg2: 0x2::object::ID, arg3: 0x1::string::String) {
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, Attributes>(&mut arg1.id_detials, &arg2);
        v0.shipment_status = arg3;
        0xb68785fe12f8fd68602cc7e7a88c2ef7ee8c333ed5fd6018677a2ac66fceeabe::base_nft::emit_update_attributes<0x2::object::ID, Attributes>(arg2, *v0);
    }

    public fun update_metadata(arg0: &AdminCap, arg1: &mut 0x2::display::Display<TrophyNFT>, arg2: &mut NFTInfo, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        0x2::display::edit<TrophyNFT>(arg1, 0x1::string::utf8(b"name"), arg4);
        0x2::display::edit<TrophyNFT>(arg1, 0x1::string::utf8(b"description"), arg3);
        arg2.name = arg4;
        0x2::display::update_version<TrophyNFT>(arg1);
        0xb68785fe12f8fd68602cc7e7a88c2ef7ee8c333ed5fd6018677a2ac66fceeabe::base_nft::emit_metadat_update(arg4, arg3);
    }

    // decompiled from Move bytecode v6
}

