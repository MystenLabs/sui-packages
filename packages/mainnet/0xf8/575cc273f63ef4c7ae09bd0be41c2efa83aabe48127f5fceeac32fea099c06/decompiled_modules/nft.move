module 0xf8575cc273f63ef4c7ae09bd0be41c2efa83aabe48127f5fceeac32fea099c06::nft {
    struct Admin has key {
        id: 0x2::object::UID,
        address: address,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        url: 0x2::url::Url,
        project_url: 0x2::url::Url,
        creator: 0x1::string::String,
        description: 0x1::string::String,
        name: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        index: u64,
    }

    struct Container has store, key {
        id: 0x2::object::UID,
        admin_address: address,
        minters: vector<address>,
        is_magic_enable: bool,
        attribute_container_id: 0x2::object::ID,
        total_minted: u64,
        total_magic: u64,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct AddMinterEvent has copy, drop {
        minter: address,
    }

    struct MinterEvent has copy, drop {
        minter: address,
        mint_amount: u64,
    }

    struct ChangeMagicEnableEvent has copy, drop {
        container: 0x2::object::ID,
        is_magic_enable: bool,
    }

    struct MagicEvent has copy, drop {
        nft_id: 0x2::object::ID,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public entry fun push_attributes(arg0: &Admin, arg1: &mut 0xf8575cc273f63ef4c7ae09bd0be41c2efa83aabe48127f5fceeac32fea099c06::attribute_module::AttributeContainer, arg2: vector<vector<0x1::string::String>>, arg3: vector<vector<0x1::string::String>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.address, 0);
        0xf8575cc273f63ef4c7ae09bd0be41c2efa83aabe48127f5fceeac32fea099c06::attribute_module::push_attributes(arg1, arg2, arg3, arg4);
    }

    public entry fun add_minter(arg0: &mut Admin, arg1: &mut Container, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.address, 0);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<address>(&arg1.minters)) {
            if (*0x1::vector::borrow<address>(&arg1.minters, v0) == arg2) {
                v1 = true;
            };
            v0 = v0 + 1;
        };
        if (v1 == false) {
            0x1::vector::push_back<address>(&mut arg1.minters, arg2);
        };
        let v2 = AddMinterEvent{minter: arg2};
        0x2::event::emit<AddMinterEvent>(v2);
    }

    public entry fun change_is_magic_enable(arg0: &mut Admin, arg1: &mut Container, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.address, 0);
        arg1.is_magic_enable = arg2;
        let v0 = ChangeMagicEnableEvent{
            container       : 0x2::object::id<Container>(arg1),
            is_magic_enable : arg2,
        };
        0x2::event::emit<ChangeMagicEnableEvent>(v0);
    }

    public entry fun deposit_to_launchpad(arg0: &mut Admin, arg1: &mut 0x5151614f962066a428471365e71ae0d5e4131cd77aaa1288486f3119ea0a02f5::launchpad_module::Launchpad, arg2: &mut Container, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.address, 0);
        let v0 = 0;
        let v1 = arg2.total_minted;
        while (v0 < arg3) {
            let v2 = Nft{
                id          : 0x2::object::new(arg9),
                url         : 0x2::url::new_unsafe(0x1::string::to_ascii(arg4)),
                project_url : 0x2::url::new_unsafe(0x1::string::to_ascii(arg5)),
                creator     : arg6,
                description : arg7,
                name        : arg8,
                attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
                index       : v1,
            };
            v1 = v1 + 1;
            v0 = v0 + 1;
            0x5151614f962066a428471365e71ae0d5e4131cd77aaa1288486f3119ea0a02f5::launchpad_module::deposit<Nft>(arg1, v2, arg9);
        };
        arg2.total_minted = arg2.total_minted + arg3;
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{
            id      : 0x2::object::new(arg1),
            address : 0x2::tx_context::sender(arg1),
        };
        let v1 = Container{
            id                     : 0x2::object::new(arg1),
            admin_address          : v0.address,
            minters                : 0x1::vector::empty<address>(),
            is_magic_enable        : false,
            attribute_container_id : 0xf8575cc273f63ef4c7ae09bd0be41c2efa83aabe48127f5fceeac32fea099c06::attribute_module::create_attribute_container(arg1),
            total_minted           : 0,
            total_magic            : 0,
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"img_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name} #{index}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{creator}"));
        let v6 = 0x2::package::claim<NFT>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<Nft>(&v6, v2, v4, arg1);
        0x2::display::update_version<Nft>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Admin>(v0);
        0x2::transfer::share_object<Container>(v1);
    }

    public entry fun magic(arg0: &mut Container, arg1: &mut 0xf8575cc273f63ef4c7ae09bd0be41c2efa83aabe48127f5fceeac32fea099c06::attribute_module::AttributeContainer, arg2: &mut Nft, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_magic_enable == true, 2);
        let v0 = 0xf8575cc273f63ef4c7ae09bd0be41c2efa83aabe48127f5fceeac32fea099c06::attribute_module::pop_attributes(arg1);
        let v1 = 0x1::string::utf8(b"image_url");
        let (_, v3) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0, &v1);
        arg2.url = 0x2::url::new_unsafe(0x1::string::to_ascii(v3));
        arg2.attributes = v0;
        arg0.total_magic = arg0.total_magic + 1;
        let v4 = MagicEvent{
            nft_id     : 0x2::object::id<Nft>(arg2),
            attributes : v0,
        };
        0x2::event::emit<MagicEvent>(v4);
    }

    public entry fun mint(arg0: &mut Admin, arg1: &mut Container, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = &mut arg1.minters;
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<address>(v1)) {
            if (*0x1::vector::borrow<address>(v1, v2) == v0) {
                v3 = true;
            };
            v2 = v2 + 1;
        };
        assert!(v3 == true || arg0.address == v0, 1);
        let v4 = 0;
        let v5 = arg1.total_minted;
        while (v4 < arg3) {
            let v6 = Nft{
                id          : 0x2::object::new(arg4),
                url         : 0x2::url::new_unsafe(0x1::string::to_ascii(0x1::string::utf8(b"https://shoshinsquare.infura-ipfs.io/ipfs/QmdqmDALRQLd4HwTfFgvbNYDj8oSizQ99LxUbs5gXmgc45"))),
                project_url : 0x2::url::new_unsafe(0x1::string::to_ascii(0x1::string::utf8(b"https://shoshinsquare.com"))),
                creator     : 0x1::string::utf8(b"Shoshin Square"),
                description : 0x1::string::utf8(b"Shoshin Zero NFT collection is a free-mint NFT certificate powered by Shoshin Square for the Shoshin's member to celerate the SUI mainnet."),
                name        : 0x1::string::utf8(b"Shoshin Zero"),
                attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
                index       : v5,
            };
            v5 = v5 + 1;
            v4 = v4 + 1;
            0x2::transfer::public_transfer<Nft>(v6, arg2);
        };
        let v7 = MinterEvent{
            minter      : arg2,
            mint_amount : arg3,
        };
        0x2::event::emit<MinterEvent>(v7);
        arg1.total_minted = arg1.total_minted + arg3;
    }

    public entry fun remove_minter(arg0: &mut Admin, arg1: &mut Container, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.address, 0);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<address>(&arg1.minters)) {
            if (*0x1::vector::borrow<address>(&arg1.minters, v0) == arg2) {
                v1 = true;
            };
            v0 = v0 + 1;
        };
        if (v1 == true) {
            0x1::vector::remove<address>(&mut arg1.minters, 0);
        };
        let v2 = AddMinterEvent{minter: arg2};
        0x2::event::emit<AddMinterEvent>(v2);
    }

    public entry fun transfer_admin(arg0: &mut Admin, arg1: &mut 0xf8575cc273f63ef4c7ae09bd0be41c2efa83aabe48127f5fceeac32fea099c06::attribute_module::AttributeContainer, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.address, 0);
        arg0.address = arg2;
        0xf8575cc273f63ef4c7ae09bd0be41c2efa83aabe48127f5fceeac32fea099c06::attribute_module::change_admin_address(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

