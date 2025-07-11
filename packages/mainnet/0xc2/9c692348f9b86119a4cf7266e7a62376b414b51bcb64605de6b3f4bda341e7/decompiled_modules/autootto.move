module 0xc29c692348f9b86119a4cf7266e7a62376b414b51bcb64605de6b3f4bda341e7::autootto {
    struct AutoNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image: 0x1::string::String,
        image_text: 0x1::string::String,
        power: u64,
        timelap: u64,
        coef: u64,
        applied_upgrade: 0x1::option::Option<0x2::object::ID>,
    }

    public entry fun apply_upgrade(arg0: &mut AutoNft, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 2);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.applied_upgrade), 3);
        arg0.power = arg1;
        arg0.timelap = arg2;
        arg0.coef = arg3;
        arg0.applied_upgrade = 0x1::option::some<0x2::object::ID>(arg4);
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : AutoNft {
        AutoNft{
            id              : 0x2::object::new(arg7),
            name            : arg0,
            description     : arg1,
            image           : arg2,
            image_text      : arg3,
            power           : arg4,
            timelap         : arg5,
            coef            : arg6,
            applied_upgrade : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public entry fun mint_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 0);
        let v0 = mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<AutoNft>(v0, 0x2::tx_context::sender(arg7));
    }

    public entry fun update_image_and_text(arg0: &mut AutoNft, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x67936f5931aacd9b2241d049aa0e22328ff9375862e249012c743b51e747dded, 1);
        arg0.image = arg1;
        arg0.image_text = arg2;
    }

    // decompiled from Move bytecode v6
}

