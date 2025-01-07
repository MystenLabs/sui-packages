module 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs {
    struct Panzerdog has store, key {
        id: 0x2::object::UID,
        game_id: 0x1::string::String,
        name: 0x1::string::String,
        clan: 0x1::string::String,
        dog_type: 0x1::string::String,
        level: u64,
        augment: 0x1::string::String,
        mutation: 0x1::string::String,
        image_hash: 0x1::string::String,
        gif_hash: 0x1::string::String,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        minting_limit: u64,
        minting_counter: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PANZERDOGS has drop {
        dummy_field: bool,
    }

    struct PanzerdogMinted has copy, drop {
        id: 0x2::object::ID,
        mint_cap_id: 0x2::object::ID,
        clan: 0x1::string::String,
        created_by: address,
    }

    struct MintCapPanzerdogCreated has copy, drop {
        id: 0x2::object::ID,
        authorizer: address,
        minting_limit: u64,
    }

    public fun authorize_address(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{
            id              : 0x2::object::new(arg3),
            minting_limit   : arg1,
            minting_counter : 0,
        };
        let v1 = MintCapPanzerdogCreated{
            id            : 0x2::object::id<MintCap>(&v0),
            authorizer    : 0x2::tx_context::sender(arg3),
            minting_limit : arg1,
        };
        0x2::event::emit<MintCapPanzerdogCreated>(v1);
        0x2::transfer::transfer<MintCap>(v0, arg2);
    }

    public fun create_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::display::is_authorized<Panzerdog>(arg0), 1);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{gif_hash}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A Panzerdog"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v4 = 0x2::display::new_with_fields<Panzerdog>(arg0, v0, v2, arg1);
        0x2::display::update_version<Panzerdog>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Panzerdog>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: PANZERDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PANZERDOGS>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minting_counter < arg0.minting_limit, 0);
        let v0 = Panzerdog{
            id         : 0x2::object::new(arg10),
            game_id    : arg1,
            name       : arg2,
            clan       : arg3,
            dog_type   : arg4,
            level      : 0,
            augment    : arg5,
            mutation   : arg6,
            image_hash : arg7,
            gif_hash   : arg8,
        };
        arg0.minting_counter = arg0.minting_counter + 1;
        let v1 = PanzerdogMinted{
            id          : 0x2::object::id<Panzerdog>(&v0),
            mint_cap_id : 0x2::object::id<MintCap>(arg0),
            clan        : arg3,
            created_by  : 0x2::tx_context::sender(arg10),
        };
        0x2::event::emit<PanzerdogMinted>(v1);
        0x2::transfer::transfer<Panzerdog>(v0, arg9);
    }

    public fun mint_ptb(arg0: &mut MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : Panzerdog {
        assert!(arg0.minting_counter < arg0.minting_limit, 0);
        let v0 = Panzerdog{
            id         : 0x2::object::new(arg9),
            game_id    : arg1,
            name       : arg2,
            clan       : arg3,
            dog_type   : arg4,
            level      : 0,
            augment    : arg5,
            mutation   : arg6,
            image_hash : arg7,
            gif_hash   : arg8,
        };
        arg0.minting_counter = arg0.minting_counter + 1;
        let v1 = PanzerdogMinted{
            id          : 0x2::object::id<Panzerdog>(&v0),
            mint_cap_id : 0x2::object::id<MintCap>(arg0),
            clan        : arg3,
            created_by  : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<PanzerdogMinted>(v1);
        v0
    }

    public fun mutate_image(arg0: &mut Panzerdog, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        assert!(!0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::item_lock::is_locked(uid(arg0)), 2);
        arg0.image_hash = arg1;
        arg0.gif_hash = arg2;
    }

    public fun uid(arg0: &Panzerdog) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Panzerdog) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public entry fun update_display_image(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::display::Display<Panzerdog>) {
        assert!(0x2::display::is_authorized<Panzerdog>(arg0), 1);
        0x2::display::edit<Panzerdog>(arg2, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::update_version<Panzerdog>(arg2);
    }

    // decompiled from Move bytecode v6
}

