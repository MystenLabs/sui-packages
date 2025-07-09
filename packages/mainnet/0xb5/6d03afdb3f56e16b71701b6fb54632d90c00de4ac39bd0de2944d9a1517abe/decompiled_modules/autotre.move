module 0xb56d03afdb3f56e16b71701b6fb54632d90c00de4ac39bd0de2944d9a1517abe::autotre {
    struct Auto has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        power: u64,
        timelap: u64,
        coef: u64,
        applied_upgrade: 0x1::option::Option<0x2::object::ID>,
    }

    struct MyNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_data: 0x1::string::String,
        image_text: 0x1::string::String,
    }

    public entry fun apply_upgrade(arg0: &mut Auto, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.applied_upgrade), 1);
        arg0.power = arg1;
        arg0.timelap = arg2;
        arg0.coef = arg3;
        arg0.applied_upgrade = 0x1::option::some<0x2::object::ID>(arg4);
    }

    public fun mint(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Auto {
        Auto{
            id              : 0x2::object::new(arg4),
            name            : arg0,
            power           : arg1,
            timelap         : arg2,
            coef            : arg3,
            applied_upgrade : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public entry fun mint_and_transfer(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0x67f534486a00978e8ea74d0c0cf4043e742ed13cbcc41511898ee7703851ba1d, 0);
        let v0 = mint(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<Auto>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun mint_my_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : MyNft {
        MyNft{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            image_data  : arg2,
            image_text  : arg3,
        }
    }

    public entry fun mint_my_nft_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0x67f534486a00978e8ea74d0c0cf4043e742ed13cbcc41511898ee7703851ba1d, 0);
        let v0 = mint_my_nft(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<MyNft>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

