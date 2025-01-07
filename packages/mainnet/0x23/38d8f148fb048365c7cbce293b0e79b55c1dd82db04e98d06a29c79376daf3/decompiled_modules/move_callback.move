module 0x2338d8f148fb048365c7cbce293b0e79b55c1dd82db04e98d06a29c79376daf3::move_callback {
    struct MOVE_CALLBACK has drop {
        dummy_field: bool,
    }

    struct JarJarNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        total_minted: u64,
        max_supply: u64,
    }

    public fun callback(arg0: 0x1::string::String, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::jarjar_ai_oracle::OwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::jarjar_ai_oracle::get_owner_cap_address(arg4), 2);
        let v0 = JarJarNFT{
            id          : 0x2::object::new(arg5),
            name        : arg2,
            image_url   : arg0,
            description : arg3,
        };
        0x2::transfer::public_transfer<JarJarNFT>(v0, arg1);
    }

    public fun generate(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::price_model::PriceModel, arg5: &mut 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::jarjar_ai_oracle::OwnerCap, arg6: 0x1::option::Option<0x2338d8f148fb048365c7cbce293b0e79b55c1dd82db04e98d06a29c79376daf3::free_mint::JarJarFreemint>, arg7: &mut MintCap, arg8: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<0x2338d8f148fb048365c7cbce293b0e79b55c1dd82db04e98d06a29c79376daf3::free_mint::JarJarFreemint>(&arg6)) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 5000000000, 1);
            assert!(arg7.total_minted < arg7.max_supply, 3);
        } else {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 100000000, 1);
        };
        0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::jarjar_ai_oracle::generate(arg0, arg1, arg2, 0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg3), 100000000, arg8), arg4, arg5, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0xf74a927c2fe57604e0dd07907a9f62d74d7b5b1b466381abdbcd0ee18683d125::jarjar_ai_oracle::get_owner_cap_address(arg5));
        0x2338d8f148fb048365c7cbce293b0e79b55c1dd82db04e98d06a29c79376daf3::free_mint::destroy_ticket(arg6);
        arg7.total_minted = arg7.total_minted + 1;
    }

    public fun get_mint_status(arg0: &MintCap) : (u64, u64) {
        (arg0.total_minted, arg0.max_supply + 100)
    }

    fun init(arg0: MOVE_CALLBACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://jarjar.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://x.com/JARJARxyz"));
        let v4 = 0x2::package::claim<MOVE_CALLBACK>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<JarJarNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<JarJarNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<JarJarNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = MintCap{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
            max_supply   : 400,
        };
        0x2::transfer::share_object<MintCap>(v6);
    }

    // decompiled from Move bytecode v6
}

