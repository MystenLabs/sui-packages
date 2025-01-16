module 0x3287b47708c762359353b46bc5df077486d7d0bffcf8f535c339d202b70296d5::metadata {
    struct MetadataAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Metadata has store, key {
        id: 0x2::object::UID,
        ticket_name: 0x1::string::String,
        ticket_image_url: vector<u8>,
        tier_1_minimum: u64,
        tier_2_minimum: u64,
        tier_3_minimum: u64,
        tier_0_delay: u64,
        tier_1_delay: u64,
        tier_2_delay: u64,
        tier_3_delay: u64,
        tier_4_delay: u64,
    }

    struct MetadataChanged has copy, drop {
        sender: address,
        ticket_name: 0x1::string::String,
        ticket_image_url: vector<u8>,
        tier_1_minimum: u64,
        tier_2_minimum: u64,
        tier_3_minimum: u64,
        tier_0_delay: u64,
        tier_1_delay: u64,
        tier_2_delay: u64,
        tier_3_delay: u64,
        tier_4_delay: u64,
    }

    public(friend) fun get_metadata_props(arg0: &Metadata) : (0x1::string::String, vector<u8>, u64, u64, u64, u64, u64, u64, u64, u64) {
        (arg0.ticket_name, arg0.ticket_image_url, arg0.tier_1_minimum, arg0.tier_2_minimum, arg0.tier_3_minimum, arg0.tier_0_delay, arg0.tier_1_delay, arg0.tier_2_delay, arg0.tier_3_delay, arg0.tier_4_delay)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Metadata{
            id               : 0x2::object::new(arg0),
            ticket_name      : 0x1::string::utf8(b"Suidaos Launchpad Ticket"),
            ticket_image_url : b"https://suidaos.com/logo/suidaos.png",
            tier_1_minimum   : 50000000000000,
            tier_2_minimum   : 500000000000000,
            tier_3_minimum   : 1000000000000000,
            tier_0_delay     : 0,
            tier_1_delay     : 432000000,
            tier_2_delay     : 864000000,
            tier_3_delay     : 1296000000,
            tier_4_delay     : 2592000000,
        };
        0x2::transfer::share_object<Metadata>(v0);
        let v1 = MetadataAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<MetadataAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_metadata(arg0: &MetadataAdminCap, arg1: &mut Metadata, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        arg1.ticket_name = arg2;
        arg1.ticket_image_url = arg3;
        arg1.tier_1_minimum = arg4;
        arg1.tier_2_minimum = arg5;
        arg1.tier_3_minimum = arg6;
        arg1.tier_0_delay = arg7;
        arg1.tier_1_delay = arg8;
        arg1.tier_2_delay = arg9;
        arg1.tier_3_delay = arg10;
        arg1.tier_4_delay = arg11;
        let v0 = MetadataChanged{
            sender           : 0x2::tx_context::sender(arg12),
            ticket_name      : arg2,
            ticket_image_url : arg3,
            tier_1_minimum   : arg4,
            tier_2_minimum   : arg5,
            tier_3_minimum   : arg6,
            tier_0_delay     : arg7,
            tier_1_delay     : arg8,
            tier_2_delay     : arg9,
            tier_3_delay     : arg10,
            tier_4_delay     : arg11,
        };
        0x2::event::emit<MetadataChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

