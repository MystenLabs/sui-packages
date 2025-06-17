module 0xbbafdba3370a06af21bd0d9f2ff1e82b05cb61388f53b3dab7c1a39fadee06aa::bluefin_ptb_wrapper {
    struct BluefinPTBExecuted has copy, drop {
        package_called: address,
        function_name: vector<u8>,
        sui_amount: u64,
        caller: address,
        pool_id: address,
    }

    public fun get_bluefin_ptb_config() : (address, address, address) {
        (@0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267, @0x3db251ba509a8d5d8777b6338836082335d93eecbdd09a11e190a1cff51c352, @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa)
    }

    public fun get_ptb_command_template() : vector<u8> {
        b"{ \"MoveCall\": { \"package\": \"0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267\", \"module\": \"pool\", \"function\": \"swap_assets\" }}"
    }

    public entry fun ptb_flash_swap_template(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        let v1 = BluefinPTBExecuted{
            package_called : @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267,
            function_name  : b"flash_swap",
            sui_amount     : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            caller         : v0,
            pool_id        : @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa,
        };
        0x2::event::emit<BluefinPTBExecuted>(v1);
    }

    public entry fun ptb_swap_sui_to_usdc_template(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        let v1 = BluefinPTBExecuted{
            package_called : @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267,
            function_name  : b"swap_assets",
            sui_amount     : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            caller         : v0,
            pool_id        : @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa,
        };
        0x2::event::emit<BluefinPTBExecuted>(v1);
    }

    // decompiled from Move bytecode v6
}

