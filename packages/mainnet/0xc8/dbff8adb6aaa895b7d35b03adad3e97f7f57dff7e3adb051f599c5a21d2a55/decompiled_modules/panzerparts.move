module 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerparts {
    struct PANZERPARTS has drop {
        dummy_field: bool,
    }

    struct PanzerPart has store, key {
        id: 0x2::object::UID,
        game_id: 0x1::string::String,
        name: 0x1::string::String,
        type: 0x1::string::String,
        rarity: 0x1::string::String,
        rank: u64,
        manufacturer: 0x1::string::String,
        level: u64,
    }

    struct MintCapPanzerParts has store, key {
        id: 0x2::object::UID,
        minting_limit: u64,
        minting_counter: u64,
    }

    struct PanzerPartMinted has copy, drop {
        id: 0x2::object::ID,
        mint_cap_id: 0x2::object::ID,
        created_by: address,
    }

    struct MintCapPanzerPartCreated has copy, drop {
        id: 0x2::object::ID,
        authorizer: address,
        minting_limit: u64,
    }

    public fun authorize_address(arg0: &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCapPanzerParts{
            id              : 0x2::object::new(arg3),
            minting_limit   : arg1,
            minting_counter : 0,
        };
        let v1 = MintCapPanzerPartCreated{
            id            : 0x2::object::id<MintCapPanzerParts>(&v0),
            authorizer    : 0x2::tx_context::sender(arg3),
            minting_limit : arg1,
        };
        0x2::event::emit<MintCapPanzerPartCreated>(v1);
        0x2::transfer::transfer<MintCapPanzerParts>(v0, arg2);
    }

    public fun create_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{type}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Parts for your Tank"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v4 = 0x2::display::new_with_fields<PanzerPart>(arg0, v0, v2, arg1);
        let v5 = 0x1::string::utf8(b"ipfs://QmboRMjYWntuzgRS5ztkMS5fYBR7D5cGhJjMxRXZQgVK8u/");
        0x1::string::append(&mut v5, 0x1::string::utf8(b"{type}"));
        0x1::string::append(&mut v5, 0x1::string::utf8(b"/{game_id}.png"));
        0x2::display::add<PanzerPart>(&mut v4, 0x1::string::utf8(b"image_url"), v5);
        0x2::display::update_version<PanzerPart>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<PanzerPart>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: PANZERPARTS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PANZERPARTS>(arg0, arg1);
    }

    public fun mint(arg0: &mut MintCapPanzerParts, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minting_counter < arg0.minting_limit, 0);
        let v0 = PanzerPart{
            id           : 0x2::object::new(arg8),
            game_id      : arg1,
            name         : arg2,
            type         : arg3,
            rarity       : arg4,
            rank         : arg5,
            manufacturer : arg6,
            level        : 0,
        };
        arg0.minting_counter = arg0.minting_counter + 1;
        let v1 = PanzerPartMinted{
            id          : 0x2::object::id<PanzerPart>(&v0),
            mint_cap_id : 0x2::object::id<MintCapPanzerParts>(arg0),
            created_by  : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<PanzerPartMinted>(v1);
        0x2::transfer::public_transfer<PanzerPart>(v0, arg7);
    }

    public fun mint_ptb(arg0: &mut MintCapPanzerParts, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : PanzerPart {
        assert!(arg0.minting_counter < arg0.minting_limit, 0);
        let v0 = PanzerPart{
            id           : 0x2::object::new(arg7),
            game_id      : arg1,
            name         : arg2,
            type         : arg3,
            rarity       : arg4,
            rank         : arg5,
            manufacturer : arg6,
            level        : 0,
        };
        arg0.minting_counter = arg0.minting_counter + 1;
        let v1 = PanzerPartMinted{
            id          : 0x2::object::id<PanzerPart>(&v0),
            mint_cap_id : 0x2::object::id<MintCapPanzerParts>(arg0),
            created_by  : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<PanzerPartMinted>(v1);
        v0
    }

    public(friend) fun uid_mut(arg0: &mut PanzerPart) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public entry fun update_display_image(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::display::Display<PanzerPart>) {
        assert!(0x2::display::is_authorized<PanzerPart>(arg0), 1);
        0x2::display::edit<PanzerPart>(arg2, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::update_version<PanzerPart>(arg2);
    }

    // decompiled from Move bytecode v6
}

