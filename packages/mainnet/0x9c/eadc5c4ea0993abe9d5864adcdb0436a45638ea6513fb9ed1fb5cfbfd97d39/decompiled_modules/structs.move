module 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::structs {
    struct ClaimInfo has store {
        claimed: bool,
        amount: u64,
    }

    struct RedPacket has store, key {
        id: 0x2::object::UID,
        creator: address,
        total_amount: u64,
        remaining_amount: u64,
        status: u8,
        claims: 0x2::table::Table<0x1::string::String, ClaimInfo>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        signer: vector<u8>,
        owner: address,
        red_packets: 0x2::table::Table<0x1::string::String, RedPacket>,
    }

    public fun add_red_packet_to_state(arg0: &mut State, arg1: 0x1::string::String, arg2: RedPacket) {
        0x2::table::add<0x1::string::String, RedPacket>(&mut arg0.red_packets, arg1, arg2);
    }

    public fun get_claim_info_amount(arg0: &ClaimInfo) : u64 {
        arg0.amount
    }

    public fun get_claim_info_claimed(arg0: &ClaimInfo) : bool {
        arg0.claimed
    }

    public fun get_red_packet_balance_mut(arg0: &mut RedPacket) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.balance
    }

    public fun get_red_packet_claims(arg0: &RedPacket) : &0x2::table::Table<0x1::string::String, ClaimInfo> {
        &arg0.claims
    }

    public fun get_red_packet_claims_mut(arg0: &mut RedPacket) : &mut 0x2::table::Table<0x1::string::String, ClaimInfo> {
        &mut arg0.claims
    }

    public fun get_red_packet_creator(arg0: &RedPacket) : address {
        arg0.creator
    }

    public fun get_red_packet_from_state(arg0: &State, arg1: 0x1::string::String) : &RedPacket {
        0x2::table::borrow<0x1::string::String, RedPacket>(&arg0.red_packets, arg1)
    }

    public fun get_red_packet_from_state_mut(arg0: &mut State, arg1: 0x1::string::String) : &mut RedPacket {
        0x2::table::borrow_mut<0x1::string::String, RedPacket>(&mut arg0.red_packets, arg1)
    }

    public fun get_red_packet_remaining_amount(arg0: &RedPacket) : u64 {
        arg0.remaining_amount
    }

    public fun get_red_packet_status(arg0: &RedPacket) : u8 {
        arg0.status
    }

    public fun get_red_packet_total_amount(arg0: &RedPacket) : u64 {
        arg0.total_amount
    }

    public fun get_state_owner(arg0: &State) : address {
        arg0.owner
    }

    public fun get_state_signer(arg0: &State) : vector<u8> {
        arg0.signer
    }

    public fun new_claim_info(arg0: bool, arg1: u64) : ClaimInfo {
        ClaimInfo{
            claimed : arg0,
            amount  : arg1,
        }
    }

    public fun new_red_packet(arg0: address, arg1: u64, arg2: u64, arg3: u8, arg4: 0x2::table::Table<0x1::string::String, ClaimInfo>, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : RedPacket {
        RedPacket{
            id               : 0x2::object::new(arg6),
            creator          : arg0,
            total_amount     : arg1,
            remaining_amount : arg2,
            status           : arg3,
            claims           : arg4,
            balance          : arg5,
        }
    }

    public fun new_state(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : State {
        State{
            id          : 0x2::object::new(arg2),
            signer      : arg0,
            owner       : arg1,
            red_packets : 0x2::table::new<0x1::string::String, RedPacket>(arg2),
        }
    }

    public fun set_claim_info_claimed(arg0: &mut ClaimInfo, arg1: bool) {
        arg0.claimed = arg1;
    }

    public fun set_red_packet_remaining_amount(arg0: &mut RedPacket, arg1: u64) {
        arg0.remaining_amount = arg1;
    }

    public fun set_red_packet_status(arg0: &mut RedPacket, arg1: u8) {
        arg0.status = arg1;
    }

    public fun set_state_owner(arg0: &mut State, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.owner = arg1;
    }

    public fun share_red_packet(arg0: RedPacket) {
        0x2::transfer::share_object<RedPacket>(arg0);
    }

    public fun share_state(arg0: State) {
        0x2::transfer::share_object<State>(arg0);
    }

    // decompiled from Move bytecode v6
}

