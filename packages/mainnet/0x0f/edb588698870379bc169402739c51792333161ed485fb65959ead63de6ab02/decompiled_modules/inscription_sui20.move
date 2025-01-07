module 0xfedb588698870379bc169402739c51792333161ed485fb65959ead63de6ab02::inscription_sui20 {
    struct INSCRIPTION_SUI20 has drop {
        dummy_field: bool,
    }

    struct InscriptionSui20Collection has store, key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        max: u64,
        lim: u64,
        current_mint: u64,
        uri: 0x1::string::String,
        description: 0x1::string::String,
        inscription: 0x1::string::String,
        is_deploy: bool,
    }

    struct InscriptionSui20 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
        inscription_id: u64,
        description: 0x1::string::String,
    }

    struct InitEvent has copy, drop {
        sui20_collection: 0x2::object::ID,
    }

    public entry fun deploy(arg0: &mut 0xe944c987594fc663b6772832996b4d17e9b5f2bf42748eb38676f4c2c2fade37::inscription::InscriptionData, arg1: &mut InscriptionSui20Collection, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_deploy, 0);
        0xe944c987594fc663b6772832996b4d17e9b5f2bf42748eb38676f4c2c2fade37::inscription::deploy_sui20(arg0, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::object::id<InscriptionSui20Collection>(arg1), arg8, arg9, arg10);
        arg1.tick = arg3;
        arg1.max = arg4;
        arg1.lim = arg6;
        arg1.uri = arg7;
        arg1.description = arg8;
        arg1.inscription = arg9;
        arg1.is_deploy = true;
    }

    fun init(arg0: INSCRIPTION_SUI20, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<INSCRIPTION_SUI20>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://moveordinals.com"));
        let v5 = 0x2::display::new_with_fields<InscriptionSui20>(&v0, v1, v3, arg1);
        0x2::display::update_version<InscriptionSui20>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<InscriptionSui20>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = InscriptionSui20Collection{
            id           : 0x2::object::new(arg1),
            tick         : 0x1::string::utf8(b""),
            max          : 0,
            lim          : 0,
            current_mint : 0,
            uri          : 0x1::string::utf8(b""),
            description  : 0x1::string::utf8(b""),
            inscription  : 0x1::string::utf8(b""),
            is_deploy    : false,
        };
        let v7 = InitEvent{sui20_collection: 0x2::object::id<InscriptionSui20Collection>(&v6)};
        0x2::event::emit<InitEvent>(v7);
        0x2::transfer::share_object<InscriptionSui20Collection>(v6);
    }

    public entry fun mint(arg0: &mut 0xe944c987594fc663b6772832996b4d17e9b5f2bf42748eb38676f4c2c2fade37::inscription::InscriptionData, arg1: &mut 0xe944c987594fc663b6772832996b4d17e9b5f2bf42748eb38676f4c2c2fade37::inscription::Fee, arg2: &mut InscriptionSui20Collection, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= arg2.lim, 0);
        assert!(arg2.current_mint + arg3 <= arg2.max, 0);
        let v0 = 0x1::string::utf8(b"SUI20: ");
        0x1::string::append(&mut v0, arg2.tick);
        let v1 = arg2.description;
        0x1::string::append(&mut v1, 0x1::string::utf8(b" Minted by moveordinals.com"));
        while (arg3 > 0) {
            let v2 = InscriptionSui20{
                id             : 0x2::object::new(arg5),
                name           : v0,
                url            : arg2.uri,
                inscription_id : 0xe944c987594fc663b6772832996b4d17e9b5f2bf42748eb38676f4c2c2fade37::inscription::get_total_inscription(arg0) + 1,
                description    : v1,
            };
            0xe944c987594fc663b6772832996b4d17e9b5f2bf42748eb38676f4c2c2fade37::inscription::inscribe_sui20(arg0, arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, 0xe944c987594fc663b6772832996b4d17e9b5f2bf42748eb38676f4c2c2fade37::inscription::get_sui20_fee(arg1), arg5), 0x2::object::id<InscriptionSui20>(&v2), arg2.tick, arg5);
            0x2::transfer::public_transfer<InscriptionSui20>(v2, 0x2::tx_context::sender(arg5));
            arg3 = arg3 - 1;
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        arg2.current_mint = arg2.current_mint + arg3;
    }

    // decompiled from Move bytecode v6
}

