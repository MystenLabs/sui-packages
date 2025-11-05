module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tool_upgrade {
    struct ToolUpgradeAttempted has copy, drop {
        tool_id: 0x2::object::ID,
        user: address,
        old_tier: 0x1::string::String,
        new_tier: 0x1::string::String,
        success: bool,
        crystal_cost: u64,
        donation_type: 0x1::string::String,
        donation_amount: u64,
        sacrifice_count: u64,
        total_success_rate: u64,
        dft_reward: u64,
        roll: u64,
    }

    struct ToolSacrificed has copy, drop {
        sacrifice_tool_id: 0x2::object::ID,
        sacrifice_tier: 0x1::string::String,
        sacrifice_quality: u64,
        boost_contribution: u64,
    }

    struct SacrificeInfo has copy, drop {
        tool_id: 0x2::object::ID,
        tier: 0x1::string::String,
        quality: u64,
        boost: u64,
    }

    public entry fun upgrade_tool_basic(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg5: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg6: &0x2::token::TokenPolicy<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun upgrade_tool_basic_v2(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg5: &mut 0x2::transfer_policy::TransferPolicy<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::TOOL>, arg6: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg7: vector<0x2::object::ID>, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun upgrade_tool_with_dft_donation(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::token::Token<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg5: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg6: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg7: &0x2::token::TokenPolicy<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    public entry fun upgrade_tool_with_sui_donation(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal::PAWTATO_COIN_CRYSTAL>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_tools::ToolCollection, arg6: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg7: &0x2::token::TokenPolicy<0xd72ab42db7dfe82f07858fd4af0d821c939b037b51200554256ed0446b488db::pawtato_coin_divine_favor_token::PAWTATO_COIN_DIVINE_FAVOR_TOKEN>, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_unsupported_function()
    }

    // decompiled from Move bytecode v6
}

