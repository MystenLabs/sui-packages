module 0xd832f06edf478f14569c732ea7a55b6170ab5195737920943a8316b340a0edb5::trade_log {
    struct TradeLoggedEvent has copy, drop, store {
        trade_id: vector<u8>,
        session_id: vector<u8>,
        mint_b58: 0x1::string::String,
        price_micro_usd: u64,
        wallet_score: u16,
        bucket: u8,
        sol_amount_lamports: u64,
        claimed_timestamp_ms: u64,
        sequence_number: u64,
        sui_consensus_timestamp_ms: u64,
    }

    struct BotSignerRotatedEvent has copy, drop, store {
        old_signer: address,
        new_signer: address,
        reason: vector<u8>,
        rotated_at_ms: u64,
    }

    public fun bucket_conviction() : u8 {
        2
    }

    public fun bucket_moonshot() : u8 {
        3
    }

    public fun bucket_safe() : u8 {
        0
    }

    public fun bucket_standard() : u8 {
        1
    }

    public fun log_signer_rotation(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: vector<u8>) {
        assert!(arg1 != arg2, 7);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 8);
        let v0 = BotSignerRotatedEvent{
            old_signer    : arg1,
            new_signer    : arg2,
            reason        : arg3,
            rotated_at_ms : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<BotSignerRotatedEvent>(v0);
    }

    public fun log_trade(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::string::String, arg4: u64, arg5: u16, arg6: u8, arg7: u64, arg8: u64, arg9: u64) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 3);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        assert!(arg6 <= 3, 1);
        assert!(arg5 <= 1000, 2);
        assert!(arg4 > 0, 5);
        assert!(arg7 > 0, 6);
        let v0 = TradeLoggedEvent{
            trade_id                   : arg1,
            session_id                 : arg2,
            mint_b58                   : arg3,
            price_micro_usd            : arg4,
            wallet_score               : arg5,
            bucket                     : arg6,
            sol_amount_lamports        : arg7,
            claimed_timestamp_ms       : arg8,
            sequence_number            : arg9,
            sui_consensus_timestamp_ms : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<TradeLoggedEvent>(v0);
    }

    public fun wallet_score_max() : u16 {
        1000
    }

    // decompiled from Move bytecode v7
}

