module 0x4f3ae969f16389f668debcdc84105025e046d90f4f5b79e5e639b0a47f2c43e4::events {
    struct UpdateFlashMintConfig has copy, drop {
        config_id: 0x2::object::ID,
        partner_address: 0x1::option::Option<address>,
        fee_rate_bps: u64,
        max_amount: u64,
    }

    struct FlashMint has copy, drop {
        partner_address: 0x1::option::Option<address>,
        value: u64,
        fee_amount: u64,
    }

    public(friend) fun emit_flash_mint(arg0: 0x1::option::Option<address>, arg1: u64, arg2: u64) {
        let v0 = FlashMint{
            partner_address : arg0,
            value           : arg1,
            fee_amount      : arg2,
        };
        0x2::event::emit<FlashMint>(v0);
    }

    public(friend) fun emit_update_flash_mint_config(arg0: 0x2::object::ID, arg1: 0x1::option::Option<address>, arg2: u64, arg3: u64) {
        let v0 = UpdateFlashMintConfig{
            config_id       : arg0,
            partner_address : arg1,
            fee_rate_bps    : arg2,
            max_amount      : arg3,
        };
        0x2::event::emit<UpdateFlashMintConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

