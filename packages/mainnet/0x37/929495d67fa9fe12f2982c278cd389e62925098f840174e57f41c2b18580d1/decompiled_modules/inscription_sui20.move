module 0x37929495d67fa9fe12f2982c278cd389e62925098f840174e57f41c2b18580d1::inscription_sui20 {
    struct INSCRIPTION_SUI20 has drop {
        dummy_field: bool,
    }

    struct InscriptionSui20Collection has store, key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        max: u64,
        amt: u64,
        lim: u64,
        current_mint: u64,
        uri: 0x1::string::String,
        description: 0x1::string::String,
        contents: vector<0x1::string::String>,
        content_size: u64,
        is_deploy: bool,
    }

    struct InscriptionSui20 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
        current_id: u64,
        description: 0x1::string::String,
        contents: vector<0x1::string::String>,
        content_size: u64,
    }

    struct InitEvent has copy, drop {
        sui20_collection: 0x2::object::ID,
    }

    public entry fun deploy(arg0: &mut 0x912e777a94bdfd9befda19c3999eb409d4f53041be8d7a30e668bdfe9bc80370::inscription::InscriptionData, arg1: &mut InscriptionSui20Collection, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<0x1::string::String>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_deploy, 0);
        0x912e777a94bdfd9befda19c3999eb409d4f53041be8d7a30e668bdfe9bc80370::inscription::deploy_sui20(arg0, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::object::id<InscriptionSui20Collection>(arg1), arg8, arg10);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg9);
        let v1 = 0;
        while (v0 > 0) {
            v1 = v1 + 0x1::string::length(0x1::vector::borrow<0x1::string::String>(&arg9, v0 - 1));
            v0 = v0 - 1;
        };
        arg1.tick = arg3;
        arg1.max = arg4;
        arg1.amt = arg5;
        arg1.lim = arg6;
        arg1.uri = arg7;
        arg1.description = arg8;
        arg1.contents = arg9;
        arg1.content_size = v1;
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
            amt          : 0,
            lim          : 0,
            current_mint : 0,
            uri          : 0x1::string::utf8(b""),
            description  : 0x1::string::utf8(b""),
            contents     : 0x1::vector::empty<0x1::string::String>(),
            content_size : 0,
            is_deploy    : false,
        };
        let v7 = InitEvent{sui20_collection: 0x2::object::id<InscriptionSui20Collection>(&v6)};
        0x2::event::emit<InitEvent>(v7);
        0x2::transfer::share_object<InscriptionSui20Collection>(v6);
    }

    public entry fun mint(arg0: &mut 0x912e777a94bdfd9befda19c3999eb409d4f53041be8d7a30e668bdfe9bc80370::inscription::InscriptionData, arg1: &mut 0x912e777a94bdfd9befda19c3999eb409d4f53041be8d7a30e668bdfe9bc80370::inscription::Fee, arg2: &mut InscriptionSui20Collection, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= arg2.lim, 0);
        assert!(arg2.current_mint + arg3 <= arg2.max / arg2.amt, 0);
        while (arg3 > 0) {
            let v0 = InscriptionSui20{
                id           : 0x2::object::new(arg5),
                name         : arg2.tick,
                url          : arg2.uri,
                current_id   : 0x912e777a94bdfd9befda19c3999eb409d4f53041be8d7a30e668bdfe9bc80370::inscription::get_total_inscription(arg0) + 1,
                description  : arg2.description,
                contents     : arg2.contents,
                content_size : arg2.content_size,
            };
            0x912e777a94bdfd9befda19c3999eb409d4f53041be8d7a30e668bdfe9bc80370::inscription::inscribe_sui20(arg0, arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, 0x912e777a94bdfd9befda19c3999eb409d4f53041be8d7a30e668bdfe9bc80370::inscription::get_sui20_fee(arg1), arg5), 0x2::object::id<InscriptionSui20>(&v0), arg2.tick, arg5);
            0x2::transfer::public_transfer<InscriptionSui20>(v0, 0x2::tx_context::sender(arg5));
            arg3 = arg3 - 1;
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        arg2.current_mint = arg2.current_mint + arg3;
    }

    // decompiled from Move bytecode v6
}

