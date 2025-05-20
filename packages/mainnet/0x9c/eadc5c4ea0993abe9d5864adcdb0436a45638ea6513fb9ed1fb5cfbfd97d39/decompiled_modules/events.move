module 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::events {
    struct RedPacketCreated has copy, drop {
        uuid: 0x1::string::String,
        creator: address,
        total_amount: u64,
        github_ids: vector<0x1::string::String>,
        amounts: vector<u64>,
    }

    struct RedPacketClaimed has copy, drop {
        uuid: 0x1::string::String,
        github_id: 0x1::string::String,
        claimer: address,
        amount: u64,
    }

    struct RedPacketRefunded has copy, drop {
        uuid: 0x1::string::String,
        creator: address,
        refund_amount: u64,
    }

    public fun emit_red_packet_claimed(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: u64) {
        let v0 = RedPacketClaimed{
            uuid      : arg0,
            github_id : arg1,
            claimer   : arg2,
            amount    : arg3,
        };
        0x2::event::emit<RedPacketClaimed>(v0);
    }

    public fun emit_red_packet_created(arg0: 0x1::string::String, arg1: address, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<u64>) {
        let v0 = RedPacketCreated{
            uuid         : arg0,
            creator      : arg1,
            total_amount : arg2,
            github_ids   : arg3,
            amounts      : arg4,
        };
        0x2::event::emit<RedPacketCreated>(v0);
    }

    public fun emit_red_packet_refunded(arg0: 0x1::string::String, arg1: address, arg2: u64) {
        let v0 = RedPacketRefunded{
            uuid          : arg0,
            creator       : arg1,
            refund_amount : arg2,
        };
        0x2::event::emit<RedPacketRefunded>(v0);
    }

    // decompiled from Move bytecode v6
}

