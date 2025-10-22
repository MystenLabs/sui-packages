module 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::defi_rewards {
    struct DefiRewardActivated has copy, drop {
        game_id: address,
        player: address,
        player_index: u8,
        protocol: vector<u8>,
        cash_rewarded: u64,
        income_multiplier: u64,
        already_activated: bool,
    }

    public fun activate_navi_reward(arg0: &mut 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::game::Game, arg1: 0x2377de485d8fc4d4f0e8e2e93f36b02ea30c6e3118a2af86b5839984867f14ce::defi_proof::NaviProof, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2377de485d8fc4d4f0e8e2e93f36b02ea30c6e3118a2af86b5839984867f14ce::defi_proof::consume_navi_proof(arg1);
        let v1 = 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::game::find_player_index(arg0, v0);
        assert!(v1 != 255, 9002);
        let v2 = 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::game::apply_defi_reward(arg0, v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::BUFF_NAVI_INCOME_BOOST(), arg2);
        let v3 = if (v2) {
            2000
        } else {
            0
        };
        let v4 = DefiRewardActivated{
            game_id           : 0x2::object::uid_to_address(0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::game::game_uid(arg0)),
            player            : v0,
            player_index      : v1,
            protocol          : b"Navi",
            cash_rewarded     : v3,
            income_multiplier : 150,
            already_activated : !v2,
        };
        0x2::event::emit<DefiRewardActivated>(v4);
    }

    public fun activate_scallop_reward(arg0: &mut 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::game::Game, arg1: 0x2377de485d8fc4d4f0e8e2e93f36b02ea30c6e3118a2af86b5839984867f14ce::defi_proof::ScallopProof, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2377de485d8fc4d4f0e8e2e93f36b02ea30c6e3118a2af86b5839984867f14ce::defi_proof::consume_scallop_proof(arg1);
        let v1 = 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::game::find_player_index(arg0, v0);
        assert!(v1 != 255, 9002);
        let v2 = 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::game::apply_defi_reward(arg0, v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::BUFF_SCALLOP_INCOME_BOOST(), arg2);
        let v3 = if (v2) {
            2000
        } else {
            0
        };
        let v4 = DefiRewardActivated{
            game_id           : 0x2::object::uid_to_address(0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::game::game_uid(arg0)),
            player            : v0,
            player_index      : v1,
            protocol          : b"Scallop",
            cash_rewarded     : v3,
            income_multiplier : 150,
            already_activated : !v2,
        };
        0x2::event::emit<DefiRewardActivated>(v4);
    }

    // decompiled from Move bytecode v6
}

